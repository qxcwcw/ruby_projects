sentence = "Target IP address is 192.168.1.1"

# 1. .length — повертає кількість символів у рядку (довжину)
puts "Довжина ряcдка: #{sentence.length} символів."

# 2. .include? — перевіряє, чи містить рядок якийсь інший підрядок. 
# Зверни увагу на знак питання в кінці! В Ruby всі методи, що повертають true або false, мають '?' в назві.
puts "Чи є в рядку слово 'IP'? #{sentence.include?('IP')}"       # виведе true
puts "Чи є в рядку слово 'hacker'? #{sentence.include?('hacker')}" # виведе false

# 3. .gsub (Global Substitution) — заміна одного тексту на інший.
# Замінимо крапки в IP-адресі на дефіси, щоб зробити безпечне ім'я для файлу звіту:
safe_name = sentence.gsub(".", "-")
puts "Результат заміни: #{safe_name}"