#!/usr/bin/env ruby

require 'webrick'
require 'fileutils'


port = ENV['PORT'] || 8081

server = WEBrick::HTTPServer.new :Port => port, :DocumentRoot => "Documents"

FileUtils.mkdir_p( './Documents' )
codesfile = File.join( './Documents', 'codes.txt' )
FileUtils.touch( codesfile )

server.mount_proc '/clear_codes' do |req,res|
  File.open(codesfile, 'w') {|file| file.truncate(0) }
end

server.mount_proc '/add_code' do |req,res|
  code = req.query['code']
  File.open(codesfile, 'a') {|file| file.puts(code) }
end

server.start