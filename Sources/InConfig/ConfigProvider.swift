import Foundation

public protocol ConfigProvider {
    func provide<T>(forName name: String) -> T
}
