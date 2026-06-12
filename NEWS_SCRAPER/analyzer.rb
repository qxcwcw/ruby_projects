def filtred_info_by_wors(info, keyword)

selected_info = info.select do |itemm| 

    title = itemm["title"].downcase
    summary = itemm["summary"].downcase
    searched_word = keyword.downcase

title.include?(searched_word) || summary.include?(searched_word)
end

return selected_info

end
