import SwiftUI

public struct InTabView<Loading: View, NoTabs: View>: View {
    
    @StateObject
    var viewModel = InTabViewModel()
    
    var loadingContent: () -> Loading
    var noTabsContent: () -> NoTabs
    
    public init(@ViewBuilder loadingContent: @escaping () -> Loading,
                @ViewBuilder noTabsContent: @escaping () -> NoTabs) {
        self.loadingContent = loadingContent
        self.noTabsContent = noTabsContent
    }
    
    public var body: some View {
        VStack {
            switch (viewModel.isLoading, viewModel.tabs.isEmpty) {
            case (true, _):
                loadingContent()
            case (false, true):
                noTabsContent()
            case (false, false):
#if os(iOS) || os(watchOS)
                TabView {
                    ForEach(viewModel.tabs, id: \.title) { tab in
                        tab.view
                            .tag(tab.title)
                            .tabItem {
                                switch tab.icon {
                                case .systemName(let name):
                                    Label(tab.title, systemImage: name)
                                case .asset(let name):
                                    Label(tab.title, image: name)
                                }
                            }
                    }
                }
#elseif os(macOS)
                NavigationView {
                    List(viewModel.tabs, id: \.title) { tab in
                        NavigationLink(destination: tab.view) {
                            switch tab.icon {
                            case .systemName(let name):
                                Label(tab.title, systemImage: name)
                            case .asset(let name):
                                Label(tab.title, image: name)
                            }
                        }
                    }
                }
#endif
            }
        }
        .onAppear {
            Task {
                await viewModel.loadTabs()
            }
        }
    }
    
}

extension InTabView {
    
    public init(@ViewBuilder noTabsContent: @escaping () -> NoTabs)
    where Loading == DefaultLoadingView {
        self.init(loadingContent: DefaultLoadingView.init, noTabsContent: noTabsContent)
    }
    
    public init(@ViewBuilder loadingContent: @escaping () -> Loading)
    where NoTabs == DefaultNoTabsView {
        self.init(loadingContent: loadingContent, noTabsContent: DefaultNoTabsView.init)
    }
    
    public init()
    where Loading == DefaultLoadingView, NoTabs == DefaultNoTabsView {
        self.init(loadingContent: DefaultLoadingView.init, noTabsContent: DefaultNoTabsView.init)
    }
    
}

struct InTabView_Previews: PreviewProvider {
    static var previews: some View {
        InTabView()
    }
}
