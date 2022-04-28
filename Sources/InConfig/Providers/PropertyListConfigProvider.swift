import Foundation

public struct PropertyListConfigProvider: ConfigProvider {

    var propertyList: [String: Any]

    public init?(filename: String) {
        guard let path = Bundle.main.url(forResource: filename, withExtension: "plist"),
              let data = try? Data(contentsOf: path),
              let propertyList = try? PropertyListSerialization.propertyList(from: data,
                                                                             options: .mutableContainers,
                                                                             format: nil),
              let result = propertyList as? [String: Any] else {
            return nil
        }

        self.propertyList = result
    }

    public func provide<T>(forName name: String) -> T {
        guard let value = propertyList[name] as? T else {
            fatalError("Could not find config name: \(name)")
        }

        return value
    }
}
