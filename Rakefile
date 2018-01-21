#!/usr/bin/env rake

require 'rubygems'
require './build-scripts/build'
require './build-scripts/download'
require './build-scripts/cordova'

def clearTaskList(argv)
  argv.each do |arg|
    task arg.to_sym do
      ;
    end
  end
end

def compositesDirectories
  currentDir = Dir.pwd
  Dir.chdir($composites_dir)
  dirs = Dir.glob('*').select {|f| File.directory? f}
  Dir.chdir(currentDir)
  return dirs
end

def buildingComposites(argv)
  argv.shift
  if(argv.empty?)
    return compositesDirectories
  end
  clearTaskList(argv)
  return argv
end

task :'build-all' do
  buildingComposites(ARGV).each {|composite|
    buildRevealJS(composite)
    buildSlidesPdf(composite)
    buildAsciiDocHtml(composite)
    buildAsciidocPdf(composite)
  }
  clearTaskList(ARGV)
end

task :'build-revealjs' do
  buildingComposites(ARGV).each {|composite|
    print "Building composite <" + composite + ">\n"
    buildRevealJS(composite)
  }
end

task :build => :'build-revealjs'

task :'init-all' do
  initDirs
  downloadRevealJS
  downloadDecktape
end

task :init do
  initDirs
  downloadRevealJS
end

task :'init-cordova' do
  installCordova
end

task :'init-cordova' do
  initCordova
end

task :'build-cordova' do
  buildCordova
end

task :'run-cordova' do
  runCordova
end
