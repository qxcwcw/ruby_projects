require 'csv'
def csv_export(info , news_history)
    CSV.open(news_history, "w") do |csv|

        csv << ["Заголовок", "Джерело", "Опис"]


        info.each do |item|
            csv <<  [ item["title"] , item["news_site"] , item["summary"] ]

        end
    end
    end
    