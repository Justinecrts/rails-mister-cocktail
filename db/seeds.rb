# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'json'
require 'open-uri'
require 'rest-client'
require 'nokogiri'

Ingredient.destroy_all

response = RestClient.get "http://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
repos = JSON.parse(response)
repos["drinks"].each do |element|
  Ingredient.create(name: element["strIngredient1"])
end

Cocktail.destroy_all

page = 1
while page < 5
  html_file = open("http://www.epicurious.com/tools/searchresults?search=cocktail&pageNumber=#{page}")
  html_doc = Nokogiri::HTML(html_file)
  cocktails = html_doc.search('.sr_rows')
  cocktails.each do |cocktail|
    name = cocktail.search('.recipeLnk').text
    image_url = cocktail.search('.sr_recipe_image').attribute('src').value
    Cocktail.create!(name: name, photo: image_url)
  end
page += 1
end

