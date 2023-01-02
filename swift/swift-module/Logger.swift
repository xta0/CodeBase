import Foundation

class Logger {    
    var prefix: String = ""
    init(prefix:String) {
        self.prefix = prefix
    }
    func log<T>(object: T)  {
        print(self.prefix + " \(object)")
    }
}

let logger = Logger(prefix: "xtao");
logger.log(object: "yo!")

