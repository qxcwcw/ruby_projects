require_relative 'car'
require_relative 'database'
# Примусово змушуємо консоль приймати та виводити текст в UTF-8
Encoding.default_external = Encoding::UTF_8
loop do 
  puts "1 Додати нову машину"
  puts "2 Знайти машину по номеру і перевірити знос запчатин"
  puts "3 Обновити дані про стан запчастин "
  puts "4 Вийти"
  print "Виберіть дію: "

  choice = gets.strip

  case choice

  when "1"
    puts "\n РЕЄСТРАЦІЯ НОВОГО КЛІЄНТА "

    print "Введіть номер машини"
    number = gets.strip
    if Database.find_cars_users(number)
      puts "Машина з таким номером уже є у базі СТО "
      next
    end
    print "Введіть марку машини"
    mark = gets.strip
    print "Ведіть модель машини"
    model = gets.strip
    print "Введіть поточний пробіг машини (км): "
    kilometers = gets.to_i

    puts "\n[ Введіть пробіг, на якому мінявся розхідник востаннє ]"
    
    print " Заміна мастила двигуна (км): "
    oil_last_changes = gets.to_i

    print " Заміна повітряного фільтра двигуна (км): "
    last_outside_filter_changes = gets.to_i

    print " Заміна салонного фільтра (км): "
    last_inside_filter_changes = gets.to_i

    print " Заміна гальмівних колодок/блінів (км): "
    last_brake_changes = gets.to_i

    print " Заміна антифризу (км): "
    cooling_last_changes = gets.to_i


    Database.add_cars_users(
      number, mark, model, kilometers, 
        oil_last_changes, last_outside_filter_changes, 
        last_inside_filter_changes, last_brake_changes, cooling_last_changes
    )

    puts "\n Машину #{mark} #{model} [#{number}] успішно занесено в базу СТО"

  when "2"

    print "Введіть номер машини (ВС1715СВ)"
    number = gets.strip

    row = Database.find_cars_users(number)

    if row

    
      oil_last_changes = row [4].to_i
      last_outside_filter_changes = row [5].to_i
      last_inside_filter_changes = row [6].to_i
      last_brake_changes = row [7].to_i
      cooling_last_changes = row [8].to_i

      puts "\n Машину знайдено: #{row[1].upcase} #{row[2].upcase} [#{row[0]}]"
      puts " ІСТОРІЯ ОСТАННІХ ЗАМІН НА СТО:"
      puts " Мастило мінялося на пробігу: #{ oil_last_changes} км"
      puts " Повітряний фільтр мінявся на: #{last_outside_filter_changes} км"
      puts " Салонний фільтр мінявся на: #{last_inside_filter_changes} км"
      puts " Гальмівні колодки мінялися на: #{last_brake_changes} км"
      puts " Антифриз мінявся на пробігу: #{cooling_last_changes} км"
  
      print "Введіть поточний пробіг машини на сьогодні (км): "
      kilometers = gets.to_i




      cars_sto = Car.new(
        row[0], row[1], row[2], kilometers, 
        oil_last_changes, last_outside_filter_changes, last_inside_filter_changes, last_brake_changes, cooling_last_changes
      )

      puts "\n АКТУАЛЬНИЙ СТАН ЗАПЧАСТИН ПРИ ПРОБІГУ #{cars_sto.kilometers} км:"
      puts " Мастило двигуна залишилось: #{cars_sto.calculate_oil_left} км"
      puts " Фільтр повітря залишилось: #{cars_sto.calculate_outside_filter_left} км"
      puts " Фільтр салону залишилось: #{cars_sto.calculate_inside_filter_left} км"
      puts " Гальмівні колодки залишилось:#{cars_sto.calculate_brake_left} км"
      puts " Антифриз залишилось: #{cars_sto.calculate_cooling_liqvid_left} км"

    end

  when "3"
    puts "1 Масло "
    puts "2 Повітряний фільтр салону"
    puts "4 Повітряний фільтр двигуна"
    puts "5 Гальмівні колодки"
    puts "6 Охолоджуюча рідина"
    print "7 Виберіть по якій запчатині ви б хотіли обновити дані(км)"

  when "4"

    break
  


  end
end