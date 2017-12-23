require 'rubygems'
require 'bundler/setup'

require './build-scripts/common'
require './config'

def downloadRevealJS
  download("https://github.com/hakimel/reveal.js/archive/#{$revealjs_version}.zip", 'lib/revealjs.zip')
  unzip_file('lib/revealjs.zip', 'lib/')
end

def downloadDecktape
  download("https://github.com/astefanutti/decktape/archive/v#{$decktape_version}.zip", 'lib/decktape.zip')
  unzip_file('lib/decktape.zip', 'lib/')
  %x(cd lib/decktape-#{$decktape_version} && npm install)
end
