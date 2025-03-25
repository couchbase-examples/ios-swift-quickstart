struct ErrorModel: Error {
    var title: String
    var message: String
    var closable: Bool = false
}
