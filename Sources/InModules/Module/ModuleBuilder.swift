import Foundation

@resultBuilder
public struct ModuleBuilder {
    
    public static func buildBlock(_ components: Module.Type...) -> [Module.Type] {
        return components
    }
    
}
