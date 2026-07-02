require 'nokogiri'
require 'open-uri'

module ArticleReader
  def self.parse(url)
    html_code = URI.open(url).read
    doc = Nokogiri::HTML(html_code)
    
    title = doc.css('title').first&.text&.strip || "Без заголовка"
    
    description = doc.at('meta[property="og:description"]')&.[]('content') || 
                  doc.at('meta[name="description"]')&.[]('content')
    
    if description.nil? || description.strip.empty?
      valid_p = doc.css('p').find { |p| p.text.strip.length > 80 }
      description = valid_p&.text&.strip || "Не вдалося витягнути уривок тексту."
    end
    
    "Знайдено статтю: #{title}\n\nКлючове: #{description}"
  
  rescue => e
    "Не вдалося прочитати сторінку.\nПомилка: #{e.message}"
  end
end