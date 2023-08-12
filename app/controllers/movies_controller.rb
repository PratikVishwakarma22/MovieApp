require_relative '.././services/tmdb_api_service.rb'
require 'json'

class MoviesController < ApplicationController
  include MovieHelper

  def latest
    movies = TmdbApiService.new.latest_movies
    @latest_movies = formatted_movies(movies)    
  end
  
  def search_movie
    movies = TmdbApiService.new.search_by_title(params[:title])
    @result = formatted_movies(movies)
  end

  def show
    movie = TmdbApiService.new.movie_details(params[:id])
    @formatted_movie = formatted_movie(movie) 
  end

  def add_to_favourite_list
    if params[:movie_id].present?
      @movie = TmdbApiService.new.add_to_favourite(params[:movie_id], session[:tmdb_session_id])
      set_session_id if @movie["success"].blank?
      @favourite_movies = TmdbApiService.new.favourites
      redirect_back(fallback_location: root_path, allow_other_host: false, notice: "Movie successfully added to the favourites.")
    else
      flash[:alert] = "Something went wrong !"
      redirect_back(fallback_location: root_path, allow_other_host: false)
    end    
  end
  
  def favourites
    movies = TmdbApiService.new.favourites()
    @favourites = formatted_movies(movies)
  end

  private
  def set_session_id
    request_token = TmdbApiService.new.request_token 
    callback_url = 'http://localhost:3000/callback'
    redirect_to "https://www.themoviedb.org/authenticate/#{request_token}?redirect_to=#{CGI.escape(callback_url)}", allow_other_host: true
  end
end
