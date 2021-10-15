class Person {
    constructor(firstname, lastname) {
        this.firstname = firstname;
        this.lastname = lastname;
    }
    log() {
        console.log(this)
        const self = this;
        function rename(name) {
            console.log(self)
            self.firstname = name;
            console.log(self)
        }
        rename('123')
    }
}

const p = new Person("Jason", "Xu")
p.log()