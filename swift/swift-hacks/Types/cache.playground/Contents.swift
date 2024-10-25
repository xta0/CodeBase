import UIKit

protocol Cachable {
  associatedtype CacheType
  static func decode(_ data: Data) -> CacheType?
  func encode() -> Data?
}

struct Superhero: Codable, Cachable {
    let firstName: String
    let lastName: String
}

//extension Superhero: Cachable {
//    typealias CacheType = Superhero
//    public static func decode(_ data: Data) -> Superhero? {
//        guard let fullName = String(data: data, encoding: String.Encoding.utf8) else {
//            return nil
//        }
//        let fullNameArr = fullName.components(separatedBy: " ")
//        let firstName    = fullNameArr[0]
//        let lastName = fullNameArr[1]
//        return Superhero(firstName: firstName, lastName: lastName)
//    }
//    public func encode() -> Data? {
//        let fullName = firstName + " " + lastName
//        return fullName.data(using: String.Encoding.utf8)
//    }
//}
