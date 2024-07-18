class Recipe < ApplicationRecord
  belongs_to :author
  belongs_to :category

  validates :title, presence: true, length: { maximum: 300 }
  validates :prep_time, presence: true
  validates :cook_time, presence: true
  validates :author_id, presence: true
  validates :category_id, presence: true

  # Return recipes that contain one or several ingredients
  def self.search_recipes(ingredients)
    search_query = ""

    if ingredients.include? ","
      searchterms = ingredients.split(",")

      searchterms.each_with_index do |val, index|
        if index > 0
          search_query << " AND "
        end
        search_query << "ingredients @? '$[*] ? (@ like_regex \"#{val}\" flag \"i\")'"
      end
    else
      search_query = "ingredients @? '$[*] ? (@ like_regex \"#{ingredients}\" flag \"i\")'"
    end
    @recipes = Recipe.where(search_query).includes(:author, :category)
  end
end
