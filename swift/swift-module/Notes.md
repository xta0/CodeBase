- Swift module - https://railsware.com/blog/creation-of-pure-swift-module/
- Create a static library

```
 xcrun swiftc -emit-library -emit-object Logger.swift -sdk $(xcrun --show-sdk-path --sdk macosx) -module-name Logger
 xcrun swiftc -emit-library Logger.swift -sdk $(xcrun --show-sdk-path --sdk macosx) -module-name Logger
 xcrun swiftc -emit-object Logger.swift -sdk $(xcrun --show-sdk-path --sdk macosx) -module-name Logger
 xcrun swiftc -emit-module Logger.swift -sdk $(xcrun --show-sdk-path --sdk macosx) -module-name Logger
 xcrun swiftc -sdk $(xcrun --show-sdk-path --sdk ios) -module-name Logger
 xcrun swiftc -sdk $(xcrun --show-sdk-path --sdk iphonesimulator) Logger.swift
```