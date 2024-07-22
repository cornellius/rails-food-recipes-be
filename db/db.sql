-- AUTHORS ----------------------------------------------
CREATE TABLE authors (
                         id BIGSERIAL PRIMARY KEY,
                         name character varying,
                         created_at timestamp(6) without time zone NOT NULL,
                         updated_at timestamp(6) without time zone NOT NULL
);
CREATE UNIQUE INDEX authors_pkey ON authors(id int8_ops);

-- CATEGORIES -------------------------------------------
CREATE TABLE categories (
                            id BIGSERIAL PRIMARY KEY,
                            name character varying,
                            created_at timestamp(6) without time zone NOT NULL,
                            updated_at timestamp(6) without time zone NOT NULL
);
CREATE UNIQUE INDEX categories_pkey ON categories(id int8_ops);

-- RECIPES ----------------------------------------------
CREATE TABLE recipes (
                         id BIGSERIAL PRIMARY KEY,
                         title character varying,
                         cook_time integer,
                         prep_time integer,
                         ingredients jsonb NOT NULL DEFAULT '{}'::jsonb,
                         ratings double precision,
                         image character varying,
                         created_at timestamp(6) without time zone NOT NULL,
                         updated_at timestamp(6) without time zone NOT NULL,
                         author_id bigint REFERENCES authors(id),
                         category_id bigint REFERENCES categories(id)
);
CREATE UNIQUE INDEX recipes_pkey ON recipes(id int8_ops);
CREATE INDEX index_recipes_on_author_id ON recipes(author_id int8_ops);
CREATE INDEX index_recipes_on_category_id ON recipes(category_id int8_ops);
CREATE INDEX recipes_path_ops_idx ON recipes USING GIN (ingredients jsonb_path_ops);