class Recipe
  attr_reader :name, :description, :prep_time, :rating

  def initialize(attributes = {})
    @name = attributes[:name]
    @description = attributes[:description]
    @rating = attributes[:rating]
    @prep_time = attributes[:prep_time]
    @done = attributes[:done] || false
  end

  def done?
    @done
  end

  def mark_as_done!
    @done = true
  end
end
