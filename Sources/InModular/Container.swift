import InSwifted

public struct Container {
    
    var container: DependencyContainer
    var modules: [Module]
    
    public init(container: DependencyContainer = .init(),
                modules: [Module.Type]) {
        self.container = container
        self.modules = modules.map { $0.init() }
    }
    
    public func start() {
        InSwifted.set(resolver: container)
        modules.forEach(register)
    }
    
}

extension Container {
    
    func register(_ module: Module) {
        module.register(in: container)
    }
    
}
