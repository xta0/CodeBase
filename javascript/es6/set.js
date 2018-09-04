
//create set
const games = new Set(['Super Mario Bros.', 'Banjo-Kazooie', 'Mario Kart', 'Super Mario Bros.']);

//add elements
games.add('Banjo-Tooie');
games.add('Age of Empires');

//delete elements
games.delete('Super Mario Bros.');

//size
console.log(games.size)

//check element in the set
console.log(games.has('Age of Empires'))

//return all the values in set
console.log(games.values());

//return all the keys , same to values
console.log(games.keys())

//spead all the values
console.log(...games.values());

//clear set
games.clear()

//----------WeakSet-------------

let student1 = { name: 'James', age: 26, gender: 'male' };
let student2 = { name: 'Julia', age: 27, gender: 'female' };
let student3 = { name: 'Richard', age: 31, gender: 'male' };

//create WeakSet obejct
const roster = new WeakSet([student1, student2, student3]);
console.log(roster);

//this will affect weakset
student3 = null;
console.log(roster);