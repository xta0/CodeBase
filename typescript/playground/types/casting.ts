// discriminited unions
interface Bird {
    type: 'bird'; //literal type
    flySpeed: number;
}
interface Horse {
    type: 'horse'
    runSpeed: number
}

type Animal = Bird | Horse

function moveAnimal(animal: Animal) {
    let speed = 0
    switch(animal.type) {
        case 'bird':
          speed = animal.flySpeed
          break;
        case 'horse':
          speed = animal.runSpeed
          break;
    }
    console.log('moving at: ', speed)
}