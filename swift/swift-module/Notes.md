### Commands

- Emit dynmiac library

```
xcrun swiftc -emit-library Logger.swift -sdk $(xcrun --show-sdk-path --sdk macosx) -module-name Logger 
```

- Emit object files

```
 xcrun swiftc -emit-library -emit-object Logger.swift -sdk $(xcrun --show-sdk-path --sdk macosx) -module-name Logger
```

- Emit Swift modules for iPhoneSimulator

```
xcrun swiftc -emit-module -parse-as-library  Logger.swift -sdk $(xcrun --show-sdk-path --sdk iphonesimulator) -target x86_64-apple-ios15.0-simulator -module-name Logger 
```

- Compile main.swift

```
xcrun swiftc -o main main.swift Logger.swift
```

- Compile main.m

```
xcrun clang -o main ./objc/main.m -framework Foundation
```

- Swift interface

```
swiftc -print-ast Logger.swift
```

### Call Swift from Objective-C

We need two things:

- A Logger-Swift.h
- A Logger.swiftmodule

To have a valid Logger-Swift.h, we need to make Logger subclass from NSObject and mark the objective-c methods with `@objc`. 

```objc
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
```

The generated header looks something like this

```
@class NSString;

SWIFT_CLASS("_TtC6Logger6Logger")
@interface Logger : NSObject
- (nonnull instancetype)initWithPrefix:(NSString * _Nonnull)prefix OBJC_DESIGNATED_INITIALIZER;
- (void)logStringWithObject:(NSString * _Nonnull)object;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end
```

Once we have the swiftmodule and header, we need to 

1. Turn Logger.swift into a static/dynamic library
2. Compile and link the dylib with main.m

```
xcrun clang -Wall -o main main.m -l Logger -framework Foundation                            
```

### Call Objective-C from Swift

We need two things:

1. A module.modulemap
2. A bridge header

Since Swift cannot import header files, we need to turn the Objective-C class into a Clang module. The way to do that is to use modulemap

```
module PhotoStore {
    header "./PhotoStore-Bridging-Header.h"
    export *
}

// PhotoStore-Bridging-Header.h
#import "PhotoStore.h"
```
Next, we need to compile the objective-c classes into a dylib

```
xcrun clang -c PhotoStore.m
xcrun clang -dynamiclib -o ./libPhotoStore.dylib -install_name ./libPhotoStore.dylib PhotoStore.o -framework Foundation
```
To use the dylib, we also need to tell the compiler where to find the modulemap. This is done through the `-I` flag

```
swiftc -o mainSwift main.swift Logger.swift -I ./  -L ./ -lPhotoStore
```







### Resources

- https://railsware.com/blog/creation-of-pure-swift-module/
- https://rderik.com/blog/understanding-objective-c-and-swift-interoperability/
