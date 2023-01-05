import Foundation

public class Logger: NSObject {    
    var prefix: String = ""
    @objc public init(prefix:String) {
        self.prefix = prefix
    }
    public func log<T>(object: T)  {
        print(self.prefix + " \(object)")
    }
    @objc public func logString(object: String)  {
        self.log(object:object)
    }
}
