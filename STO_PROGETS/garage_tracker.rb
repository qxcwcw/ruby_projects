require_relative 'database'
require_relative 'car' 

Encoding.default_external = Encoding::UTF_8

loop do
  puts '1 Додати нову машину'
  puts '2 Знайти машину по номеру і перевірити знос запчастин'
  puts '3 Оновити дані про стан запчастин'
  puts '4 Вийти'
  print 'Виберіть дію: '
  
  choice = gets.strip

  case choice

  when "1"
    print 'Введіть номер машини: '
    number = gets.strip
    
    if Database.find_car(number)
      puts 'Машина з таким номером вже є в базі'
      next
    end

    print 'Введіть марку: '
    mark = gets.strip
    print 'Введіть модель: '
    model = gets.strip
    print 'Поточний пробіг (км): '
    kilometers = gets.to_i
    
    puts "\n Введіть пробіг, на якому мінявся розхідник востаннє "
    print 'Заміна мастила (км): '
    oil = gets.to_i
    print 'Заміна повітряного фільтра (км): '
    out_filter = gets.to_i
    print 'Заміна фільтра салону (км): '
    in_filter = gets.to_i
    print 'Заміна гальмівних колодок (км): '
    brakes = gets.to_i
    print 'Заміна антифризу (км): '
    cooling = gets.to_i

    if Database.add_car(number, mark, model, kilometers, oil, out_filter, in_filter, brakes, cooling)
      puts "Машину #{mark} #{model} успішно додано до SQL бази!"
    end

  when "2"
    print 'Введіть номер машини:'
    number = gets.strip

    car_data = Database.find_car(number)
    puts "Машину з номером #{number}"
    if car_data
      print 'Введіть поточний пробіг машини на сьогодні (км): '
      current_kilometers = gets.to_i

      Database.update_kilometers(number, current_kilometers)

      cars_sto = Car.new(
        car_data['number'], 
        car_data['mark'], 
        car_data['model'], 
        current_kilometers,
        car_data['oil_last_changes'], 
        car_data['last_outside_filter_changes'], 
        car_data['last_inside_filter_changes'], 
        car_data['last_brake_changes'], 
        car_data['cooling_last_changes']
      )

      puts "\nАКТУАЛЬНИЙ СТАН ЗАПЧАСТИН ДЛЯ #{car_data['mark']} #{car_data['model']} (Пробіг: #{current_kilometers} км):"
      puts "Мастило двигуна залишилось: #{cars_sto.calculate_oil_left} км"
      puts "Фільтр повітря залишилось: #{cars_sto.calculate_outside_filter_left} км"
      puts "Фільтр салону залишилось: #{cars_sto.calculate_inside_filter_left} км"
      puts "Гальмівні колодки залишилось: #{cars_sto.calculate_brake_left} км"
      puts "Антифриз залишилось: #{cars_sto.calculate_cooling_liqvid_left} км"
    else
      puts "Машину з номером #{number} не знайдено."
    end

  when "3"
    print 'Введіть номер машини для оновлення: '
    number = gets.strip
    
    unless Database.find_car(number)
      puts 'Такої машини немає в базі'
      next
    end

    puts '\nЩо саме ви замінили?'
    puts '1 - Мастило двигуна'
    puts '2 - Повітряний фільтр'
    puts '3 - Гальмівні колодки'
    print 'Вибір: '
    part_choice = gets.strip
    
    print 'Введіть пробіг, на якому відбулася заміна (км): '
    new_km = gets.to_i

    case part_choice
    
    when "1"
      Database.update_part(number, 'oil_last_changes', new_km)
      puts  'Запис про заміну мастила оновлено'
    when "2"
      Database.update_part(number, 'last_outside_filter_changes', new_km)
      puts 'Запис про заміну повітряного фільтра оновлено'
    when "3"
      Database.update_part(number, 'last_brake_changes', new_km)
      puts 'Запис про заміну гальм оновлено'
    else
      puts 'Невідома запчастина'
    end

  when "4"
    puts 'До побачення'
    break
  else
    puts 'Невідома команда'
  end
end