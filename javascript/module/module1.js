
function Module1() {
  this.hello = function () {
    return 'hello!';
  }

  this.goodbye = function () {
    return 'goodbye!';
  }
}

//exports的是一个object对象
module.exports = Module1;