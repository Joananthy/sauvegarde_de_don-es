require 'bundler'
Bundler.require
require 'json'

$:.unshift File.expand_path("./../lib", __FILE__)
require 'scrapper'

#  Scrapper.new.save_as_JSON

 json = File.read('db/emails.JSON')
obj = JSON.parse(json)

puts obj
