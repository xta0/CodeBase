//nodejs 支持require
var path = require('path');

module.exports = {
    entry: "./app/assets/scripts/App.js",
    output:{
        // 绝对路径
        path: path.resolve(__dirname,"./app/temp/scripts"),
        filename: "App.js"
    }
    
}
