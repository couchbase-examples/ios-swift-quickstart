import CouchbaseLiteSwift

class DatabaseManager {
    static let shared = DatabaseManager()
    var replicator: Replicator?
    var database: Database?
    
    init() {
        Database.log.console.level = .debug
        initializeDatabase()
    }
    
    private func initializeDatabase() {
        do {
            try getStartedWithReplication(replication: true)
        } catch {
            fatalError("Error initializing database")
        }
    }
    
    func queryAllElements() -> [Hotel]? {
        do {
            guard let collection = try database?.createCollection(name: "hotel", scope: "inventory") else { return nil }
            let query = QueryBuilder
                .select(SelectResult.all())
                .from(DataSource.collection(collection))
            let results = try query.execute()
            var hotels: [Hotel] = []
            for result in results {
               let hotelDocumentModel = try JSONDecoder().decode(hotelDocumentModel.self, from: Data(result.toJSON().utf8))
                hotels.append(hotelDocumentModel.hotel)
            }
            return hotels
        } catch {
            fatalError("Error running the query")
        }
    }
    
    private func getStartedWithReplication (replication: Bool) throws {
        let configuration: ConfigurationModel? = ConfigurationManager.shared.getConfiguration()
           // Get the database (and create it if it doesn’t exist).
        let path = Bundle.main.path(forResource: "travel-sample", ofType: "cblite2")!
        if !Database.exists(withName: "travel-sample") {
            do {
              try Database.copy(fromPath: path, toDatabase: "travel-sample", withConfig: nil)
            } catch {
                fatalError("Could not load pre-built database")
            }
        }
        database = try Database(name: "travel-sample")
        guard let collection = try database?.createCollection(name: "hotel", scope: "inventory") else { return }
          
        

           if replication {
               guard let configuration else {
                   ErrorManager.shared.showError(error: ConfigurationErrors.replicatorConfigMissing)
                   return
               }
               // Create replicators to push and pull changes to and from the cloud.
               let targetEndpoint = URLEndpoint(url: configuration.capellaEndpointURL)
               var replConfig = ReplicatorConfiguration(target: targetEndpoint)
               replConfig.replicatorType = .pushAndPull
               
               // Add authentication.
               replConfig.authenticator = BasicAuthenticator(username: configuration.username, password: configuration.password)
               
               replConfig.addCollection(collection)

               // Create replicator (make sure to add an instance or static variable named replicator)
               replicator = Replicator(config: replConfig)
               guard let replicator else { return }
               // Listen to replicator change events.
               replicator.addChangeListener { (change) in
                   if let error = change.status.error as NSError? {
                       print("Error code :: \(error.code)")
                   }
               }

               // Start replication.
               replicator.start()
           } else {
               print("Not running replication")
           }
       }
}
