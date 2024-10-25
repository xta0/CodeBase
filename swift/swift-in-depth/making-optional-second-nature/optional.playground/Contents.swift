import Foundation


/*
 public enum Optional<Wrapped> {
    case none
    case some(Wrapped)
 }
 **/


struct Customer {
    let id: String
    let firstName: Optional<String>
    let lastName: Optional<String>
}
