require 'open-uri'
require 'json'
require_relative 'analyzer'
require_relative 'csv_exporter'

news_about_ast_csm = URI.open("https://api.spaceflightnewsapi.net/v4/articles/?limit=10").read
news = JSON.parse(news_about_ast_csm)

info = news["results"]


print "Ведіть кодове слово: "
keyword = gets.chomp 

filtred_info = filtred_info_by_wors(info, keyword)


if filtred_info.empty?
puts "За цими словами нічого не знайденно"
else 
    puts "Ось статі за вашим запитом #{filtred_info.size}"




filtred_info.each do |item|
title = item["title"]
site = item["news_site"]
summary = item["summary"]

puts "Новини про: #{title}"
puts "Сайт #{site}"
puts "Коротко про статтю: #{summary}"
puts "-" * 50

news_history = "news_#{keyword}.csv"
  
  
  csv_export(filtred_info, news_history)



end
end