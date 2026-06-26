require 'nokogiri'
require 'open-uri'

class ArticleReader
  
  def self.parse(url)
    begin
    
      html_code = URI.open(url).read
      doc = Nokogiri::HTML(html_code)
      
      title = doc.css('title').text.strip
      first_p = doc.css('p').first.text.strip
      return "Знайдено статтю: #{title}\n\n Уривок: #{first_p}"
      
    rescue => e
      return "Не вдалося прочитати сторінку.\nПомилка: #{e.message}"
    end
  end
end