#json.array! @recipes, partial: "recipes/recipe", as: :recipe

json.results do
  json.total_recipes @total_recipes
  json.per_page @per_page
  json.page @page
  json.recipes do
    json.array! @recipes do |recipe|
      json.call(recipe, :id, :title, :prep_time, :cook_time, :ingredients, :ratings, :image, :created_at, :updated_at)

      json.author do
        json.extract! recipe.author, :id, :name
      end

      json.category do
        json.extract! recipe.category, :id, :name
      end
    end
  end
end


