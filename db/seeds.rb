# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

all_authors = {}
all_categories = {}

# JSON file
all_recipes = JSON.parse(File.read('db/recipes-en.json'))

all_recipes.each do |recipe|
  # only add the author if the author doesn't already exist in authors table
  author = recipe['author']
  if all_authors.key?(author)
    p all_authors
    author_id = all_authors[author]
  else
    new_author = Author.create(name: author)
    all_authors[author] = new_author.id
    author_id = new_author.id
  end

  # only add the category if the category doesn't already exist in categories table
  category = recipe['category']
  if all_categories.key?(category)
    category_id = all_categories[category]
  else
    new_category = Category.create(name: category)
    all_categories[category] = new_category.id
    category_id = new_category.id
  end

  Recipe.create(
    title:        recipe['title'],
    prep_time:    recipe['prep_time'],
    cook_time:    recipe['cook_time'],
    ingredients:  recipe['ingredients'],
    image:        recipe['image'],
    ratings:      recipe['ratings'],
    category_id:  category_id,
    author_id:    author_id
  )
end