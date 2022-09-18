import Foundation

public class Logger {
    
    var prefix: String = ""
    
    public init(prefix:String) {
        self.prefix = prefix
    }
    public func log<T>(object: T)  {
        print(prefix + " \(object)")
    }

    @objc public func objc_log(object: String) {
        print(prefix + "[OBJC]" + " \(object)")
    }
}



