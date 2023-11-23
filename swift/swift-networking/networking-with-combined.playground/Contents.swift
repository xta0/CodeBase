import UIKit
import Combine

// https://www.hackingwithswift.com/samples/user-24601.json
struct User: Decodable {
    var id: UUID
    var name: String

    static let `default` = User(id: UUID(), name: "Anonymous")
}

//func fetch(_ url: URL) {
//    URLSession.shared.dataTask(with: url) { data, response, error in
//        if let error = error {
//            print(User.default.name)
//        } else if let data = data {
//            let decoder = JSONDecoder()
//            do {
//                let user = try decoder.decode(User.self, from: data)
//                print(user.name)
//            } catch {
//                print(User.default.name)
//            }
//        }
//    }.resume()
//}

var requests = Set<AnyCancellable>()

func fetch<T: Decodable>(_ url: URL, defautValue: T, completion: @escaping(T) -> Void) {
    let decoder = JSONDecoder()
    URLSession.shared.dataTaskPublisher(for: url)
        .retry(1)
        .map(\.data)
        .decode(type: T.self, decoder: decoder)
        .replaceError(with: defautValue)
        .receive(on: DispatchQueue.main)
        .sink( receiveValue: completion)
        .store(in: &requests)
}

let url = URL(string: "https://www.hackingwithswift.com/samples/user-24601.json")!
fetch(url, defautValue: User.default) {
    print($0.name)
}

/// User-friendly network access
import Network

class NetworkMonitor: ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "Monitor")
    var isActive = false
    var isExpensive = false
    var isConstrained = false
    var connectionType = NWInterface.InterfaceType.other
    
    init() {
        monitor.pathUpdateHandler = { path in
            // more code here
            self.isActive = path.status == .satisfied
            self.isExpensive = path.isExpensive
            self.isConstrained = path.isConstrained
            
            let connectionTypes: [NWInterface.InterfaceType] = [.cellular, .wifi, .wiredEthernet]
            self.connectionType = connectionTypes.first(where: path.usesInterfaceType) ?? .other
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }

        monitor.start(queue: queue)
    }
    func makeRequest() {
        let config = URLSessionConfiguration.default
        config.allowsExpensiveNetworkAccess = false
        config.allowsConstrainedNetworkAccess = false
        // setting this config means if the network becomes avaialble, the request
        // will be automatically sent.
        config.waitsForConnectivity = true
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        
        let session = URLSession(configuration: config)
        session.dataTask(with: url) { data, response, error in
            print(data)
        }
    }
}

let monitor = NetworkMonitor()
print(monitor.isActive)
print(monitor.isExpensive)
print(monitor.isConstrained)
