var path = require("path");

module.exports = {
  context: __dirname,
  entry: "./frontend/entry",
  output: {
    path: path.join(__dirname, 'app', 'assets', 'javascripts'),
    filename: "squirrelchase.js"
  },
  resolve: {
    extensions: ["", ".js", ".jsx"]
  },
  module: {

  },
  devtool: "source-map"
};
