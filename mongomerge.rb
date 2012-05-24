#!/usr/bin/env ruby
require 'uri'
require 'tmpdir'

def split_uri(uri)
  parts = URI.parse(uri)
  raise "scheme must be mongodb, found #{parts.scheme}" unless parts.scheme == 'mongodb'
  info = {
    host:     parts.host,
    port:     parts.port,
    database: parts.path.gsub(/^\//, ''),
    username: parts.user,
    password: parts.password
  }
end

def merge source_uri, target_uri, drop = false
  target = split_uri target_uri
  source = split_uri source_uri

  Dir::Tmpname.create('dump') do |path|
    system "mongodump -h #{source[:host]} --port #{source[:port]} -u #{source[:username]} -p #{source[:password]} --db #{source[:database]} --out #{path}"
    system "mongorestore #{"--drop" if drop} -h #{target[:host]} #{"--port #{target[:port]}" if target[:port]} #{"-u #{target[:username]}" if target[:username]} #{"-p #{target[:password]}" if target[:password]} --db #{target[:database]} #{path}/#{source[:database]}"
  end
end

if ARGV.length < 2
  puts 'Usage: mongomerge source_uri target_uri [--drop]'
  exit 1
end

source_uri, target_uri = ARGV
puts "Merging\n#{source_uri} into\n#{target_uri}\nCorrect[yes/no]?"
response = $stdin.gets.chomp
exit 1 unless response.downcase == 'yes'

merge(ARGV[0], ARGV[1], ARGV[2] == '--drop')
