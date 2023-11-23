import Foundation

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

final class Future<A> {
    var callbacks: [(Result<A>) -> Void] = []
    var cached: Result<A>?
    
    // take in a completion handler
    init(compute: (@escaping (Result<A>)->Void) -> Void) {
        compute(self.send)
    }
    
    func onResult(callback: @escaping (Result<A>) -> Void) {
        if let value = cached {
            callback(value)
            return
        }
        callbacks.append(callback)
    }
    
    func flatMap<B>(transform: @escaping (A) -> Future<B>) -> Future<B> {
        return Future<B> { completion in
            self.onResult { result in
                switch result {
                    case .success(let value):
                    transform(value).onResult(callback: completion)
                    case .error(let error):
                    completion(.error(error))
                }
            }
        }
    }
    
    private func send(_ value: Result<A>) {
        assert(cached == nil)
        cached = value
        for callback in callbacks {
            callback(value)
        }
        callbacks = []
    }
}

enum WebserviceError: Error {
    case notAuthenticated
    case other
}

final class WebService {
    let session = URLSession(configuration: .ephemeral)
    func load<A>(resource: Resource<A>) -> Future<A> {
        return Future { completion in
            print("future invoked!")
            session.dataTask(with: resource.url) { data, response, _ in
                guard let data else {
                    completion(.error(WebserviceError.other))
                    return
                }
                completion(Result(resource.parse(data), or: WebserviceError.other))
            }.resume()
        }
    }
}

let resource = Resource<Posts>(get: URL(string: "http://hn.algolia.com/api/v1/search?tags=front_page")!)
let service = WebService()
service.load(resource: resource).onResult(callback:  { posts in
    print(posts)
})

