public protocol TabProvider {
    func provide(_ builder: TabBuilder) async -> Tab?
}
