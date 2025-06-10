import CouchbaseLiteSwift
import Combine

class DatabaseManager {
    static let shared = DatabaseManager()
    var replicator: Replicator?
    var database: Database?
    var collection: Collection?
    var lastQuery: Query?
    var lastQueryToken: ListenerToken?
    private let queryUpdatesSubject = CurrentValueSubject<[Hotel], Never>([])
    
    init() {
        Database.log.console.level = .info
        initializeDatabase()
    }
    
    var queryUpdates: AnyPublisher<[Hotel], Never> {
        queryUpdatesSubject.eraseToAnyPublisher()
    }
    
    private func initializeDatabase() {
        do {
            // Get the database (and create it if it doesn’t exist).
            database = try Database(name: "travel-sample")
            collection = try database?.createCollection(name: "hotel",scope: "inventory")
            let indexConfig = FullTextIndexConfiguration(["name"],language: "en")
            try collection?.createIndex(withName: "hotelNameIndex", config: indexConfig)
            try getStartedWithReplication(replication: true)
        } catch {
            fatalError("Error initializing database")
        }
    }
    
    private func startListeningForChanges(query: Query) {
        lastQuery = query
        lastQueryToken = query.addChangeListener { (change) in
            guard let results = change.results else { return }
            var hotels: [Hotel] = []
            for result in results {
                let hotelDocumentModel = try? JSONDecoder().decode(hotelDocumentModel.self, from: Data(result.toJSON().utf8))
                guard let hotel = hotelDocumentModel?.hotel else { continue }
                print("Retrieved hotel item inside query list: name: \(hotel.name ?? "") id: \(hotel.id)")
                hotels.append(hotel)
            }
            self.queryUpdatesSubject.send(hotels)
        }
    }
    
    private func stopListeningForChanges() {
        guard let lastQueryToken = lastQueryToken else { return }
        lastQuery?.removeChangeListener(withToken: lastQueryToken)
    }
    
    func queryElements(descending: Bool = false, textSearch: String? = nil) {
        do {
            stopListeningForChanges()
            var sql = "SELECT * FROM inventory.hotel WHERE  type = 'hotel'"
            if textSearch != nil {
                sql += " AND MATCH(hotelNameIndex, '\(textSearch ?? "")*')"
            }
            sql += " ORDER BY name \(descending ? "DESC" : "ASC")"
            
            guard let query = try database?.createQuery(sql) else { return }
            
            startListeningForChanges(query: query)
            print(try query.explain())
        } catch {
            print("Error during quering elements: \(error.localizedDescription)")
        }
    }
    
    func addNewElement(_ hotel: Hotel) {
        do {
            guard let collection = try database?.collection(name: "hotel", scope: "inventory") else { return }
            let doc = MutableDocument()
            let encodedHotel: Data = try JSONEncoder().encode(hotel)
            guard let jsonString = String(data: encodedHotel, encoding: .utf8) else { return }
            try doc.setJSON(jsonString)
            try collection.save(document: doc)
        } catch {
            print("Error during adding new element: \(error.localizedDescription)")
        }
    }
    
    func updateExistingElement(_ hotel: Hotel) {
        do {
            guard let collection = try database?.collection(name: "hotel", scope: "inventory") else { return }
            let query = try database?.createQuery("SELECT META().id FROM inventory.hotel WHERE type = 'hotel' AND id = \(hotel.id)")
            guard let results = try query?.execute() else { return }
            for result in results {
                let docsProps = result.toDictionary()
                guard let docid = docsProps["id"] as? String else { return }
                let doc = try collection.document(id: docid)
                guard let mutableDoc: MutableDocument = doc?.toMutable() else { return }
                let encodedHotel: Data = try JSONEncoder().encode(hotel)
                guard let jsonString = String(data: encodedHotel, encoding: .utf8) else { return }
                try mutableDoc.setJSON(jsonString)
                try collection.save(document: mutableDoc)
            }
        } catch {
            print("Error during updating element: \(error.localizedDescription)")
        }
    }
    
    func deleteElement(_ hotel: Hotel) {
        do {
            guard let collection = try database?.collection(name: "hotel", scope: "inventory") else { return }
            let query = try database?.createQuery("SELECT META().id FROM inventory.hotel WHERE type = 'hotel' AND id = \(hotel.id)")
            
            guard let results = try query?.execute() else { return }
            for result in results {
                let docsProps = result.toDictionary()
                guard let docid = docsProps["id"] as? String else { return }
                guard let doc = try collection.document(id: docid) else { return }
                try collection.delete(document: doc)
            }
        } catch {
            print("Error during deleting element: \(error.localizedDescription)")
        }
    }
    
    func deleteElementWithName(_ name: String) {
        do {
            guard let collection = try database?.collection(name: "hotel", scope: "inventory") else { return }
            let query = try database?.createQuery("SELECT META().id FROM inventory.hotel WHERE type = 'hotel' AND name = '\(name)'")
            
            guard let results = try query?.execute() else { return }
            for result in results {
                let docsProps = result.toDictionary()
                guard let docid = docsProps["id"] as? String else { return }
                guard let doc = try collection.document(id: docid) else { return }
                try collection.delete(document: doc)
            }
        } catch {
            print("Error during deleting element: \(error.localizedDescription)")
        }
    }
    
    private func getStartedWithReplication (replication: Bool) throws {
        let configuration: ConfigurationModel? = ConfigurationManager.shared.getConfiguration()
        
        if replication {
            guard let configuration else {
                ErrorManager.shared.showError(error: ConfigurationErrors.configError)
                return
            }
            // Create replicators to push and pull changes to and from the cloud.
            let targetEndpoint = URLEndpoint(url: configuration.capellaEndpointURL)
            var replConfig = ReplicatorConfiguration(target: targetEndpoint)
            replConfig.continuous = true
            
            // Add authentication.
            replConfig.authenticator = BasicAuthenticator(username: configuration.username, password: configuration.password)
            
            guard let collection else { return }
            replConfig.addCollection(collection)
            
            // Create replicator (make sure to add an instance or static variable named replicator)
            replicator = Replicator(config: replConfig)
            
            // Start replication.
            replicator?.start()
        } else {
            print("Not running replication")
        }
    }
}
