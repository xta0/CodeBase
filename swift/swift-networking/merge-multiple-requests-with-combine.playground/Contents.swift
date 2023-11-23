import UIKit
import Combine

struct Message: Decodable, Identifiable {
    var id: Int
    var from: String
    var message: String
}

var requests = Set<AnyCancellable>()
func fetch<T: Decodable>(_ url: URL, defaultValue: T, completion: @escaping (T) -> Void) {
    let decoder = JSONDecoder()
    
    URLSession.shared.dataTaskPublisher(for: url)
        .retry(1)
        .map(\.data)
        .decode(type: T.self, decoder: decoder)
        .replaceError(with: defaultValue)
        .receive(on: DispatchQueue.main)
        .sink(receiveValue: completion)
        .store(in: &requests)
}


//let messagesURL = URL(string: "https://www.hackingwithswift.com/samples/user-messages.json")!
//
//var messages:[Message] = []
//fetch(messagesURL, defaultValue: [Message]()) { messages = $0 }
//
//var favorites = Set<Int>()
//DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//    let favoritesURL = URL(string: "https://www.hackingwithswift.com/samples/user-favorites.json")!
//
//    fetch(favoritesURL, defaultValue: Set<Int>()) {
//        favorites = $0
//    }
//}


func fetch<T: Decodable>(_ url: URL, defaultValue: T) -> AnyPublisher<T, Never> {
    let decoder = JSONDecoder()
    
    return URLSession.shared.dataTaskPublisher(for: url)
        .retry(1)
        .map(\.data)
        .decode(type: T.self, decoder: decoder)
        .replaceError(with: defaultValue)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
}


let messagesURL = URL(string: "https://www.hackingwithswift.com/samples/user-messages.json")!
let favoritesURL = URL(string: "https://www.hackingwithswift.com/samples/user-favorites.json")!

let messagesTask = fetch(messagesURL, defaultValue: [Message]())
let favoriteTask = fetch(favoritesURL, defaultValue: Set<Int>())

var messages:[Message] = []
var favorites = Set<Int>()
let combined = Publishers.Zip(messagesTask, favoriteTask)
combined.sink { loadedMessages, loadedFavorites in
    messages = loadedMessages
    favorites = loadedFavorites
}
.store(in: &requests)

print(messages)
print("---------")
print(favorites)
