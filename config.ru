require 'rubygems'
require 'bundler'

Bundler.require

# don't buffer stdout
$stdout.sync = true

require './app'
run CutgroupSignups