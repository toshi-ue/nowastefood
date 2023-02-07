// // https://github.com/rails/jsbundling-rails/blob/main/docs/switch_from_webpacker.md#optional-css--sass
// // https://techracho.bpsinc.jp/hachi8833/2022_09_06/115289
// const mode = process.env.NODE_ENV === 'development' ? 'development' : 'production';

// const path = require("path")
// const webpack = require("webpack")


// // Extracts CSS into .css file
// const MiniCssExtractPlugin = require('mini-css-extract-plugin');
// // Removes exported JavaScript files from CSS-only entries
// // in this example, entry.custom will create a corresponding empty custom.js file
// const RemoveEmptyScriptsPlugin = require('webpack-remove-empty-scripts');

// module.exports = {
//   entry: {
//     application: [
//       // './app/assets/images/*.*',
//       // './app/assets/javascripts/*.*',
//       './app/assets/stylesheets/application.scss',
//       './app/javascript/packs/application.js'
//     ]
//   },
//   mode,
//   module: {
//     rules: [
//       // Add Babel rule with loaders
//       {
//         // exclude: /node_modules/,
//         test: /\.(js|jsx)$/,
//         use: ['babel-loader'],
//       },
//       // Add CSS/SASS/SCSS rule with loaders
//       {
//         test: /\.(?:sa|sc|c)ss$/i,
//         use: [MiniCssExtractPlugin.loader, 'css-loader', 'sass-loader'],
//       },
//       // // Add Babel rule with loaders
//       // {
//       //   test: /\.(png|jpe?g|gif|eot|woff2|woff|ttf|svg)$/i,
//       //   use: 'file-loader',
//       // },
//       // Add Fonts, Images, SVG rule with loaders
//       // https://jun-app.com/series/well-study-webpack/2
//       {
//         test: /\.(png|jpe?g|gif|eot|woff2|woff|ttf|svg)$/i,
//         use: [
//           {
//             loader: 'file-loader',
//             // options: {
//             //   limit: 8192,
//             //   name: './app/assets/images/[name].[ext]'
//             // }
//           },
//         ],
//         // type: 'javascript/auto'
//       },
//       // {
//       //   test: /\.(png|jpg|gif)$/i,
//       //   // ここから変更。useがなくなり。typeが変更されている。
//       //   generator: {
//       //     filename: 'imgs/[name][ext][query]'
//       //   },
//       //   type: 'app/assets/images'
//       // },
//     ],
//   },
//   optimization: {
//     moduleIds: 'deterministic',
//   },
//   output: {
//     filename: "[name].js",
//     sourceMapFilename: "[file].map",
//     path: path.resolve(__dirname, '..', '..', "app/assets/builds"),
//   },
//   plugins: [
//     // Include plugins
//     new webpack.optimize.LimitChunkCountPlugin({
//       maxChunks: 1
//     }),
//     new RemoveEmptyScriptsPlugin(),
//     new MiniCssExtractPlugin(),
//   ],
//   resolve: {
//     // Add additional file types
//     extensions: ['.js', '.jsx', '.scss', '.css'],
//   },
//   // devtool: "source-map",
//   // entry: {
//   //   application: "./app/javascript/application.js"
//   // },
// }
