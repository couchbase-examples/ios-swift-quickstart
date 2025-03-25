//
//  ConfigurationManager.swift
//  Couchbase-Lite-Swift-Demo
//
//  Created by Dominik Brozio on 12/02/2025.
//

import Foundation

struct ConfigurationManager {
    static let shared = ConfigurationManager()
    
    private enum Constants {
        static let path: String? = Bundle.main.path(forResource: "Config", ofType: "plist")
        static let capellaURLKey: String = "Remote Capella endpoint URL"
        static let authenticationKey: String = "Authentication"
        static let userNameKey: String = "User name"
        static let passwordKey: String = "Password"
    }
    
    private var configuration: ConfigurationModel?
    
    init() {
        loadConfiguration()
    }
    
    func getConfiguration() -> ConfigurationModel? {
        configuration
    }
    
    private mutating func loadConfiguration() {
        guard let path = Constants.path,
           let dictionary = NSDictionary(contentsOfFile: path) as? [String: Any] else {
            ErrorManager.shared.showError(error: ConfigurationErrors.configFileMissing)
            return
        }
        configuration = parseConfiguration(dictionary: dictionary)
    }
    
    private func parseConfiguration(dictionary: [String: Any]) -> ConfigurationModel? {
        guard let capella = dictionary[Constants.capellaURLKey] as? String, !capella.isEmpty else {
            ErrorManager.shared.showError(error: ConfigurationErrors.configError)
            return nil
        }
        guard let capellaEndpointURL = URL(string: capella) else {
            ErrorManager.shared.showError(error: ConfigurationErrors.configError)
            return nil
        }
        guard let authentication = dictionary[Constants.authenticationKey] as? [String: Any] else {
            ErrorManager.shared.showError(error: ConfigurationErrors.configError)
            return nil
        }
        guard let userName = authentication[Constants.userNameKey] as? String, !userName.isEmpty else {
            ErrorManager.shared.showError(error: ConfigurationErrors.configError)
            return nil
        }
        guard let password = authentication[Constants.passwordKey] as? String, !password.isEmpty else {
            ErrorManager.shared.showError(error: ConfigurationErrors.configError)
            return nil
        }
        return ConfigurationModel(capellaEndpointURL: capellaEndpointURL, username: userName, password: password)
    }
}
