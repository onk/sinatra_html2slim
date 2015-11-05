require "bundler"
Bundler.require(:default, ENV["RACK_ENV"])
require File.join(__dir__, "app")
run App
