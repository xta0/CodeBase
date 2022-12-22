namespace NAME{

    interface Person {
        name: string
        sayHello()
    }

    interface Consturctor {
        new (name: string): Person
    }

    interface Skill extends Person{
        skill(): string
    }

    class Player implements Skill {
        constructor(readonly name: string) {}
        sayHello() {
            console.log("Hello!")
        }
        skill(): string {
            return "Basketball"
        }
    }
    class Gamer extends Player {
        override skill(): string {
            return "CS GO"
        }
    }

    function test(x: Skill) {
        console.log(x)
    }

    const p = new Gamer('AJ')
    test(p)

    function platformFactory(cons: Consturctor, name: string){
        return new cons(name)
    }
    const p2 = platformFactory(Player, 'kk')

    const MAP1 = {
        'player': Player,
        'gamer': Gamer,
    }


}
