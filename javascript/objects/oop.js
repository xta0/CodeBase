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

function Car(make, model, year){
    this.make  = make;
    this.model = model;
    this.year  = year;
    this.numWheels = 4;
}

function MotoCycle(make, model, year){
    //using call
    Car.call(this, make, model, year)
    Car.apply(this, [make,model,year]);
    Car.apply(this,arguments)
    this.numWheels = 2;
}

var motocycle = new MotoCycle("a","b","2011")
console.log (motocycle.numWheels) //2



