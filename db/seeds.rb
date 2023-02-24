# require 'open-uri'
# require 'json'

# puts "Cleaning up database..."
# Movie.destroy_all
# puts "Database cleaned"

# url = "http://tmdb.lewagon.com/movie/top_rated"
# 10.times do |i|
#   puts "Importing movies from page #{i + 1}"
#   movies = JSON.parse(URI.open("#{url}?page=#{i + 1}").read)['results']
#   movies.each do |movie|
#     puts "Creating #{movie['title']}"
#     base_poster_url = "https://image.tmdb.org/t/p/original"
#     Movie.create(
#       title: movie['title'],
#       overview: movie['overview'],
#       poster_url: "#{base_poster_url}#{movie['backdrop_path']}",
#       rating: movie['vote_average']
#     )
#   end
# end
# puts "Movies created"

require "json"
require 'rest-client'

response = RestClient.get "https://tmdb.lewagon.com/movie/top_rated"
repos = JSON.parse(response)

repos["results"].each do |e|
  puts "creating movie #{e["original_title"]}"
  Movie.create(
    title: e["original_title"],
    overview: e["overview"],
    poster_url: "https://image.tmdb.org/t/p/w500/#{e['poster_path']}",
    rating: e["vote_average"]
  )
end

List.create(name: "nila")
List.create(name: "dhfb")

puts "Finished"
