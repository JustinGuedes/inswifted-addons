import SwiftUI

public protocol ModularApp: App {
    associatedtype Content: View
    
    @ModuleBuilder
    var modules: [Module.Type] { get }
    
    var modularBody: Content { get }
    
}

public extension ModularApp {
    
    var body: some Scene {
        ContainerGroup(modules: modules) {
            modularBody
        }
    }
    
}
