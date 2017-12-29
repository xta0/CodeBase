/* constructor */

function House(bedrooms, bathrooms, numSqrt){
    this.bedrooms = bedrooms;
    this.bathrooms = bathrooms;
    this.numSqrt = numSqrt;
}

var firstHouse = new House(3,2,1000);
console.log (firstHouse.bedrooms);
console.log (firstHouse.bathrooms);
console.log (firstHouse.numSqrt);