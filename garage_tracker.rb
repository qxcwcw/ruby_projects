
oil_life = 8000
oil_last_changes = 0
air_outside_filter_life = 10000
last_outside_filter_life = 0
air_inside_filter_life = 15000
last_inside_filter_changes = 0
brake_life = 30000
last_brake_changes = 0
cooling_liquid_life = 60000
cooling_last_changes = 0



puts "Cars_Tracer"

print "Введіть марку машини: "
car_mark = gets.strip

print "Введіть модель машини: "
car_model = gets.strip

print "Введіть пробіг (км): "
car_kilometers = gets.to_i



loop do
  puts "\n Cars_Tracer"
  puts "1. Переглянути загальний стан автомобіля (#{car_mark} #{car_model})"
  puts "2. Вихід з програми"
  print "Виберіть дію (1-2): "

  choice = gets.strip

  case choice
  when "1"
    puts "\n--- СТАН ЗАПЧАСТИН ДЛЯ #{car_mark.upcase} #{car_model.upcase} ---"
    
   
    oil_passed = car_kilometers - oil_last_changes
    oil_left = oil_life - oil_passed
    puts " Мастило двигуна: пройдено #{oil_passed} км | Залишилось: #{oil_left} км."
    puts "  Потрібна заміна масла" if oil_left <= 0

    air_out_passed = car_kilometers - last_outside_filter_life
    air_out_left = air_outside_filter_life - air_out_passed
    puts " Повітряний фільтр: пройдено #{air_out_passed} км | Залишилось: #{air_out_left} км."
    puts "  Потрібна заміна повітряного фільта двигуна" if air_out_left <= 0

    air_in_passed = car_kilometers - last_inside_filter_changes
    air_in_left = air_inside_filter_life - air_in_passed
    puts "• Салонний фільтр: пройдено #{air_in_passed} км | Залишилось: #{air_in_left} км."
    puts "  Потрібна заміна фільтра салону" if air_in_left <= 0

    brake_passed = car_kilometers - last_brake_changes
    brake_left = brake_life - brake_passed
    puts "• Гальмівні колодки/бліни: пройдено #{brake_passed} км | Залишилось: #{brake_left} км."
    puts "  Перевірте стан колодок " if brake_left <= 0

    cooling_passed = car_kilometers - cooling_last_changes
    cooling_left = cooling_liquid_life - cooling_passed
    puts "• Антифриз (охолодження): пройдено #{cooling_passed} км | Залишилось: #{cooling_left} км."
    puts "  Потрібна заміна охолоджувальної рідини" if cooling_left <= 0

  when "2"
    puts "\n Па Па "
    break
  else
    puts "\n Неправильний вибір! Введіть 1 або 2."
  end
end
