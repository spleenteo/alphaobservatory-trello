#!/usr/bin/env ruby
require 'date'
require 'dotenv'
require 'faker'
require "pp"
require "pry"
require 'time'
require 'trello'


def header(content)
  puts "-----------------------------"
  puts content
  puts "-----------------------------"
end

Dotenv.load

client = Trello::Client.new(
  developer_public_key: ENV["TRELLO_TOKEN"],
  member_token: ENV["TRELLO_DEV_TOKEN"]
)

@l_generic = ENV['TRELLO_LABEL_GENERIC']
@l_meeting = ENV['TRELLO_LABEL_MEETING']
@l_survey  = ENV['TRELLO_LABEL_SURVEY']

coll = [@l_survey, @l_meeting].join(",")

date_meeting  = nil
date_training = nil
date_meeting  = Time.parse("2018-03-15 16:15:59")
date_training = Time.parse("2018-03-10 09:45:00")
date_test = nil

meeting_dates = []
meeting_dates.push(date_meeting) if !date_meeting.nil?
meeting_dates.push(date_training) if !date_training.nil?
meeting_dates.push(date_test) if !date_test.nil?

first_date = meeting_dates.any? ? meeting_dates.sort[0] : nil

desc =[
  "https://survey.alphaobservatory.org/it/admin/interviews/0e2e204a-9007-479b-a066-5ff0582f7c1f",
  "Country: #{Faker::Address.country}",
  "Language: #{Faker::Address.country_code}",
  "Skype: #{Faker::Internet.free_email}",
  "Meeting date: #{date_meeting}",
  "Training date: #{date_training}"
].join("\n")

username = Faker::Name.name
interviewer = Faker::Ancient.god

pp desc
puts "----------"
pp meeting_dates[0]
pp coll
pp meeting_dates
pp first_date

card = client.create(:card, {
  board_id: ENV["TRELLO_BOARD"],
  list_id: ENV["TRELLO_LIST"],
  name: "#{username}, 3 Mar, (#{interviewer}) ::Activist",
  card_labels: coll,
  due: first_date,
  desc: desc,
  pos: "top"
})

header 'Card created!'
puts card.url

# pp card
