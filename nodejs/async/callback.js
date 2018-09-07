const fs = require("fs");
var path = require("path");

module.exports = (dir, cb) => {
  fs.readdir(dir, (er, files) => {
    //1
    if (er) {
      return cb(er);
    }
    console.log(files);
  });
};
