require 'mysql2'
require 'dotenv/load'

class Database
  def self.client
   @client ||= Mysql2::Client.new(
      host: ENV['DB_HOST'],         
      username: ENV['DB_USER'],     
      password: ENV['DB_PASSWORD'], 
      database: ENV['DB_NAME']
    )
  end 
 
  def self.add_film(title, vote_average, release_date)
    sql = "INSERT INTO filmhs(name_of_film,rating, release_date)" \
    "VALUES('#{title}','#{vote_average}', '#{release_date}')"
    begin 
      client.query(sql)
      return true
    rescue Mysql2::Error => e
      puts "Помилка бази даних #{e.message}"
      return false
    end
end
 
 def self.saved_film
    sql = "SELECT * FROM filmhs"
    client.query(sql)
 end
end 