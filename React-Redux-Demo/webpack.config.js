const path = require('path')

module.exports = {
    entry: {
      index: path.resolve("./app/src/index.js")
    },
    output: {
        path: path.resolve("./app/build/scripts"),
        filename: 'bundle.js'
    },
    module: {
      rules: [
        {
          loader: 'babel-loader',
          query: {
            presets: ['env','react']
          },
          test: /\.js$/,
          exclude: /node_modules/
        }
      ]
    }
  }