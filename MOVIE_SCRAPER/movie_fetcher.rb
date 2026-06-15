require 'json'
require 'open-uri'
require_relative 'movie_analyzer'
api_key = '3e08f11a8b811ec4da789a12b30dc40d'
url_top20movie = "https://api.themoviedb.org/3/movie/popular?api_key=#{api_key}&language=uk-UA"
top20_list_movie = URI.open(url_top20movie).read
top20 = JSON.parse(top20_list_movie)
now_top_20_movie = top20['results'] 

loop do
  puts 'Виберіть один з варіантів'
  puts '1 Топ 20 новинок'
  puts '2 Пошук фільму за кодовими словами'
  puts '3 Пошук фільмів за рейтингом'
  puts '4 Вихід'
  print 'Введіть варіант: '
  choice = gets.chomp
  case choice

  when "1"
    puts "Ось топ 20 новинок:"
    top20film = top20(api_key) 
    
    top20film.first(20).each do |movie|
      puts "Назва: #{movie['title']}"
      puts "Рейтинг: #{movie['vote_average']}"
      puts "Дата виходу: #{movie['release_date']}"
      puts '-' * 40
    end

 when "2"
    print 'Введіть кодове слово англійською (наприклад: space, war, zombie, magic): '
    user_key_word = gets.chomp
    found_movies = search_by_keyword(api_key, user_key_word)

    if found_movies.empty?
      puts "За вашим кодовим словом '#{user_key_word}' нічого не знайдено."
    else
      puts "Знайдено тематичних фільмів: #{found_movies.size}"
      
      found_movies.first(10).each do |movie|
        puts "Назва: #{movie['title']}"
        puts "Рейтинг: #{movie['vote_average']}"
        puts "Дата виходу: #{movie['release_date']}"
        puts '-' * 40
      end
    end
  
when "3"
    print 'Введіть бажаний рейтинг фільмів: '
    user_rating = gets.chomp
    good_movies = search_movies_by_rating(api_key, user_rating)

    if good_movies.empty?
      puts "На жаль, фільмів з таким рейтингом не знайдено."
    else
      puts "Знайдено фільмів за заданим рейтингом: #{good_movies.size}"
      
      good_movies.each do |movie|
        puts "Назва: #{movie['title']}"
        puts "Рейтинг: #{movie['vote_average']}"
        puts "Дата виходу: #{movie['release_date']}"
        puts '-' * 40
      end
    end

when "4"
  break
 end
end
