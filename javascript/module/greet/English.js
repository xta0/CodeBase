var text = require('./config.json')
function greet(){
    console.log(text.en);
}
module.exports = greet;