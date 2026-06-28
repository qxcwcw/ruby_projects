require 'json'
require 'open-uri'
require_relative 'movie_analyzer'
require_relative 'history_data_bs'

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
  puts '4 Перегляд історії збережених фільмів' 
  puts '5 Вихід'
  print 'Введіть варіант: '
  choice = gets.chomp
  case choice

  when "1"
    puts "Ось топ 20 новинок:"
    top20film = top20(api_key) 
    
    top20film.first(20).each.with_index(1) do |movie, index|
      puts "#{index} Назва: #{movie['title']}"
      puts "Рейтинг: #{movie['vote_average']}"
      puts "Дата виходу: #{movie['release_date']}"
      puts '-' * 40
    end

      puts "\nБажаєте додати фільм зі списку в історію?"
      print "Введіть його номер (або натисніть 0, щоб повернутись до головного меню): "
      choice_num = gets.to_i

      if choice_num > 0 && choice_num <= 20
        selected_movie = top20film[choice_num - 1] 
        Database.add_film(selected_movie['title'], selected_movie['vote_average'], selected_movie['release_date'])
        puts "Фільм '#{selected_movie['title']}' успішно збережено в історію"
      elsif choice_num == 0
       puts 'Назад до головного меню '
      else
        puts "Помилка: такого номера немає в списку."
    end

 when "2"
    print 'Введіть кодове слово англійською (наприклад: space, war, zombie, magic): '
    user_key_word = gets.chomp
    found_movies = search_by_keyword(api_key, user_key_word)

    if found_movies.empty?
      puts "За вашим кодовим словом '#{user_key_word}' нічого не знайдено."
    else
      puts "Знайдено тематичних фільмів: #{found_movies.size}"
      
      found_movies.first(10).each.with_index(1) do |movie, index|
        puts "#{index} Назва: #{movie['title']}"
        puts "Рейтинг: #{movie['vote_average']}"
        puts "Дата виходу: #{movie['release_date']}"
        puts '-' * 40
      end
    end
      puts "\nБажаєте додати фільм зі списку в історію?"
      print "Введіть його номер (або натисніть 0, щоб повернутись до головного меню): "
      choice_num = gets.to_i

      if choice_num > 0 && choice_num <= 10
        selected_movie = found_movies[choice_num - 1] 
        
        Database.add_film(selected_movie['title'], selected_movie['vote_average'], selected_movie['release_date'])
        
        puts "Фільм '#{selected_movie['title']}' успішно збережено в історію"
      elsif choice_num == 0
       puts 'Назад до головного меню '
      else
        puts "Помилка: такого номера немає в списку."
    end

 when "3"
    print 'Введіть бажаний рейтинг фільмів: '
    user_rating = gets.chomp
    good_movies = search_movies_by_rating(api_key, user_rating)

    if good_movies.empty?
      puts "На жаль, фільмів з таким рейтингом не знайдено."
    else
      puts "Знайдено фільмів за заданим рейтингом: #{good_movies.size}"
      
      good_movies.each.with_index(1) do |movie, index|
        puts "#{index} Назва: #{movie['title']}"
        puts "Рейтинг: #{movie['vote_average']}"
        puts "Дата виходу: #{movie['release_date']}"
        puts '-' * 40
      end
    end
        puts "\nБажаєте додати фільм зі списку в історію?"
        print "Введіть його номер (або натисніть 0, щоб повернутись до головного меню): "
        choice_num = gets.to_i

        if choice_num > 0 && choice_num <= good_movies.size
          selected_movie = good_movies[choice_num - 1] 
          
          Database.add_film(selected_movie['title'], selected_movie['vote_average'], selected_movie['release_date'])
          
          puts "Фільм '#{selected_movie['title']}' успішно збережено в історію"
        elsif choice_num == 0
          puts 'Назад до головного меню '
        else
          puts "Помилка: такого номера немає в списку."
    end   

 when "4"
    puts "\n ВАША ІСТОРІЯ ЗБЕРЕЖЕНИХ ФІЛЬМІВ:"
  
    history = Database.saved_film

    if history.count == 0
      puts "Історія поки що порожня"
    else
      puts "Всього збережено фільмів: #{history.count}"
      puts '=' * 40
      
      history.to_a.each.with_index(1) do |movie, index|
        puts "#{index}. Назва: #{movie['name_of_film']}"
        puts "   Рейтинг: #{movie['rating']}"
        puts "   Дата виходу: #{movie['release_date']}"
        puts '-' * 40
      end
    end

  when "5" 
    break
 end
end
