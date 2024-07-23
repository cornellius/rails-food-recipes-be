class Recipe < ApplicationRecord
  belongs_to :author
  belongs_to :category

  validates :title, presence: true, length: { maximum: 300 }
  validates :prep_time, presence: true
  validates :cook_time, presence: true
  validates :author_id, presence: true
  validates :category_id, presence: true

  # Build full-text search query that contains one or several ingredients
  def self.search_by_ingredients(ingredients,only_count=false)
    search_query = ""

    if ingredients.include? ","
      searchterms = ingredients.split(",")
      searchterms.each_with_index do |val, index|
        if index > 0
          search_query << " AND "
        end
        sanitized_query = sanitize_for_query("(@ like_regex \"%s\" flag \"i\")'", val)
        search_query << "ingredients @? '$[*] ? " + sanitized_query.to_s
      end
    else
      sanitized_query = sanitize_for_query("(@ like_regex \"%s\" flag \"i\")'", ingredients)
      search_query << "ingredients @? '$[*] ? " + sanitized_query.to_s
    end
    if only_count
      @recipes = Recipe.where(search_query).includes(:author, :category).order(created_at: :desc).count
    else
      @recipes = Recipe.where(search_query).includes(:author, :category).order(created_at: :desc).page(@page)
    end
  end

  def self.sanitize_for_query(exp,val)
    ActiveRecord::Base::sanitize_sql_for_conditions([exp, val])
  end
end
