# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

existing_authors = {}
existing_categories = {}

all_authors = []
authors_new_id = 0
all_categories = []
categories_new_id = 0
all_recipes = []

# JSON file
import_recipes = JSON.parse(File.read('db/recipes-en.json'))

import_recipes.each do |recipe|
  time = Time.now.utc

  # only add the author if the author has not been added to all_authors yet
  author = recipe['author']
  if existing_authors.key?(author)
    author_id = existing_authors[author]
  else
    existing_authors[author] = authors_new_id += 1
    author_id = authors_new_id

    all_authors << {
      id: author_id,
      name: author,
      created_at:   time,
      updated_at:   time
    }
  end

  # only add the category if the category has not been added to all_categories yet
  category = recipe['category']
  if existing_categories.key?(category)
    category_id = existing_categories[category]
  else
    existing_categories[category] = categories_new_id += 1
    category_id = categories_new_id

    all_categories << {
      id: category_id,
      name: category,
      created_at:   time,
      updated_at:   time
    }
  end

  all_recipes << {
    title:        recipe['title'],
    prep_time:    recipe['prep_time'],
    cook_time:    recipe['cook_time'],
    ingredients:  recipe['ingredients'],
    image:        recipe['image'],
    ratings:      recipe['ratings'],
    category_id:  category_id,
    author_id:    author_id,
    created_at:   time,
    updated_at:   time
  }
end

p "Now Inserting all authors..."
Author.insert_all(all_authors)

p "Now Inserting all categories..."
Category.insert_all(all_categories)

p "Now Inserting all recipes..."
Recipe.insert_all(all_recipes)