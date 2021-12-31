require "http/client"
require "./crss/parser"

module CRSS
  VERSION = "0.1.0"

  # TODO: Put your code here

  example = "https://www.nasa.gov/rss/dyn/breaking_news.rss"
  document = HTTP::Client.get example
  outcome = CRSS::Parser.new(document.body).parse
  puts outcome
end
