# Install webpacker
puts "Creating javascript app source directory"
directory "#{__dir__}/javascript", "app/javascript"

puts "Copying binstubs"
directory "#{__dir__}/bin", "bin"
chmod "bin", 0755 & ~File.umask, verbose: false

puts "Copying webpack core config and loaders"
directory "#{__dir__}/config/webpack", "config/webpack"
directory "#{__dir__}/config/loaders/core", "config/webpack/loaders"
copy_file "#{__dir__}/config/.postcssrc.yml", ".postcssrc.yml"

append_to_file ".gitignore", <<-EOS
/public/packs
/node_modules
EOS

puts "Installing all JavaScript dependencies"
run "./bin/yarn add webpack webpack-merge js-yaml path-complete-extname " \
"webpack-manifest-plugin babel-loader coffee-loader coffee-script " \
"babel-core babel-preset-env compression-webpack-plugin rails-erb-loader glob " \
"extract-text-webpack-plugin node-sass file-loader sass-loader css-loader style-loader " \
"postcss-loader autoprefixer postcss-smart-import precss"

puts "Installing dev server for live reloading"
run "./bin/yarn add --dev webpack-dev-server"

puts "Webpacker successfully installed 🎉 🍰"
