/////////////////////////////////////////////////////////////
// optional chaining

const fetchedUserData = {
    id: 'u1',
    name: 'Tao',
    age: 100,
    job: { title: 'CEO', desc: 'Apple'}
};
console.log(fetchedUserData?.job?.title)

/////////////////////////////////////////////////////////////
// Nullish coalescing

const userInput = null;
// If userInput is null or undefined, use ??
const storeData = userInput ?? 'a'