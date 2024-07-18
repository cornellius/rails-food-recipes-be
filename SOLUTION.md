# Pennylane recipes app solution by Manuel Aguilar

## Database design

I have considered two alternatives for this exercise: 

1. The classic many to many relationship between `recipes` and `ingredients`, with a join table (recipes_ingredients) in between storing the relationship.
    ```mermaid
    erDiagram
        RECIPE }|--|{ INGREDIENT : has_many
        RECIPE {
            int id
            string title
            int cook_time
            int prep_time
            float  ratings
            int    category_id
            string author
            string image
        }
        INGREDIENT {
            int id
            string description
        }
        RECIPE ||--|| CATEGORY : belongs
        CATEGORY {
            int id
            string name
        }
    ```
2. Store the ingredients in a JSONB column in PostgreSQL 
   ```mermaid
   erDiagram
        RECIPE }|..|{ INGREDIENTS : "has many"
        RECIPE }|--|| CATEGORY : "classified in"
        RECIPE }|--|| AUTHOR : "published by"
   ```

For the sake of this exercise, I have chosen option 2 for the following reasons:

- Because of time constraints and trying to come up with a workable, quality enough solution asap.
- To simplify the database structure (no ingredients and recipes_ingredients tables) and facilitate the importation of initial data (recipes-en.json).
- To simplify the model in Rails (and testing, etc.), and minimize the number of end-points for CRUD operations.
- To take advantage of Postgres' capabilities with indexing JSONB columns and full time search, and its existing implementation in Rails.
- Because for this prototype/exercise, with the given volume of data, remains to be seen if opting for JSONB has performance implications (I don't expect any based in my experience).


```
CREATE INDEX recipes_path_ops_idx ON recipes USING GIN (data jsonb_path_ops);

SELECT *
FROM   recipes r
WHERE  r.category_id IN(1,2)
AND    r.data @? '$[*] ? (@ like_regex "ternera" flag "i")';
```

```
Recipe.where("category_id IN(1,2) AND data @? '$[*] ? (@ like_regex \"ternera\" flag \"i\")'")
```