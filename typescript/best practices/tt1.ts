import { preProcessFile } from "typescript";

type User = {
    name: string,
    age: number
    profession?: string
}

// User partial to create partially fillable types
const user: Partial<User> = {
    name: "John Doe"
};

// Make optional types required
const user2: Required<User> = {
    name: "John Doe",
    age: 14,
    profession: "Gamer",
}

// Ignore null or undefined values with !
console.log(user.profession!) // accept whatever types given to the profession

// Create a type with fileds of another type
type Item = {
    name: string;
    desc: string;
    price: number;
    currency: string;
    image: string;
}

type ItemPreview = Pick<Item, "name" | "image">;

// Exclue properties from a type
type PricelessItem = Omit<Item, "price">

// Create immutable types
const user3 = {
    name: "John",
    age: 26
} as const;
// can't mutate the property
// user3.name = "Jordan"

const skills = ["a", "b"] as const;

type Game = {
    readonly people: ReadonlyArray<string>;
}
const game = {
    people: ["abc"]
}
game.people.push("xyz")
console.log(game)

// Create type from any given data
type UserType = typeof user2
const user4: UserType = {
    name: "Kate",
    age: 19,
    profession: "x"
} 

// Dynamically typed string using template literal types
function handler(evenType: `on${string}`) {
    console.log('handling ${evenType}');
}
handler('onClick')
handler('onKeydown')
// handler('escape') // wrong

// create class properties using Constructor
class Person {
    constructor(public name: string) {

    }
}
const p: Person = { name: "X" }
console.log(p.name)

// avoid errors using unknown types
function log(val: unknown) {
    //type guard
    if(typeof val === 'string') {
        console.log(val.toUpperCase());
    }
    console.log((val as number) + 20)
}

// Create mapped types using Record type
type AgesType = {
    [name: string]: number;
}
type SameAgesType = Record<string, number>

const ages1: AgesType = {
    "Jayson": 20,
    "Bob": 21,
}

const ages2: SameAgesType = {
    "Jayson": 20,
    "Bob": 21,
}

// Reduce duplicated types with Generic types
type Box<T> = {
    name: string;
    content: T;
};

const stringBox: Box<string> = {
    name : "String A",
    content: "kkk"
}

const numberBox: Box<number> = {
    name : "String A",
    content: 10
}

const x = {
    "1": [1, 2]
}
const aa = 'b' + 'c'
const y = x[aa]
  