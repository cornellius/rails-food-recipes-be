#json.partial! "recipes/recipe", recipe: @recipe

json.call(@recipe, :id, :title, :prep_time, :cook_time, :ingredients, :ratings, :image, :created_at, :updated_at)

json.author do
  json.id @recipe.author_id
  json.name @recipe.author.name
end

json.category do
  json.id @recipe.category_id
  json.name @recipe.category.name
end