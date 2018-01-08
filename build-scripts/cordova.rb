require 'rubygems'
require 'bundler/setup'

require './build-scripts/common'
require './config'

def installCordova
  %x(npm install -g cordova)
end

def initCordova
  %x(cordova create #{$cordova_out_dir} com.example.presentation presentation)
  for platform in $cordova_platforms
    %x(cd #{$cordova_out_dir} && cordova platform add #{platform})
  end
end

def buildCordova
  FileUtils.rm_rf("#{$cordova_out_dir}/www")
  FileUtils.cp_r("#{$revealjs_out_dir}", "#{$cordova_out_dir}/www")
  FileUtils.mv("#{$cordova_out_dir}/www/#{$project_name}.html", "#{$cordova_out_dir}/www/index.html")
  %x(cd #{$cordova_out_dir} && cordova build)
end

def runCordova
  %x(cd #{$cordova_out_dir} && cordova run android)
end