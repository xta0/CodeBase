import UIKit
import Combine

import UIKit
import Combine

let url = URL(string: "https://www.hackingwithswift.com/samples/news.json")!

struct NewsItem: Decodable, Identifiable {
    let id: Int
    let title: String
    let strap: String
    let url: URL
    let main_image: String
    let published_date: Date
}

func fetch<T: Decodable>(_ url: URL, defaultValue: T) -> AnyPublisher<T, Never> {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601

    return URLSession.shared.dataTaskPublisher(for: url)
        .retry(1)
        .map(\.data)
        .decode(type: T.self, decoder: decoder)
        .replaceError(with: defaultValue)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
}

var items: [NewsItem] = []
var requests: [AnyCancellable] = []
fetch(url, defaultValue: [URL]())
    .flatMap{ urls in
        urls.publisher.flatMap { url in
            fetch(url, defaultValue: [NewsItem]())
        }
    }
    .collect()
    .sink {
        values in
        let allItems = values.joined()
        items = allItems.sorted { $0.id > $1.id }
    }
    .store(in: &requests)

print(items)
