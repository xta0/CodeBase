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
}

extension Result {
    init(_ value: A?, or error: Error) {
        if let value = value {
            self = .success(value)
        } else {
            self = .error(error)
        }
    }
    var value: A? {
        guard case .success(let v) = self else { return nil }
        return v
    }
}

struct Resource<A> {
    let url: URL
    let method: HTTPMethod<Data>
    let parse: (Data) -> A?
}

extension Resource where A: Decodable {
    init(get url: URL) {
        self.url = url
        self.method = .GET
        self.parse = { data in
            // decode http response data to JSON object
            try? JSONDecoder().decode(A.self, from: data)
        }
    }
    init<Body: Encodable>(url: URL, method: HTTPMethod<Body>){
        self.url = url
        self.method = method.map{ value in
            // encode JSON object to http body data
            try! JSONEncoder().encode(value)
        }
        self.parse = { data in
            // decode http response data to JSON object
            try? JSONDecoder().decode(A.self, from: data)
        }
    }
}

extension URLRequest {
    init<T>(resource: Resource<T>) {
        self.init(url: resource.url)
        self.httpMethod = resource.method.method
        if case let .POST(data) = resource.method {
            self.httpBody = data
        }
    }
}

func logError<A>(_ result: Result<A>) {
    guard case let .error(e) = result else { return }
    assert(false, "\(e)")
}

enum WebServiceError: Error {
    case notAuthenticated
    case other
}

// We create our own session here without a URLCache to avoid playground error messages
var session: URLSession {
    let config = URLSessionConfiguration.default
    config.urlCache = nil
    return URLSession(configuration: config)
}

public enum WebserviceError: Error {
    case notAuthenticated
    case other
}

final class WebService {
    func load<A>(resource: Resource<A>, completion: @escaping (Result<A>) -> () = logError) {
        let request = URLRequest(resource: resource)
        session.dataTask(with: request) { data, response, _ in
            let result: Result<A>
            if let httpResponse  = response as? HTTPURLResponse, httpResponse.statusCode == 401 {
                result = Result.error(WebServiceError.notAuthenticated)
            } else {
                let parsed = resource.parse(data!)
                result = Result(parsed, or: WebServiceError.other)
            }
            DispatchQueue.main.async {
                completion(result)
            }
        }.resume()
    }
}

////////////////////////
///
///

extension Resource {
    var cacheKey: String {
        return "Cache" + String(url.hashValue) //use sha1
    }
}

struct FileStorage {
    let baseURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    subscript(key: String) -> Data? {
        get {
            let url = baseURL.appendingPathComponent(key)
            return try? Data(contentsOf: url)
        }
        set {
            let url = baseURL.appendingPathComponent(key)
            _ = try? newValue?.write(to: url)
        }
    }
}

final class Cache {
    var storage = FileStorage()
    func load<T>(_ resource: Resource<T>) -> T? {
        guard case .GET = resource.method else { return nil }
        let data = storage[resource.cacheKey]
        return data.flatMap(resource.parse)
    }
    func save<T> (_ data: Data, for resource: Resource<T>) {
        guard case .GET = resource.method else { return }
        storage[resource.cacheKey] = data
    }
}

final class CachedWebService {
    let webService: WebService
    let cache = Cache()
    init (_ webService: WebService) {
        self.webService = webService
    }
    func load<A>(_ resource: Resource<A>, update: @escaping (Result<A>) -> ()){
        if let result = cache.load(resource) {
            print("cached result: \(result)", result)
            update(.success(result))
        }
        let dataResource = Resource<Data>(url: resource.url, method: resource.method, parse: {$0})
        webService.load(resource: dataResource) { result in
            switch result {
            case let .error(error): update(.error(error))
            case let .success(data):
                print(data)
                self.cache.save(data, for: resource)
                update(Result(resource.parse(data), or: WebserviceError.other))
            }
        }
    }
}

extension URLSession {
    func load<A>(resource: Resource<A>, completion: @escaping (Result<A>) -> () = logError) {
        let request = URLRequest(resource: resource)
        dataTask(with: request) { data, response, _ in
            let result: Result<A>
            if let httpResponse  = response as? HTTPURLResponse, httpResponse.statusCode == 401 {
                result = Result.error(WebServiceError.notAuthenticated)
            } else {
                let parsed = resource.parse(data!)
                result = Result(parsed, or: WebServiceError.other)
            }
            DispatchQueue.main.async {
                completion(result)
            }
        }.resume()
    }
}


let resource = Resource<Posts>(get: URL(string: "http://hn.algolia.com/api/v1/search?tags=front_page")!)
URLSession.shared.load(resource: resource) { posts in
    print(posts)
}
//let service = WebService()
//service.load(resource: resource) { posts in
//    print(posts)
//}



