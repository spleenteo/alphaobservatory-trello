#!/usr/bin/env ruby
require 'date'
require 'time'
require 'dotenv'
require "pp"
require "pry"
require 'trello'


def header(content)
  puts "-----------------------------"
  puts content
  puts "-----------------------------"
end


Dotenv.load
Trello.configure do |config|
  header(ENV["TRELLO_DEV_TOKEN"])
  config.developer_public_key = ENV["TRELLO_TOKEN"]
  config.member_token = ENV["TRELLO_DEV_TOKEN"] # The token from step 2.
end

# pp Trello::Board.find("txJrqitV").labels
# pp Trello::Board.find("txJrqitV").labels

@l_generic = ENV['TRELLO_LABEL_GENERIC']
@l_meeting = ENV['TRELLO_LABEL_MEETING']
@l_survey = ENV['TRELLO_LABEL_SURVEY']

coll = [@l_generic].join(",")

desc =[
  "https://survey.alphaobservatory.org/it/admin/interviews/0e2e204a-9007-479b-a066-5ff0582f7c1f",
  "Country: Pakistan",
  "Language: En",
  "Skype: pippo@pluto",
].join("\n")

d = Time.parse("2018-03-06 19:15:59")

pp desc
pp d
pp coll

options = {
  board_id: ENV["TRELLO_BOARD"],
  list_id: ENV["TRELLO_LIST"],
  name: 'Generino, 3 Mar, (Loucamerini) ::Activist',
  card_labels: coll,
  due: d.to_date,
  desc: desc,
  pos: "top"
}
c = Trello::Card.create(options)

pp c
