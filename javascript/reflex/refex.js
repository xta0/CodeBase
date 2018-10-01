const obj1 = {
  name: 'Jason',
  greet: msg => {
    console.log(msg);
  }
};
const obj2 = {};

Object.getOwnPropertyNames(obj1).forEach(name => {
  console.log(name); //name, greet
  const descriptor = Object.getOwnPropertyDescriptor(obj1, name);
  Object.defineProperty(obj2, name, descriptor);
});
console.log(obj2.name);
obj2.greet('msg');

// function merge(dest, src, redefine) {
//   if (!dest) {
//     throw new TypeError('argument dest is required');
//   }

//   if (!src) {
//     throw new TypeError('argument src is required');
//   }

//   if (redefine === undefined) {
//     // Default to true
//     redefine = true;
//   }

//   Object.getOwnPropertyNames(src).forEach(function forEachOwnPropertyName(
//     name
//   ) {
//     if (!redefine && hasOwnProperty.call(dest, name)) {
//       // Skip desriptor
//       return;
//     }

//     // Copy descriptor
//     var descriptor = Object.getOwnPropertyDescriptor(src, name);
//     Object.defineProperty(dest, name, descriptor);
//   });
// }
