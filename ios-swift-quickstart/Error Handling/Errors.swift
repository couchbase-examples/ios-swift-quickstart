enum ConfigurationErrors {
    static let configFileMissing: ErrorModel = .init(title: "Config file not found", message: "Config file was not found inside the bundle, or it couldn't be processed as a dictionary.")
    static let configError: ErrorModel = .init(title: "Cannot connect to Capella App Services for data sync", message: "Please make sure the App Services connection URL, username and password are placed in the app configuration file")
    
}
