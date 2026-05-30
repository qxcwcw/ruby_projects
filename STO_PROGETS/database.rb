require 'csv'
 class Database


    CARS_FILE = "cars_users.csv"

    def self.add_cars_users(number, mark, model, kilometers, 
        oil_last_changes, last_outside_filter_changes, 
        last_inside_filter_changes, last_brake_changes, cooling_last_changes)
        CSV.open(CARS_FILE,"a") do |csv|
            csv << [number, mark, model, kilometers, 
        oil_last_changes, last_outside_filter_changes, 
        last_inside_filter_changes, last_brake_changes, cooling_last_changes]
        end
    end
    
    def self.find_cars_users(number)
        return nil unless File.exist?(CARS_FILE)

        CSV.read(CARS_FILE).each do |row|
            if row[0] == number
                return row
            end
        end
        return nil
    end
end