import Foundation
import PhotoStore

let logger = Logger(prefix: "xtao");
logger.log(object: "yo!")

let store = PhotoStore() 
store.save("a", path: "/tmp")
store.dump()


