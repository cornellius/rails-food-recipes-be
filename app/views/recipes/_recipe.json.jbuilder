json.extract! recipe, :id, :title, :cook_time, :prep_time, :ingredients, :ratings, :category_id, :author_id, :image, :created_at, :updated_at
json.url recipe_url(recipe, format: :json)
