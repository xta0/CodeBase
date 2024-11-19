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
    var title: String = "No title"
    var fullText: String?
    var lastUpdated: Date = .now
    var snapshot: Data?
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

class Box<A> {
    var value: A
    init(_ value: A) {
        self.value = value
    }
}

struct WebViewProxyError: Error {}

struct WebViewProxy {
    var box: Box<WKWebView?> = Box(nil)
    @MainActor
    func takeSnapshot() async throws -> NSImage {
        guard let w = box.value else {
            throw WebViewProxyError()
        }
        return try await w.takeSnapshot(configuration: nil)
    }
}

extension EnvironmentValues {
    @Entry var webViewBox: Box<WKWebView?>?
}

struct WebViewReader<Content: View>: View {
    @State var proxy = WebViewProxy()
    @ViewBuilder var content: (WebViewProxy) -> Content
    var body: some View {
        content(proxy).environment(\.webViewBox, proxy.box)
    }
}

struct WebView: NSViewRepresentable {
    var url: URL
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
        context.environment.webViewBox?.value = nsView
        if nsView.url != url {
            let request = URLRequest(url: url)
            nsView.load(request)
        }
    }
}

struct ContentView: View {
    @State var store = Store()
    @State var currentURLString: String = "https://sg.1psdk.com"
    @State var selectedPage: Page.ID?
    @State var image:NSImage?
    
    var body: some View {
        WebViewReader { proxy in
            NavigationSplitView {
                List(selection: $selectedPage) {
                    ForEach(store.pages) { page in
                        Text(page.url.absoluteString)
                    }
                }
            } detail: {
                if let s = selectedPage, let page = store.pages.first(where: {$0.id == s}) {
                    WebView(url: page.url)
                        .overlay {
                            if let i = image {
                                Image(nsImage: i).scaleEffect(0.5).border(Color.red)
                            }
                        }
                    
                } else {
                    ContentUnavailableView("No Page Selected!", systemImage: "globe")
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    TextField("URL", text: $currentURLString)
                        .onSubmit {
                            if let url = URL(string: currentURLString) {
                                currentURLString = ""
                                store.submit(url)
                            }
                        }
                }
            }
            .toolbar {
                Button("Snapshot") {
                    Task {
                        image = try await proxy.takeSnapshot()
                    }
                }
            }
            .onAppear() {
                
            }
        }
    }
}

func test() {
    Task {
        do {
            let url = URL.downloadsDirectory.appending(path: "db.sqlite")
            let db = try DataBase(url: url)
            try await db.setup()
            try await db.insert(page: .init(url: URL(string: "https://www.objc.io")!))
        } catch {
            print("Error: ", error)
        }
    }
}

#Preview {
    ContentView()
}
