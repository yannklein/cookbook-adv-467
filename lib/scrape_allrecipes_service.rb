require 'open-uri'
require 'nokogiri'

class ScrapeAllrecipesService # or ScrapeMarmitonService
  def initialize(keyword)
    @keyword = keyword
  end

  def call
    # use the keyword to access the allrecipe webpage
    url = "berry.html"
    html_raw = open(url).read
    # parse HTML doc to search for the first 5 recipe's name and description
    doc = Nokogiri::HTML(html_raw)

    recipe_list = []

    doc.search('.fixed-recipe-card').first(5).each do |card|
      recipe_name = card.search('span.fixed-recipe-card__title-link').text.strip
      recipe_description = card.search('.fixed-recipe-card__description').text.strip
      recipe_rating = card.search('span.stars').attribute("data-ratingstars").value.strip.to_f.round(1)
      recipe_list << { name: recipe_name, description: recipe_description, rating: recipe_rating }
    end
    return recipe_list # an array with 5 hashes containing name/description
  end
end







