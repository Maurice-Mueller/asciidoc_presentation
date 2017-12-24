#!/usr/bin/env rake

require 'rubygems'
require './build-scripts/build'
require './build-scripts/download'

task :'build-all' do
  buildRevealJS
  #buildSlidesPdf
  buildAsciiDocHtml
  buildAsciidocPdf
end

task :'build-revealjs' do
  buildRevealJS
end

task :build => :'build-revealjs'

task :'init-all' do
  downloadRevealJS
  downloadDecktape
end

task :init do
  downloadRevealJS
end
