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
            .flatMap { await $0.provide() }
            .sorted { $0.order < $1.order }
        isLoading = false
    }
    
}
