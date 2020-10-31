class View
  def display(recipes)
    recipes.each_with_index do |recipe, index|
      done_string = recipe.done? ? "[X]" : "[ ]"
      puts "#{index + 1}. #{done_string} #{recipe.name}: #{recipe.description[0..30]} #{recipe.rating}/5"
    end
  end

  def display_recipe_list(recipe_list)
    recipe_list.each_with_index do |recipe_hash, index|
      puts "#{index + 1}. #{recipe_hash[:name]}: #{recipe_hash[:description][0..30]}...  #{recipe_hash[:rating]}/5"
    end
  end

  def ask_user_for(stuff)
    puts "#{stuff.capitalize}?"
    print "> "
    return gets.chomp
  end

  def ask_user_for_index
    puts "Index?"
    print "> "
    return gets.chomp.to_i - 1
  end
end
