import InSwifted

public protocol Module {
    init()
    
    func register(in container: DependencyContainer)
}
