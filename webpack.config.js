var path = require('path');
var config = require('famous-webpack-seed');

config.context     = path.join(__dirname, "src");
config.output.path = path.join(__dirname, "dist");

config.resolve.extensions = [
  '', '.webpack.js', '.web.js', '.js',  // defaults
  '.coffee'
];

// config.resolve.modulesDirectories = [
//   'node_modules', 'web_modules',  // defaults
//   'src'
// ];

module.exports = config;
