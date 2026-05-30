puts "Калькулятор чайових"

print "Введіть суму рахунку (грн):"
bill = gets.to_f

print "Який відсоток чайових ви хочете залишити (наприклад, 10, 15, 20):"
percentage = gets.to_f

tip = bill * (percentage / 100)
total = bill + tip

puts "Сума чайових: #{tip.round(2)} грн."
puts "Загальна сума: #{total.round(2)} грн."
