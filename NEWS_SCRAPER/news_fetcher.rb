require 'open-uri'
require 'json'
require_relative 'analyzer'
require_relative 'csv_exporter'

url = 'https://api.spaceflightnewsapi.net/v4/articles/?limit=10'
news_about_ast_csm = URI.open(url).read
news = JSON.parse(news_about_ast_csm)

info = news['results']

print 'Введіть кодове слово: '
keyword = gets.chomp 

filtered_info = filter_info_by_words(info, keyword)

if filtered_info.empty?
  puts 'За цими словами нічого не знайдено'
else 
  puts "Ось статті за вашим запитом: #{filtered_info.size}"

  filtered_info.each do |item|
    title = item['title']
    site = item['news_site']
    summary = item['summary']

    puts "Новини про: #{title}"
    puts "Сайт: #{site}"
    puts "Коротко про статтю: #{summary}"
    puts '-' * 50
  end

  news_history = "news_#{keyword}.csv"
  csv_export(filtered_info, news_history)
end