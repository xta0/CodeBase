function Node(value) {
    this.value = value
    this.parent = null
    this.children = []
}

var n = new Node(10)
console.log(n.value)