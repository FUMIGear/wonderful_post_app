const path    = require("path")
const webpack = require("webpack")

module.exports = {
  mode: "production",
  devtool: "source-map",
  entry: {
    application: "./app/javascript/packs/application.js"
  },
  output: {
    filename: "application.js",
    sourceMapFilename: "testbuild.map",
    path: path.resolve(__dirname, "app/assets/builds")
  },
  plugins: [
    new webpack.optimize.LimitChunkCountPlugin({
      maxChunks: 1
    })
  ]
}
