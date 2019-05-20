const path = require('path');

module.exports = {
  context: __dirname,
  entry: './frontend/entry.js',
  output: {
    path: path.resolve(__dirname),
    filename: './bundle.js',
  },
  module: {
    rules: [
      {
        test: [/\.jsx?$/, /\.js?$/],
        exclude: /(node_modules)/,
        loader: 'babel-loader',
        query: {
          presets: ['@babel/react', '@babel/preset-env'],
        },
      },
    ],
  },
  devtool: 'source-map',
  resolve: {
    extensions: ['.js', '.jsx', '*'],
  },
  mode: 'development',
};
