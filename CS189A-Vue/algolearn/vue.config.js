const { defineConfig } = require('@vue/cli-service')
module.exports = defineConfig({
  transpileDependencies: true
})
const NodePolyfillPlugin = require("node-polyfill-webpack-plugin")
module.exports = defineConfig({
  transpileDependencies: true,
  configureWebpack: {
    plugins: [
      new NodePolyfillPlugin()
    ],
    resolve: {
      fallback: {
        "fs": false,
        "./zlib_bindings":false
    },
    }
  }

})