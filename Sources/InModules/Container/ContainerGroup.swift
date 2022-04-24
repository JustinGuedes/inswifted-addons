import SwiftUI

public struct ContainerGroup<Content: View>: Scene {
    
    var container: Container
    var content: Content
    
    public init(modules: [Module.Type], @ViewBuilder content: () -> Content) {
        self.content = content()
        self.container = Container(modules: modules)
        self.container.start()
    }
    
    public var body: some Scene {
        WindowGroup {
            content
        }
    }
    
}
