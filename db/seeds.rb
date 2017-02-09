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

response = RestClient.get "http://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
repos = JSON.parse(response)
repos["drinks"].each do |element|
  Ingredient.create(name: element["strIngredient1"])
end

#commencer une boucle ici
html_file = open("http://www.epicurious.com/tools/searchresults?search=cocktail") #ajouter dans l'url index
html_doc = Nokogiri::HTML(html_file)

html_doc.search('.recipeLnk').each do |element|
  Cocktail.create(name: element.text)
end
#incrémenter index interpolé
