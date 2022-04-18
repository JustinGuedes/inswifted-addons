import SwiftUI

public struct Tab {
    var title: String
    var icon: TabImage
    var order: Int
    var view: AnyView
    
    public init<T: View>(title: String,
                         icon: TabImage,
                         order: Int,
                         @ViewBuilder view: () -> T) {
        self.title = title
        self.icon = icon
        self.order = order
        self.view = AnyView(view())
    }
}
