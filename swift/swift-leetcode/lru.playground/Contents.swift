import Foundation


class Node {
    let key: Int
    let value: Int
    var prev: Node?
    var next: Node?
    init(key: Int, value: Int) {
        self.key = key
        self.value = value
    }
}

class LRUCache {
    let capacity: Int
    // a linked list to maintain the LRU rule
    var head: Node?
    var tail: Node?
    // a hashmap to quickly find the node by key
    var lookup: [Int: Node] = [:]
    // current length of the linked list
    var count: Int = 0

    init(_ capacity: Int) {
        self.capacity = capacity
    }
    
    func get(_ key: Int) -> Int {
        print("get key: \(key)")
        guard let node = self.lookup[key] else {
            return -1
        }
        self.moveToFront(node)
        return node.value
    }
    
    func put(_ key: Int, _ value: Int) {
        print("put key: \(key), value: \(value)")
        if let node = self.lookup[key] {
            self.moveToFront(node)
        } else {
            // create a new node
            let node = Node(key: key, value: value)
            self.lookup[key] = node
            if self.count == 0 {
                self.head = node
                self.tail = node
                self.count += 1
                return
            }
            if self.count == self.capacity {
                if self.capacity == 1 {
                    self.head = node
                    self.tail = node
                } else {
                    self.removeTail()
                    self.insertFront(node)
                }
                return
            }
            self.insertFront(node)
            self.count += 1
            return
        }
    }

    func moveToFront(_ node: Node) {
        self.detach(node)
        self.insertFront(node)
    }

    func removeTail() {
        let prev = self.tail?.prev
        prev?.next = nil
        self.tail = prev
    }
    
    func detach(_ node: Node) {
        node.prev?.next = node.next
        node.next?.prev = node.prev
        node.next = nil
        node.prev = nil
    }

    func insertFront(_ node: Node) {
        node.next = self.head
        self.head?.prev = node
        self.head = node
    }
    
    func printNodes() {
        var current: Node? = self.head
        var str: String = ""
        while let node = current {
            str += "(\(node.key):\(node.value)) -> "
            current = node.next
        }
        print(str + "nil")
    }
}

/**
 * Your LRUCache object will be instantiated and called as such:
 * let obj = LRUCache(capacity)
 * let ret_1: Int = obj.get(key)
 * obj.put(key, value)
 */
let cache = LRUCache(2)
cache.put(1, 1)
cache.printNodes()

cache.put(2, 2)
cache.printNodes()

print(cache.get(1))
cache.printNodes()

cache.put(3, 3)
cache.printNodes()

print(cache.get(2))
cache.printNodes()

cache.put(4, 4)
cache.printNodes()

print(cache.get(1))
cache.printNodes()

print(cache.get(3))
cache.printNodes()

print(cache.get(4))
cache.printNodes()
