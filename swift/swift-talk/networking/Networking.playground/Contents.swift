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

struct Episode{
    let id: String
    let title: String
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

extension Episode {
    init?(dictionary: JSONDictionary) {
        guard let id = dictionary["id"] as? String, let title = dictionary["title"] as? String else {
            print("[Parsing error]")
            return nil
        }
        self.id = id
        self.title = title
    }
}

extension Episode {
    static let url = URL(string: "http://hn.algolia.com/api/v1/search?tags=front_page")!
    static let all = Resource<[Episode]>(url: url, parseJSON: { json in
        guard let dictionaries = json as? [JSONDictionary] else {
            return nil
        }
        return dictionaries.compactMap(Episode.init)
    })

}

//func pushNotification(token: String) ->Resource<Bool> {
//    let dictionary = ["token" : token]
//    return Resource(url: url, method: .POST(dictionary)) { data in
//        return true
//    }
//}

struct Resource<A> {
    let url: URL
    let method: HTTPMethod<Data>
    let parse: (Data) -> A?
}

extension Resource {
    init(url: URL, parseJSON: @escaping (Any) -> A?) {
            self.url = url
            self.method = .GET
            self.parse = { data in
                let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
                return json.flatMap(parseJSON)
            }
    }
    init(url: URL, method: HTTPMethod<Any> = .GET, parseJSON: @escaping (Any) -> A?) {
        self.url = url
        self.method = method.map{ data in
            try! JSONSerialization.data(withJSONObject: data)
        }
        self.parse = { data in
            let json = try? JSONSerialization.jsonObject(with: data)
            return json.flatMap(parseJSON)
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
    
final class WebService<A> {
    func load(resource: Resource<A>, completion: @escaping (Result<A>) -> () = logError) {
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
final class Cache {
    let baseURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    func load<T>(_ resource: Resource<T>) -> T? {
        guard case .GET = resource.method else { return nil }
        let url = baseURL.appendingPathComponent(resource.cacheKey)
        let data = try? Data(contentsOf: url)
        return data.flatMap(resource.parse)
    }
    func save<T> (_ data: Data, resource: Resource<T>) {
        guard case .GET = resource.method else { return }
        let url = baseURL.appendingPathComponent(resource.cacheKey)
        _ = try? data.write(to: url)
    }
}

final class CachedWebService<A> {
    let webService: WebService<A>
    let cache = Cache()
    init (_ webService: WebService<A>) {
        self.webService = webService
    }
    func load(_ resource: Resource<A>, update: @escaping (Result<A>) -> ()){
        if let result = cache.load(resource) {
            print("cached result: \(result)", result)
            update(.success(result))
        }
        webService.load(resource: resource, completion: update)
    }
}

WebService().load(resource: Episode.all) { result in
    print(result)
}

