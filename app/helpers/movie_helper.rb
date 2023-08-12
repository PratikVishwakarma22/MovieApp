module MovieHelper
  def formatted_movies(api_response)
    api_response["results"].map do |movie_data|
      {
        id: movie_data["id"],
        title: movie_data["title"],
        overview: movie_data["overview"],
        release_date: movie_data["release_date"],
        poster_path: movie_data["poster_path"]
      }
    end
  end
  
  def formatted_movie(movie_data)
    {
      title: movie_data["title"],
      release_date: movie_data["release_date"],
      overview: movie_data["overview"],
      poster_path: movie_data["poster_path"],
      genres: movie_data["genres"].map { |genre| genre["name"] }.join(", "),
      runtime: "#{movie_data["runtime"]} minutes",
      imdb_id: movie_data["imdb_id"],
      homepage: movie_data["homepage"],
      tagline: movie_data["tagline"],
      vote_average: "#{movie_data["vote_average"]} (#{movie_data["vote_count"]} votes)",
      revenue: "$#{movie_data["revenue"].to_s.reverse.scan(/\d{1,3}/).join(',').reverse}",
    }
  end
end
