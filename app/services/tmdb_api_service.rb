class TmdbApiService
  include HTTParty
  base_uri 'api.themoviedb.org/3/'
  format :json
  headers 'Accept' => 'application/json'
  headers 'Content-Type' => 'application/json'
  headers 'Authorization' => 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1M2EwN2VmYWZiODFhN2FiMThhODY2N2QzOTBkNWJkMSIsInN1YiI6IjY0ZDUwNjNiZGI0ZWQ2MDBmZmI2ZjlkYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ._x7M1WYS8DE8ygy9hoPnbhMn_TW6lDzQ9a1KA0ZwXx8'  
  
  def initialize
    @options = { query: { api_key: '53a07efafb81a7ab18a8667d390d5bd1' } }
  end

  def latest_movies
    movies = self.class.get("/trending/movie/week", @options)
  end

  def movie_details(movie_id)
    movie_details = self.class.get("/movie/#{movie_id}", @options)
  end

  def search_by_title(query)
    response = self.class.get("/search/movie?query=#{query}", @options)
  end
 
  def add_to_favourite(movie_id, session_id)  
    HTTParty.post("https://api.themoviedb.org/3/account/20284587/favorite?session_id=#{session_id}&api_key=53a07efafb81a7ab18a8667d390d5bd1", body: { 
      "media_type": "movie",
      "media_id": movie_id, 
      "favorite":true
    })
  end 

  def favourites
    movies = self.class.get("/account/20284587/favorite/movies", @options)  
  end

  def request_token
    response = self.class.get("https://api.themoviedb.org/3/authentication/token/new?api_key=53a07efafb81a7ab18a8667d390d5bd1")
    request_token = JSON.parse(response.body)['request_token']
  end
end
