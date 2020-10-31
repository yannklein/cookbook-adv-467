require_relative "view"
require_relative "recipe"
require_relative "scrape_allrecipes_service"

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  # USER ACTIONS

  def import
    # ask the user for a keyword
    keyword = @view.ask_user_for("keyword")
    # use the keyword to access the allrecipe webpage
    # parse HTML doc to search for the first 5 recipe's name and description
    recipe_list = ScrapeAllrecipesService.new(keyword).call
    # show the recipe list
    @view.display_recipe_list(recipe_list)
    # ask the user what recipe to import
    index = @view.ask_user_for_index
    # create a Recipe from name/description
    # Recipe.new(name: recipe_list[index][:name], description: recipe_list[index][:description])
    # Recipe.new({name: recipe_list[index][:name], description: recipe_list[index][:description]})
    recipe = Recipe.new(recipe_list[index])
    # p recipe
    # add the Recipe to the Cookbook
    @cookbook.add(recipe)
    # list up the recipes
    list
  end

  def mark_as_done
    #list the recipes
    list
    # Ask the user what recipe to mark as done
    index = @view.ask_user_for_index
    # Update the recipe in the Cookbook
    @cookbook.mark_recipe_done(index)
    # list again
    list
  end

  def list
    display_recipes
  end

  def create
    # Ask user for a name (view)
    name = @view.ask_user_for("name")
    # Ask user for a description (view)
    description = @view.ask_user_for("description")
    # Ask user for a rating (view)
    rating = @view.ask_user_for("rating")
    # Create recipe (model)
    recipe = Recipe.new(name: name, description: description, rating: rating)
    # Store in cookbook (repo)
    @cookbook.add(recipe)
    # Display
    display_recipes
  end

  def destroy
    # 1. Display recipes
    display_recipes
    # 2. Ask user for index (view)
    index = @view.ask_user_for_index
    # 3. Remove from cookbook (repo)
    @cookbook.remove_at(index)
    # 4. Display
    display_recipes
  end

  private

  def display_recipes
    # 1. Get recipes (repo)
    recipes = @cookbook.all
    # 2. Display recipes in the terminal (view)
    @view.display(recipes)
  end
end
