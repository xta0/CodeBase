//
//  ContentView.swift
//  Broswer
//
//  Created by Tao Xu on 10/12/24.
//

import SwiftUI
import Observation

struct Page: Identifiable, Hashable {
    var url: URL
    var id = UUID()
}

@Observable
@MyGlobalActor
class Store: Observable {
    var pages: [Page] = []
    nonisolated init() {}
    func submit(_ url: URL) {
        pages.append(Page(url: url))
    }
}

@globalActor
actor MyGlobalActor {
    static let shared = MyGlobalActor()
}

struct ContentView: View {
    @State var store = Store()
    @State var currentURLString: String = "https://sg.1psdk.com"
    @State var selectedPage: Page.ID?
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selectedPage) {
                ForEach(store.pages) { page in
                    Text(page.url.absoluteString)
                }
            }
        } detail: {
            if let s = selectedPage {
                Text(s.uuidString)
            } else {
                ContentUnavailableView("No Page Selected!", systemImage: "globe")
            }
        }
        .toolbar {
            ToolbarItem {
                TextField("URL", text: $currentURLString)
                    .onSubmit {
                        if let url = URL(string: currentURLString) {
                            Task {
                                await store.submit(url)
                                currentURLString = ""
                            }
                        }
                    }
            }
        }

    }
}

#Preview {
    ContentView()
}
