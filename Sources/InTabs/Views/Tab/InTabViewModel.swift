import SwiftUI

import InSwifted
import Prelude

class InTabViewModel: ObservableObject {
    
    @MultiInjected
    var providers: [TabProvider]
    
    @Published
    var isLoading: Bool = true
    
    @Published
    var tabs: [Tab] = []
    
    @MainActor
    func loadTabs() async {
        isLoading = true
        tabs = await providers
            .flatMap(getTab)
            .sorted(by: tabOrder)
        isLoading = false
    }
    
}

private extension InTabViewModel {
    
    func getTab(from provider: TabProvider) async -> Tab? {
        let builder = TabBuilder()
        return await provider.provide(builder)
    }
    
    func tabOrder(_ first: Tab, _ second: Tab) -> Bool {
        return first.order < second.order
    }
    
}
