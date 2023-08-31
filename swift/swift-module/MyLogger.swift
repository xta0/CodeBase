import Foundation
@_implementationOnly import MyLoggerInternal

public class MyLogger {

    var prefix: String = ""
    private var logger: MyLoggerInternal = MyLoggerInternal()

    public init(prefix:String) {
        self.prefix = prefix
    }
    public func log<T>(object: T)  {
        print(prefix + " \(object)")
    }

    @objc public func objc_log(object: String) {
        let messasge = prefix + "[OBJC]" + " \(object as NSString)";
        self.logger.log(messasge);
    }
}
