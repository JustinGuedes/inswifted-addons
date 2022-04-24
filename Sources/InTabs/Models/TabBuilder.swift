import Foundation
import SwiftUI

public struct TabBuilder {
    
    var title: String? = nil
    var icon: TabImage? = nil
    var order: Int? = nil
    var view: AnyView? = nil
    
    public func set(title: String) -> TabBuilder {
        return TabBuilder(title: title,
                          icon: icon,
                          order: order,
                          view: view)
    }
    
    public func set(iconSystemName: String) -> TabBuilder {
        return TabBuilder(title: title,
                          icon: .systemName(iconSystemName),
                          order: order,
                          view: view)
    }
    
    public func set(iconAsset: String) -> TabBuilder {
        return TabBuilder(title: title,
                          icon: .asset(iconAsset),
                          order: order,
                          view: view)
    }
    
    public func set(order: Int) -> TabBuilder {
        return TabBuilder(title: title,
                          icon: icon,
                          order: order,
                          view: view)
    }
    
    public func set<T: View>(view: () -> T) -> TabBuilder {
        return TabBuilder(title: title,
                          icon: icon,
                          order: order,
                          view: AnyView(view()))
    }
    
    public func set<T: View>(actor view: @MainActor () -> T) async -> TabBuilder {
        return TabBuilder(title: title,
                          icon: icon,
                          order: order,
                          view: AnyView(await view()))
    }
    
    public func build() -> Tab? {
        guard let title = title,
              let icon = icon,
              let view = view else {
            return nil
        }

        return Tab(title: title,
                   icon: icon,
                   order: order ?? .zero,
                   view: view)
    }
    
}
