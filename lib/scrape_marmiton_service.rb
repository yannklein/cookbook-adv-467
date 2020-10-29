require "open-uri"
require "nokogiri"
require_relative "recipe"

class ScrapeMarmitonService
  def initialize(ingredient)
    @ingredient = ingredient
  end

  def call
    html = open("http://www.marmiton.org/recettes/recherche.aspx?aqt=#{@ingredient}").read
    # 1. Parse HTML
    doc = Nokogiri::HTML(html, nil, "utf-8")
    # 2. For the first five results
    results = []
    doc.search(".recipe-card").first(5).each do |element|
      # 3. Create recipe and store it in results
      name = element.search(".recipe-card__title").first.text.strip
      description = element.search(".recipe-card__description").first.text.strip
      rating = element.search(".recipe-card__rating__value").first.text.strip
      prep_time = element.search(".recipe-card__duration__value").first.text.strip
      results << Recipe.new(name: name, description: description, rating: rating, prep_time: prep_time)
    end
    results
  end
end
