function Greet(){
    this.msg = "greet3",
    this.greet = function(){
        console.log(this.msg);
    }
}
module.exports = new Greet()