require 'rubygems'
require 'bundler/setup'

require './build-scripts/common'
require './config'

def installCordova
  %x(npm install -g cordova)
end

def initCordova(composite)
  workingDirEscaped = escapeString(cordovaWorkingDir(composite))
  %x(cordova create #{workingDirEscaped} com.example.presentation #{escapeString(composite)})
  for platform in $cordova_platforms
    %x(cd #{workingDirEscaped} && cordova platform add #{platform})
  end
end

def buildCordova(composite)
  workingDir = cordovaWorkingDir(composite)
  FileUtils.rm_rf("#{workingDir}/www")
  FileUtils.cp_r("#{revealJSWorkingDir(composite)}", "#{workingDir}/www")
  FileUtils.mv("#{workingDir}/www/#{composite}.html", "#{workingDir}/www/index.html")
  %x(cd #{escapeString(workingDir)} && cordova build)
end

def runCordova(composite)
  workingDirEscaped = escapeString(cordovaWorkingDir(composite))
  %x(cd #{workingDirEscaped} && cordova run android)
end