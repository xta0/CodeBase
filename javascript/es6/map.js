
//create a map object
const employees = new Map();

//set
employees.set('james.parkes@udacity.com', { 
    firstName: 'James',
    lastName: 'Parkes',
    role: 'Content Developer' 
});
employees.set('julia@udacity.com', {
    firstName: 'Julia',
    lastName: 'Van Cleve',
    role: 'Content Developer'
});
employees.set('richard@udacity.com', {
    firstName: 'Richard',
    lastName: 'Kalehoff',
    role: 'Content Developer'
});

//check
console.log(employees.has('richard@udacity.com'))

//retrieve element
console.log(employees.get('julia@udacity.com'))

//delete
employees.delete('richard@udacity.com')

//loop all values
for(const employee of employees){
    console.log(employee) //get k-v pair
}

//loop keys
for(const key of employees.keys()){
    console.log(key)
}

//loop values
for(const value of employees.values()){
    console.log(value)
}

//iterator
const itor = employees[Symbol.iterator]()
console.log(itor.next())




