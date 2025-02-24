enum ConfigurationErrors {
    static let configFileMissing: ErrorModel = .init(title: "Config file not found", message: "Config file was not found inside the bundle, or it couldn't be processed as a dictionary.")
    static let cappellaURLMissing: ErrorModel = .init(title: "Remote Capella endpoint URL not found", message: "Remote Capella endpoint URL located in Config file was not found.\nPlease make sure that you have configured the URL in the Config file.")
    static let cappellaURLParsing: ErrorModel = .init(title: "Remote Capella endpoint URL parsing error", message: "Remote Capella endpoint URL located in Config file couldn't be parsed as a valid URL.\nPlease make sure that you have configured the URL in the Config file correctly.")
    static let authenticationMissing: ErrorModel = .init(title: "Authentication not found", message: "Authentication located in Config file was not found.\nPlease make sure that you have configured the authentication in the Config file.")
    static let usernameMissing: ErrorModel = .init(title: "Username not found", message: "Username located in Config file was not found.\nPlease make sure that you have configured the username in the Config file.")
    static let passwordMissing: ErrorModel = .init(title: "Password not found", message: "Password located in Config file was not found.\nPlease make sure that you have configured the password in the Config file.")
    static let replicatorConfigMissing: ErrorModel = .init(title: "Replicator couldn't retrieve config", message: "Replicator couldn't retrieve config. Make sure that the configuration manager loads config file correctly.")
}
