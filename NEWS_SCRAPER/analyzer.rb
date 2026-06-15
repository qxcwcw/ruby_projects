def filter_info_by_words(info, keyword)
  
  searched_word = keyword.downcase

  info.select do |item| 
    title = item['title'].downcase
    summary = item['summary'].downcase

    title.include?(searched_word) || summary.include?(searched_word)
  end
end