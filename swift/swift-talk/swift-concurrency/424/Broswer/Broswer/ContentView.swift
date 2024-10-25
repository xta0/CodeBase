//
//  ContentView.swift
//  Broswer
//
//  Created by Tao Xu on 10/12/24.
//

import SwiftUI
import Observation
import WebKit


struct Page: Identifiable, Hashable {
    var url: URL
    var id = UUID()
}

@Observable
class Store: Observable {
    var pages: [Page] = [
        Page(url: .init(string: "https://www.objc.io")!),
        Page(url: .init(string: "https://www.apple.com")!)
    ]
    nonisolated init() {}
    func submit(_ url: URL) {
        pages.append(Page(url: url))
    }
}

struct Box<A> {
    var value: A
    init(_ value: A) {
        self.value = value
    }
}

struct WebViewProxy {
    func takeSnapshot() async throws -> NSImage {
        fatalError()
    }
}

struct WebViewReader<Content: View>: View {
    @State var proxy = WebViewProxy()
    @ViewBuilder var content: (WebViewProxy) -> Content
    var body: some View {
        content(proxy)
    }
}

struct WebView: NSViewRepresentable {
    var url: URL
    var snapshot: (_ takeSnapshot: @escaping () async -> NSImage) -> ()
    class Coordinator: NSObject, WKNavigationDelegate {
        
    }
    func makeCoordinator() -> Coordinator {
        .init()
    }
    func makeNSView(context: Context) -> WKWebView {
        let result = WKWebView()
        result.navigationDelegate = context.coordinator
        return result
    }
    func updateNSView(_ nsView: WKWebView, context: Context) {
        assert(Thread.isMainThread)
        snapshot({
            do {
                assert(Thread.isMainThread)
                let image = try await nsView.takeSnapshot(configuration: nil)
                assert(Thread.isMainThread)
                return image
            } catch {
                return NSImage()
            }
        })
        if nsView.url != url {
            let request = URLRequest(url: url)
            nsView.load(request)
        }
    }
}

extension NSImage: @unchecked Sendable {}

struct ContentView: View {
    @State var store = Store()
    @State var currentURLString: String = "https://sg.1psdk.com"
    @State var selectedPage: Page.ID?
    @State var image:NSImage?
    @State var takeSnapshort: (() async ->NSImage)?
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selectedPage) {
                ForEach(store.pages) { page in
                    Text(page.url.absoluteString)
                }
            }
        } detail: {
            if let s = selectedPage, let page = store.pages.first(where: {$0.id == s}) {
                WebViewReader { proxy in
                    WebView(url: page.url) { takeSnapshot in
                        self.takeSnapshort = takeSnapshot
                    }.toolbar {
                        Button("Snapshot") {
                            image = proxy.takeSnapshort()
                        }
                    }
                }
              
            } else {
                ContentUnavailableView("No Page Selected!", systemImage: "globe")
            }
        }
        .toolbar {
            ToolbarItem {
                TextField("URL", text: $currentURLString)
                    .onSubmit {
                        if let url = URL(string: currentURLString) {
                            currentURLString = ""
                            store.submit(url)
                        }
                    }
            }
            ToolbarItem {
                Button("Take a snapshot") {
                    Task {
                        image = await self.takeSnapshort?()
                    }
                }
            }
        }
        
    }
}

#Preview {
    ContentView()
}
