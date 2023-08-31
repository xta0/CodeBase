fn main() {
    let get = Method::GET;
    let server = Server::new("127.0.0.1:8080".to_string());
    server.run();
}

struct Server {
    addr: String,
}

impl Server {
    fn new(addr: String) -> Self {
        Self { addr }
    }
    fn run(self) {}
}

struct Request {
    path: String,
    query_string: Stirng,
    method: Method,
}

enum Method {
    GET,
    POST,
    PUT,
    HEAD,
}
