abstract class Department {
    constructor(protected name: string) {
        this.name = name
    }
    // if we have an abstract function in the class, the class itself needs to be abstract
    abstract describe(): string;
}

class ITDepartment extends Department {
    describe(): string {
        return this.name
    }
}

const x = new ITDepartment("Apple")
console.log()
