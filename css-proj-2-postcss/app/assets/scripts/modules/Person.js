function Person(name,sex){
    this.name = name;
    this.sex = sex;
    this.say = function(){
        console.log("This is "+name);
    }
}
module.exports = Person;