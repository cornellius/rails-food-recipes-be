class InitDb < ActiveRecord::Migration[7.1]
  def change
    enable_extension "pgcrypto"
    enable_extension "plpgsql"

    create_table "authors", force: :cascade do |t|
      t.string "name"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "categories", force: :cascade do |t|
      t.string "name"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "recipes", force: :cascade do |t|
      t.string "title"
      t.integer "cook_time"
      t.integer "prep_time"
      t.jsonb "ingredients", null: false, default: {}
      t.float "ratings"
      t.string "image"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.bigint "author_id"
      t.bigint "category_id"
      t.index ["author_id"], name: "index_recipes_on_author_id"
      t.index ["category_id"], name: "index_recipes_on_category_id"
    end

    add_foreign_key "recipes", "authors"
    add_foreign_key "recipes", "categories"
  end
end
