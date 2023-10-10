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
    var urlRequest: URLRequest
    let parse: (Data) -> A?
}

extension Resource {
    func map<B>(_ transform: @escaping (A) -> B) -> Resource<B> {
        return Resource<B>(urlRequest: urlRequest) { data in
            self.parse(data).map(transform)
        }
    }
}

extension Resource where A: Decodable {
    init(get url: URL) {
        self.urlRequest = URLRequest(url: url)
        self.parse = { data in
            // decode http response data to JSON object
            try? JSONDecoder().decode(A.self, from: data)
        }
    }
    init<Body: Encodable>(url: URL, method: HTTPMethod<Body>){
        urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.method
        switch method {
        case .GET: ()
        case .POST(let body):
            self.urlRequest.httpBody = try! JSONEncoder().encode(body)
        }
        self.parse = { data in
            // decode http response data to JSON object
            try? JSONDecoder().decode(A.self, from: data)
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

extension URLSession {
    func load<A>(resource: Resource<A>, completion: @escaping (Result<A>) -> () = logError) {
        dataTask(with: resource.urlRequest) { data, response, _ in
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
