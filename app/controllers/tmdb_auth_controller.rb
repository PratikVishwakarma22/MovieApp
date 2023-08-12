class TmdbAuthController < ApplicationController
  include HTTParty
  base_uri 'api.themoviedb.org/3/'
  format :json
  headers 'Accept' => 'application/json'
  headers 'Content-Type' => 'application/json'
  headers 'Authorization' => 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1M2EwN2VmYWZiODFhN2FiMThhODY2N2QzOTBkNWJkMSIsInN1YiI6IjY0ZDUwNjNiZGI0ZWQ2MDBmZmI2ZjlkYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ._x7M1WYS8DE8ygy9hoPnbhMn_TW6lDzQ9a1KA0ZwXx8'
  @options = { query: { api_key: '53a07efafb81a7ab18a8667d390d5bd1' } }
  
  def callback
    request_token = params[:request_token]
    response = HTTParty.post("https://api.themoviedb.org/3/authentication/session/new?api_key=53a07efafb81a7ab18a8667d390d5bd1", body: { "request_token": request_token } )
    session[:tmdb_session_id] = JSON.parse(response.body)['session_id']
    redirect_to add_to_favourite_list_movies_path , notice: 'You are now authenticated with TMDb!'
  end
end
