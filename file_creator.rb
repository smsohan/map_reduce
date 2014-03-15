require 'rubygems'
require 'bundler/setup'
Bundler.require

count = (ENV['FILES'] || 10).to_i
phrases = (ENV['PHRASES'] || 10_000).to_i

0.upto(count) do |num|
  File.open("files/words-#{num}.txt", "w") do |file|
    file.puts phrases.times.map{|_| RandomWord.nouns.next }.join(" ")
  end
end
