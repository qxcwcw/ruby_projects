require 'json'
require 'open-uri'

def search_movies_by_rating(api_key, min_rating)
  rating_value = min_rating.to_f
  url_rating = "https://api.themoviedb.org/3/discover/movie?api_key=#{api_key}&language=uk-UA&vote_average.gte=#{rating_value}&vote_count.gte=300"
  data = JSON.parse(URI.open(url_rating).read)
  data['results']
end

def top20(api_key)
  url_top20 = "https://api.themoviedb.org/3/movie/popular?api_key=#{api_key}&language=uk-UA"
  top_data = JSON.parse(URI.open(url_top20).read)
  top_data['results']
end

def search_by_keyword(api_key, user_word)
  url_keyword = "https://api.themoviedb.org/3/search/keyword?api_key=#{api_key}&query=#{user_word}"
  keyword_data = JSON.parse(URI.open(url_keyword).read)['results']

  return [] if keyword_data.empty?

  keyword_id = keyword_data.first['id']
  url_discover = "https://api.themoviedb.org/3/discover/movie?api_key=#{api_key}&language=uk-UA&with_keywords=#{keyword_id}"
  film_discover = JSON.parse(URI.open(url_discover).read)
  film_discover['results']
end

