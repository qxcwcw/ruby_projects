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
  
  def self.add_car(number, mark, model, kilometers, oil, out_filter, in_filter, brakes, cooling)
    sql = "INSERT INTO cars (number, mark, model, kilometers, oil_last_changes, last_outside_filter_changes, last_inside_filter_changes, last_brake_changes, cooling_last_changes) " \
          "VALUES ('#{number}', '#{mark}', '#{model}', #{kilometers}, #{oil}, #{out_filter}, #{in_filter}, #{brakes}, #{cooling})"
    begin
      client.query(sql)
      return true 
    rescue Mysql2::Error => e
      puts "Помилка бази даних: #{e.message}"
      return false
    end
  end

  def self.find_car(number)
    sql = "SELECT * FROM cars WHERE number = '#{number}' LIMIT 1"
    results = client.query(sql)
    return results.first 
  end

  def self.update_part(number, part_column, new_kilometers)
    sql = "UPDATE cars SET #{part_column} = #{new_kilometers} WHERE number = '#{number}'"
    client.query(sql)
  end
  
  def self.update_kilometers(number, new_kilometers)
    sql = "UPDATE cars SET kilometers = #{new_kilometers} WHERE number = '#{number}'"
    client.query(sql)
  end
end
