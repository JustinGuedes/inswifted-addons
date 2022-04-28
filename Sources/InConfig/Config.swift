import Foundation

import InSwifted

@propertyWrapper public struct Config<T> {
    
    @Injected
    var provider: ConfigProvider
    
    var name: String

    public init(_ name: String) {
        self.name = name
    }
    
    public var wrappedValue: T {
        return provider.provide(forName: name)
    }
}
