var Emitter = require("events");
var eventsConfig = require("./config").events;

var emtr = new Emitter();
emtr.on(eventsConfig.GREET, function() {
  console.log("#1 said hello.");
});
emtr.on(eventsConfig.GREET, function() {
  console.log("#2 said hello.");
});

emtr.emit(eventsConfig.GREET);
