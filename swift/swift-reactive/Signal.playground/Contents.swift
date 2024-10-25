import Foundation
import UIKit

typealias JSONDictionary = [String: Any]


enum HTTPMethod<T>{
    case GET
    case POST(T)
}

extension HTTPMethod {
    var method: String {
        switch self {
        case .GET: return "GET"
        case .POST: return "POST"
        }
    }
}

extension HTTPMethod {
    func map<R>(f: (T) -> R) -> HTTPMethod<R> {
        switch self {
        case .GET: return .GET
        case .POST(let body):
            return .POST(f(body))
        }
    }
}

struct Posts: Codable {
    let hits: [Post]
}

struct Post : Codable, Identifiable {
    var id: String {
        return objectID
    }
    let objectID: String
    let points: Int
    let title: String
    let url: String?
}

enum Result<A> {
    case success(A)
    case error(Error)
    
    init(_ value: A?, or error: Error) {
        if let value = value {
            self = .success(value)
        } else {
            self = .error(error)
        }
    }
}

struct Resource<A> {
    let url: URL
    let parse: (Data) -> A?
}

extension Resource {
    init(url: URL, parseJSON: @escaping (Any) -> A?) {
        self.url = url
        self.parse = { data in
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            return json.flatMap(parseJSON)
        }
    }
}

extension Resource where A: Decodable {
    init(get url: URL) {
        self.url = url
        self.parse = { data in
            // decode http response data to JSON object
            try? JSONDecoder().decode(A.self, from: data)
        }
    }
}

extension Result {
    func map<B>(_ transform: (A) -> B) -> Result<B> {
        switch self {
        case .success(let value): return .success(transform(value))
        case .error(let error): return .error(error)
        }
    }
}

final class Signal<A> {
    var callbacks: [(Result<A>) -> Void] = []
    
    static func pipe() -> ((Result<A>)->Void, Signal<A>) {
        let signal = Signal<A>()
        return ( { [weak signal] value in signal?.send(value) }, signal)
    }
    
    func subscribe(callback: @escaping (Result<A>) -> Void) {
        callbacks.append(callback)
    }
    
    private func send(_ value: Result<A>) {
        for callback in callbacks {
            callback(value)
        }
    }
}


final class KeyValueObserver<A>: NSObject {
    let block: (A) -> ()
    let keyPath: String
    var object: NSObject
    init(object: NSObject, keyPath: String, _ block: @escaping (A) -> ()) {
        self.block = block
        self.keyPath = keyPath
        self.object = object
        super.init()
        object.addObserver(self, forKeyPath: keyPath, options: .new, context: nil)
    }
    
    deinit {
        object.removeObserver(self, forKeyPath: keyPath)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        block(change![.newKey] as! A)
    }
}

let (sink, signal) = Signal<String>.pipe()
signal.subscribe { result in
    print(result)
}
sink(.success("Hello Signal"))



