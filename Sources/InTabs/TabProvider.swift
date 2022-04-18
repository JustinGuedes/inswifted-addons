public protocol TabProvider {
    func provide() async -> Tab?
}
