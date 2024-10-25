import Foundation

struct Struct<Properties> {
    var name: String
    var properties: Properties
}

struct Property<Value> {
    var name: String
    var value: Value
}

struct List<Head, Tail> {
    var head: Head
    var tail: Tail
}

struct Empty { }

struct Book {
    var title: String
    var published: Date

    typealias Structure = Struct<List<Property<String>, List<Property<Date>, Empty>>>

    var to: Structure {
        .init(name: "Book",
              properties:
                .init(
                    head: .init(name: "title", value: title),
                    tail: .init(head: .init(name: "published", value: published), tail: .init())))
    }

    static func from(_ s: Structure) -> Self {
        .init(title: s.properties.head.value, published: s.properties.tail.head.value)
    }
}
