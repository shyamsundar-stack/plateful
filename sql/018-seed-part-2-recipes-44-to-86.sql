-- Plateful seed part 2: recipes 44-86
-- Run AFTER part 1

DO $$
DECLARE
  _recipe_id UUID;
  _ingredient_id UUID;
BEGIN

-- Recipe 44/215: Bhindi Masala
-- -----------------------------------------------------------------------
INSERT INTO global_recipes (
  title, description, cuisine, cuisine_category, cuisine_region,
  meal_types, servings, prep_time_min, cook_time_min,
  difficulty, tags, cooking_style, dietary_tags,
  image_url, source_url, image_search_query,
  is_vegetarian, is_vegan, is_eggetarian, is_jain,
  is_batch_friendly, leftover_days, protein_category,
  dish_role, is_standalone, pairing_group, needs_roles
) VALUES (
  'Bhindi Masala', 'Bhindi Masala features okra cooked until flavorful yet distinct. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'north_indian', NULL, 'home-style',
  '{"lunch","dinner"}', 4, 15, 20,
  'medium', '{"homestyle","weekday-friendly","veg-side"}', '{"stir-fry"}', '{}',
  'https://www.vegrecipesofindia.com/wp-content/uploads/2021/06/bhindi-masala-1.jpg', 'https://www.vegrecipesofindia.com/bhindi-masala/', 'bhindi masala in a serving bowl, appetizing plated food photography',
  true, true, false, false,
  true, 2, NULL,
  'side', false, 'north', '{"main","staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('okra') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'okra', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('vegetable oil') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'vegetable oil', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('onion') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'onion', _ingredient_id,
  180, 'g', 'finely chopped',
  false, 'base', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('ginger garlic paste') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'ginger garlic paste', _ingredient_id,
  1, 'tablespoon', NULL,
  false, 'aromatics', 3
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('green chili') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'green chili', _ingredient_id,
  2, 'piece', 'slit',
  false, 'aromatics', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('turmeric powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'turmeric powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 5
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('red chili powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'red chili powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 6
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coriander powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coriander powder', _ingredient_id,
  2, 'teaspoon', NULL,
  false, 'spice mix', 7
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('salt') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'salt', _ingredient_id,
  5, 'g', NULL,
  false, 'seasoning', 8
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coriander leaves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coriander leaves', _ingredient_id,
  15, 'g', 'chopped',
  false, 'finish', 9
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('tomato') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'tomato', _ingredient_id,
  180, 'g', 'finely chopped',
  false, 'base', 10
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('amchur powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'amchur powder', _ingredient_id,
  0.5, 'teaspoon', NULL,
  false, 'finish', 11
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat oil in a wide skillet and bloom the tempering ingredients for 30 seconds. Add the base ingredients and cook for 4 to 5 minutes until lightly softened.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Add okra with the spice powders and salt. Toss well, then cook uncovered on medium heat until the vegetables or protein are just tender.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Finish with herbs and cook until the pan looks dry and glossy rather than wet. Cook for 2 more minutes so the masala clings to the ingredients instead of pooling in the pan.'
);

-- -----------------------------------------------------------------------
-- Recipe 45/215: Bharli Vangi
-- -----------------------------------------------------------------------
INSERT INTO global_recipes (
  title, description, cuisine, cuisine_category, cuisine_region,
  meal_types, servings, prep_time_min, cook_time_min,
  difficulty, tags, cooking_style, dietary_tags,
  image_url, source_url, image_search_query,
  is_vegetarian, is_vegan, is_eggetarian, is_jain,
  is_batch_friendly, leftover_days, protein_category,
  dish_role, is_standalone, pairing_group, needs_roles
) VALUES (
  'Bharli Vangi', 'Bharli Vangi is a Maharashtrian eggplant dish stuffed with a nutty masala and cooked until tender. It is savory, slightly earthy, and excellent with bhakri or rice.', 'maharashtrian', NULL, 'stuffed-style',
  '{"lunch","dinner"}', 4, 20, 30,
  'medium', '{"homestyle","weekday-friendly","veg-side"}', '{"stir-fry"}', '{}',
  'https://i0.wp.com/kagu-toshokan.jp/wp-content/uploads/2019/05/kit0000625-3.jpg?fit=640%2C427&ssl=1', 'https://kagu-toshokan.jp/kit0000625-post/', 'bharli vangi in a serving bowl, appetizing plated food photography',
  true, true, false, false,
  true, 2, NULL,
  'side', false, 'maharashtrian', '{"main","staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('brinjal') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'brinjal', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('mustard oil') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'mustard oil', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('onion') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'onion', _ingredient_id,
  180, 'g', 'finely chopped',
  false, 'base', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('ginger garlic paste') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'ginger garlic paste', _ingredient_id,
  1, 'tablespoon', NULL,
  false, 'aromatics', 3
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('green chili') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'green chili', _ingredient_id,
  2, 'piece', 'slit',
  false, 'aromatics', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('turmeric powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'turmeric powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 5
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('red chili powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'red chili powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 6
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coriander powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coriander powder', _ingredient_id,
  2, 'teaspoon', NULL,
  false, 'spice mix', 7
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('salt') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'salt', _ingredient_id,
  5, 'g', NULL,
  false, 'seasoning', 8
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coriander leaves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coriander leaves', _ingredient_id,
  15, 'g', 'chopped',
  false, 'finish', 9
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('peanuts') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'peanuts', _ingredient_id,
  40, 'g', 'roasted',
  false, 'finish', 10
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('sesame seeds') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'sesame seeds', _ingredient_id,
  1, 'tablespoon', NULL,
  false, 'finish', 11
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('dry coconut') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'dry coconut', _ingredient_id,
  40, 'g', 'grated',
  false, 'finish', 12
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Slit the small brinjals without cutting through completely. Toast peanuts, sesame seeds, and dry coconut, then grind them with spices into a coarse stuffing.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Stuff the masala into the brinjals, reserving any extra mixture for the gravy.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Cook the stuffed brinjals in a covered pan with a little water on low heat for 20 to 25 minutes until tender and well coated with masala.'
);

-- -----------------------------------------------------------------------
-- Recipe 46/215: Bharwa Bhindi
-- -----------------------------------------------------------------------
INSERT INTO global_recipes (
  title, description, cuisine, cuisine_category, cuisine_region,
  meal_types, servings, prep_time_min, cook_time_min,
  difficulty, tags, cooking_style, dietary_tags,
  image_url, source_url, image_search_query,
  is_vegetarian, is_vegan, is_eggetarian, is_jain,
  is_batch_friendly, leftover_days, protein_category,
  dish_role, is_standalone, pairing_group, needs_roles
) VALUES (
  'Bharwa Bhindi', 'Bharwa Bhindi features okra cooked until flavorful yet distinct. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'north_indian', NULL, 'stuffed-style',
  '{"lunch","dinner"}', 4, 20, 25,
  'medium', '{"homestyle","weekday-friendly","veg-side"}', '{"stir-fry"}', '{}',
  'https://www.vegrecipesofindia.com/wp-content/uploads/2024/12/bharwa-bhindi-recipe.jpg', 'https://www.vegrecipesofindia.com/bharwan-bhindi-stuffed-okra-no-onion-no-garlic-recipe/', 'bharwa bhindi in a serving bowl, appetizing plated food photography',
  true, true, false, false,
  true, 2, NULL,
  'side', false, 'north', '{"main","staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('okra') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'okra', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('vegetable oil') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'vegetable oil', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('onion') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'onion', _ingredient_id,
  180, 'g', 'finely chopped',
  false, 'base', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('ginger garlic paste') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'ginger garlic paste', _ingredient_id,
  1, 'tablespoon', NULL,
  false, 'aromatics', 3
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('green chili') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'green chili', _ingredient_id,
  2, 'piece', 'slit',
  false, 'aromatics', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('turmeric powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'turmeric powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 5
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('red chili powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'red chili powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 6
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coriander powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coriander powder', _ingredient_id,
  2, 'teaspoon', NULL,
  false, 'spice mix', 7
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('salt') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'salt', _ingredient_id,
  5, 'g', NULL,
  false, 'seasoning', 8
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coriander leaves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coriander leaves', _ingredient_id,
  15, 'g', 'chopped',
  false, 'finish', 9
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('amchur powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'amchur powder', _ingredient_id,
  0.5, 'teaspoon', NULL,
  false, 'finish', 10
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('fennel seeds') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'fennel seeds', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 11
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat oil in a wide skillet and bloom the tempering ingredients for 30 seconds. Add the base ingredients and cook for 4 to 5 minutes until lightly softened.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Add okra with the spice powders and salt. Toss well, then cook uncovered on medium heat until the vegetables or protein are just tender.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Finish with herbs and cook until the pan looks dry and glossy rather than wet. Cook for 2 more minutes so the masala clings to the ingredients instead of pooling in the pan.'
);

-- -----------------------------------------------------------------------
-- Recipe 47/215: Lauki Chana Dal
-- -----------------------------------------------------------------------
INSERT INTO global_recipes (
  title, description, cuisine, cuisine_category, cuisine_region,
  meal_types, servings, prep_time_min, cook_time_min,
  difficulty, tags, cooking_style, dietary_tags,
  image_url, source_url, image_search_query,
  is_vegetarian, is_vegan, is_eggetarian, is_jain,
  is_batch_friendly, leftover_days, protein_category,
  dish_role, is_standalone, pairing_group, needs_roles
) VALUES (
  'Lauki Chana Dal', 'Lauki Chana Dal features soft-cooked chana dal and a fragrant tempering. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'north_indian', NULL, 'home-style',
  '{"lunch","dinner"}', 4, 15, 30,
  'medium', '{"comfort-food","everyday","meal-prep"}', '{"one-pot"}', '{}',
  'https://www.vegrecipesofindia.com/wp-content/uploads/2017/02/lauki-recipes-dudhi-recipes.jpg', 'https://www.vegrecipesofindia.com/lauki-recipes/', 'lauki chana dal in a serving bowl, appetizing plated food photography',
  true, true, false, false,
  true, 3, 'dal',
  'main', false, 'north', '{"staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('chana dal') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'chana dal', _ingredient_id,
  220, 'g', 'washed',
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('vegetable oil') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'vegetable oil', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('onion') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'onion', _ingredient_id,
  180, 'g', 'finely chopped',
  false, 'base', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('tomato') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'tomato', _ingredient_id,
  180, 'g', 'finely chopped',
  false, 'base', 3
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('ginger garlic paste') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'ginger garlic paste', _ingredient_id,
  1, 'tablespoon', NULL,
  false, 'aromatics', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('green chili') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'green chili', _ingredient_id,
  2, 'piece', 'slit',
  false, 'aromatics', 5
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('turmeric powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'turmeric powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 6
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coriander powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coriander powder', _ingredient_id,
  2, 'teaspoon', NULL,
  false, 'spice mix', 7
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('garam masala') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'garam masala', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 8
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('salt') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'salt', _ingredient_id,
  5, 'g', NULL,
  false, 'seasoning', 9
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coriander leaves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coriander leaves', _ingredient_id,
  15, 'g', 'chopped',
  false, 'finish', 10
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('bottle gourd') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'bottle gourd', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 11
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat oil in a heavy pan over medium heat. Add the aromatics and cook for 6 to 8 minutes until they soften and smell sweet.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Stir in the ground spices, then add chana dal. Cook for 3 to 4 minutes so the masala coats everything evenly and loses any raw edge.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Add water or other liquid as needed, cover, and simmer on medium heat until the main ingredient is cooked through and the gravy thickens.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 4, 'Finish with herbs and a final stir so the dal stays loose and spoonable. Simmer for 2 more minutes, then rest the dish for 5 minutes before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 48/215: Gobi Matar
-- -----------------------------------------------------------------------
INSERT INTO global_recipes (
  title, description, cuisine, cuisine_category, cuisine_region,
  meal_types, servings, prep_time_min, cook_time_min,
  difficulty, tags, cooking_style, dietary_tags,
  image_url, source_url, image_search_query,
  is_vegetarian, is_vegan, is_eggetarian, is_jain,
  is_batch_friendly, leftover_days, protein_category,
  dish_role, is_standalone, pairing_group, needs_roles
) VALUES (
  'Gobi Matar', 'Gobi Matar features cauliflower and peas cooked until flavorful yet distinct. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'north_indian', NULL, 'home-style',
  '{"lunch","dinner"}', 4, 15, 25,
  'medium', '{"homestyle","weekday-friendly","veg-side"}', '{"stir-fry"}', '{}',
  'https://www.vegrecipesofindia.com/wp-content/uploads/2014/08/gobi-matar-recipe.jpg', 'https://www.vegrecipesofindia.com/gobi-matar-recipe-gobi-recipes/', 'gobi matar in a serving bowl, appetizing plated food photography',
  true, true, false, false,
  true, 2, NULL,
  'side', false, 'north', '{"main","staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cauliflower') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cauliflower', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('peas') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'peas', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('vegetable oil') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'vegetable oil', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('onion') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'onion', _ingredient_id,
  180, 'g', 'finely chopped',
  false, 'base', 3
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('ginger garlic paste') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'ginger garlic paste', _ingredient_id,
  1, 'tablespoon', NULL,
  false, 'aromatics', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('green chili') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'green chili', _ingredient_id,
  2, 'piece', 'slit',
  false, 'aromatics', 5
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('turmeric powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'turmeric powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 6
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('red chili powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'red chili powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 7
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coriander powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coriander powder', _ingredient_id,
  2, 'teaspoon', NULL,
  false, 'spice mix', 8
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('salt') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'salt', _ingredient_id,
  5, 'g', NULL,
  false, 'seasoning', 9
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coriander leaves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coriander leaves', _ingredient_id,
  15, 'g', 'chopped',
  false, 'finish', 10
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('tomato') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'tomato', _ingredient_id,
  180, 'g', 'finely chopped',
  false, 'base', 11
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat oil in a wide skillet and bloom the tempering ingredients for 30 seconds. Add the base ingredients and cook for 4 to 5 minutes until lightly softened.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Add cauliflower and peas with the spice powders and salt. Toss well, then cook uncovered on medium heat until the vegetables or protein are just tender.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Finish with herbs and cook until the pan looks dry and glossy rather than wet. Cook for 2 more minutes so the masala clings to the ingredients instead of pooling in the pan.'
);

-- -----------------------------------------------------------------------
-- Recipe 49/215: Methi Malai Paneer
-- -----------------------------------------------------------------------
INSERT INTO global_recipes (
  title, description, cuisine, cuisine_category, cuisine_region,
  meal_types, servings, prep_time_min, cook_time_min,
  difficulty, tags, cooking_style, dietary_tags,
  image_url, source_url, image_search_query,
  is_vegetarian, is_vegan, is_eggetarian, is_jain,
  is_batch_friendly, leftover_days, protein_category,
  dish_role, is_standalone, pairing_group, needs_roles
) VALUES (
  'Methi Malai Paneer', 'Methi Malai Paneer features tender paneer and a creamy fenugreek gravy. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'punjabi', NULL, 'restaurant-style',
  '{"lunch","dinner"}', 4, 20, 25,
  'medium', '{"restaurant-style","family-favorite","comfort-food"}', '{"one-pot"}', '{}',
  '/images/recipes/methi-malai-paneer.png', 'https://www.vegrecipesofindia.com/recipes/fenugreek/', 'methi malai paneer in a serving bowl, appetizing plated food photography',
  true, false, false, false,
  true, 2, 'paneer',
  'main', false, 'north', '{"staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('paneer') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'paneer', _ingredient_id,
  250, 'g', 'cubed',
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('vegetable oil') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'vegetable oil', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('onion') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'onion', _ingredient_id,
  180, 'g', 'finely chopped',
  false, 'base', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('tomato') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'tomato', _ingredient_id,
  180, 'g', 'finely chopped',
  false, 'base', 3
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('ginger garlic paste') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'ginger garlic paste', _ingredient_id,
  1, 'tablespoon', NULL,
  false, 'aromatics', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('green chili') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'green chili', _ingredient_id,
  2, 'piece', 'slit',
  false, 'aromatics', 5
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('turmeric powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'turmeric powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 6
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('red chili powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'red chili powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 7
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coriander powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coriander powder', _ingredient_id,
  2, 'teaspoon', NULL,
  false, 'spice mix', 8
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('garam masala') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'garam masala', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 9
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('salt') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'salt', _ingredient_id,
  5, 'g', NULL,
  false, 'seasoning', 10
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coriander leaves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coriander leaves', _ingredient_id,
  15, 'g', 'chopped',
  false, 'finish', 11
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('methi leaves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'methi leaves', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 12
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cream') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cream', _ingredient_id,
  80, 'ml', NULL,
  false, 'finish', 13
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cashews') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cashews', _ingredient_id,
  40, 'g', NULL,
  false, 'finish', 14
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat oil in a heavy pan over medium heat. Add the aromatics and cook for 6 to 8 minutes until they soften and smell sweet.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Stir in the ground spices, then add paneer. Cook for 3 to 4 minutes so the masala coats everything evenly and loses any raw edge.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Add water or other liquid as needed, cover, and simmer on medium heat until the main ingredient is cooked through and the gravy thickens.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 4, 'Add the finishing dairy and herbs, then simmer gently so the paneer stays soft. Simmer for 2 more minutes, then rest the dish for 5 minutes before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 50/215: Kadai Paneer
-- -----------------------------------------------------------------------
INSERT INTO global_recipes (
  title, description, cuisine, cuisine_category, cuisine_region,
  meal_types, servings, prep_time_min, cook_time_min,
  difficulty, tags, cooking_style, dietary_tags,
  image_url, source_url, image_search_query,
  is_vegetarian, is_vegan, is_eggetarian, is_jain,
  is_batch_friendly, leftover_days, protein_category,
  dish_role, is_standalone, pairing_group, needs_roles
) VALUES (
  'Kadai Paneer', 'Kadai Paneer features tender paneer and a capsicum and freshly ground spices. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'north_indian', NULL, 'dhaba-style',
  '{"lunch","dinner"}', 4, 20, 25,
  'medium', '{"restaurant-style","family-favorite","comfort-food"}', '{"one-pot"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2023/09/kadai-chicken-karahi-chicken-recipe.jpg', 'https://www.indianhealthyrecipes.com/kadai-chicken/', 'kadai paneer in a serving bowl, appetizing plated food photography',
  true, false, false, false,
  true, 2, 'paneer',
  'main', false, 'north', '{"staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('paneer') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'paneer', _ingredient_id,
  250, 'g', 'cubed',
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('vegetable oil') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'vegetable oil', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('onion') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'onion', _ingredient_id,
  180, 'g', 'finely chopped',
  false, 'base', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('tomato') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'tomato', _ingredient_id,
  180, 'g', 'finely chopped',
  false, 'base', 3
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('ginger garlic paste') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'ginger garlic paste', _ingredient_id,
  1, 'tablespoon', NULL,
  false, 'aromatics', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('green chili') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'green chili', _ingredient_id,
  2, 'piece', 'slit',
  false, 'aromatics', 5
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('turmeric powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'turmeric powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 6
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('red chili powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'red chili powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 7
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coriander powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coriander powder', _ingredient_id,
  2, 'teaspoon', NULL,
  false, 'spice mix', 8
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('garam masala') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'garam masala', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 9
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('salt') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'salt', _ingredient_id,
  5, 'g', NULL,
  false, 'seasoning', 10
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coriander leaves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coriander leaves', _ingredient_id,
  15, 'g', 'chopped',
  false, 'finish', 11
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('capsicum') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'capsicum', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 12
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cumin seeds') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cumin seeds', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'tempering', 13
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('black pepper') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'black pepper', _ingredient_id,
  1, 'teaspoon', 'coarsely crushed',
  false, 'spice mix', 14
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat oil in a heavy pan over medium heat. Add the aromatics and cook for 6 to 8 minutes until they soften and smell sweet.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Stir in the ground spices, then add paneer. Cook for 3 to 4 minutes so the masala coats everything evenly and loses any raw edge.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Add water or other liquid as needed, cover, and simmer on medium heat until the main ingredient is cooked through and the gravy thickens.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 4, 'Add the finishing dairy and herbs, then simmer gently so the paneer stays soft. Simmer for 2 more minutes, then rest the dish for 5 minutes before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 51/215: Paneer Bhurji
-- -----------------------------------------------------------------------
INSERT INTO global_recipes (
  title, description, cuisine, cuisine_category, cuisine_region,
  meal_types, servings, prep_time_min, cook_time_min,
  difficulty, tags, cooking_style, dietary_tags,
  image_url, source_url, image_search_query,
  is_vegetarian, is_vegan, is_eggetarian, is_jain,
  is_batch_friendly, leftover_days, protein_category,
  dish_role, is_standalone, pairing_group, needs_roles
) VALUES (
  'Paneer Bhurji', 'Paneer Bhurji features tender paneer and a crumbled paneer with quick masala. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'north_indian', NULL, 'dhaba-style',
  '{"breakfast","lunch","dinner"}', 4, 10, 15,
  'easy', '{"restaurant-style","family-favorite","comfort-food"}', '{"quick","stir-fry"}', '{}',
  'https://www.vegrecipesofindia.com/wp-content/uploads/2014/05/paneer-butter-masala-1a.jpg', 'https://www.vegrecipesofindia.com/recipes/paneer/', 'paneer bhurji in a serving bowl, appetizing plated food photography',
  true, false, false, false,
  true, 2, 'paneer',
  'main', false, 'north', '{"staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('paneer') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'paneer', _ingredient_id,
  250, 'g', 'cubed',
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('vegetable oil') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'vegetable oil', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('onion') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'onion', _ingredient_id,
  180, 'g', 'finely chopped',
  false, 'base', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('tomato') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'tomato', _ingredient_id,
  180, 'g', 'finely chopped',
  false, 'base', 3
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('ginger garlic paste') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'ginger garlic paste', _ingredient_id,
  1, 'tablespoon', NULL,
  false, 'aromatics', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('green chili') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'green chili', _ingredient_id,
  2, 'piece', 'slit',
  false, 'aromatics', 5
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('turmeric powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'turmeric powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 6
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('red chili powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'red chili powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 7
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coriander powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coriander powder', _ingredient_id,
  2, 'teaspoon', NULL,
  false, 'spice mix', 8
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('garam masala') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'garam masala', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 9
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('salt') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'salt', _ingredient_id,
  5, 'g', NULL,
  false, 'seasoning', 10
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coriander leaves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coriander leaves', _ingredient_id,
  15, 'g', 'chopped',
  false, 'finish', 11
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('capsicum') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'capsicum', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 12
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat oil in a heavy pan over medium heat. Add the aromatics and cook for 6 to 8 minutes until they soften and smell sweet.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Stir in the ground spices, then add paneer. Cook for 3 to 4 minutes so the masala coats everything evenly and loses any raw edge.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Add water or other liquid as needed, cover, and simmer on medium heat until the main ingredient is cooked through and the gravy thickens.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 4, 'Add the finishing dairy and herbs, then simmer gently so the paneer stays soft. Simmer for 2 more minutes, then rest the dish for 5 minutes before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 52/215: Shahi Paneer
-- -----------------------------------------------------------------------
INSERT INTO global_recipes (
  title, description, cuisine, cuisine_category, cuisine_region,
  meal_types, servings, prep_time_min, cook_time_min,
  difficulty, tags, cooking_style, dietary_tags,
  image_url, source_url, image_search_query,
  is_vegetarian, is_vegan, is_eggetarian, is_jain,
  is_batch_friendly, leftover_days, protein_category,
  dish_role, is_standalone, pairing_group, needs_roles
) VALUES (
  'Shahi Paneer', 'Shahi Paneer features tender paneer and a cashew cream gravy. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'mughlai', NULL, 'royal-style',
  '{"lunch","dinner"}', 4, 20, 25,
  'medium', '{"restaurant-style","family-favorite","comfort-food"}', '{"one-pot"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2021/08/shahi-paneer-recipe.jpg', 'https://www.indianhealthyrecipes.com/shahi-paneer-recipe/', 'shahi paneer in a serving bowl, appetizing plated food photography',
  true, false, false, false,
  true, 2, 'paneer',
  'main', false, 'north', '{"staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('paneer') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'paneer', _ingredient_id,
  250, 'g', 'cubed',
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('vegetable oil') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'vegetable oil', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('onion') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'onion', _ingredient_id,
  180, 'g', 'finely chopped',
  false, 'base', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('tomato') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'tomato', _ingredient_id,
  180, 'g', 'finely chopped',
  false, 'base', 3
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('ginger garlic paste') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'ginger garlic paste', _ingredient_id,
  1, 'tablespoon', NULL,
  false, 'aromatics', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('green chili') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'green chili', _ingredient_id,
  2, 'piece', 'slit',
  false, 'aromatics', 5
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('turmeric powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'turmeric powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 6
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('red chili powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'red chili powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 7
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coriander powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coriander powder', _ingredient_id,
  2, 'teaspoon', NULL,
  false, 'spice mix', 8
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('garam masala') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'garam masala', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 9
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('salt') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'salt', _ingredient_id,
  5, 'g', NULL,
  false, 'seasoning', 10
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coriander leaves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coriander leaves', _ingredient_id,
  15, 'g', 'chopped',
  false, 'finish', 11
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cream') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cream', _ingredient_id,
  80, 'ml', NULL,
  false, 'finish', 12
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cashews') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cashews', _ingredient_id,
  40, 'g', NULL,
  false, 'finish', 13
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('saffron') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'saffron', _ingredient_id,
  0.5, 'teaspoon', NULL,
  false, 'finish', 14
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cardamom') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cardamom', _ingredient_id,
  1, 'piece', NULL,
  false, 'whole spices', 15
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat oil in a heavy pan over medium heat. Add the aromatics and cook for 6 to 8 minutes until they soften and smell sweet.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Stir in the ground spices, then add paneer. Cook for 3 to 4 minutes so the masala coats everything evenly and loses any raw edge.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Add water or other liquid as needed, cover, and simmer on medium heat until the main ingredient is cooked through and the gravy thickens.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 4, 'Add the finishing dairy and herbs, then simmer gently so the paneer stays soft. Simmer for 2 more minutes, then rest the dish for 5 minutes before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 53/215: Mattar Paneer
-- -----------------------------------------------------------------------
INSERT INTO global_recipes (
  title, description, cuisine, cuisine_category, cuisine_region,
  meal_types, servings, prep_time_min, cook_time_min,
  difficulty, tags, cooking_style, dietary_tags,
  image_url, source_url, image_search_query,
  is_vegetarian, is_vegan, is_eggetarian, is_jain,
  is_batch_friendly, leftover_days, protein_category,
  dish_role, is_standalone, pairing_group, needs_roles
) VALUES (
  'Mattar Paneer', 'Mattar Paneer features tender paneer and a sweet peas in tomato gravy. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'punjabi', NULL, 'home-style',
  '{"lunch","dinner"}', 4, 15, 25,
  'medium', '{"restaurant-style","family-favorite","comfort-food"}', '{"one-pot"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2022/04/matar-paneer.jpg', 'https://www.indianhealthyrecipes.com/matar-paneer-mutter-masala/', 'mattar paneer in a serving bowl, appetizing plated food photography',
  true, false, false, false,
  true, 2, 'paneer',
  'main', false, 'north', '{"staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('paneer') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'paneer', _ingredient_id,
  250, 'g', 'cubed',
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('vegetable oil') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'vegetable oil', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('onion') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'onion', _ingredient_id,
  180, 'g', 'finely chopped',
  false, 'base', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('tomato') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'tomato', _ingredient_id,
  180, 'g', 'finely chopped',
  false, 'base', 3
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('ginger garlic paste') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'ginger garlic paste', _ingredient_id,
  1, 'tablespoon', NULL,
  false, 'aromatics', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('green chili') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'green chili', _ingredient_id,
  2, 'piece', 'slit',
  false, 'aromatics', 5
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('turmeric powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'turmeric powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 6
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('red chili powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'red chili powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 7
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coriander powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coriander powder', _ingredient_id,
  2, 'teaspoon', NULL,
  false, 'spice mix', 8
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('garam masala') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'garam masala', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 9
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('salt') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'salt', _ingredient_id,
  5, 'g', NULL,
  false, 'seasoning', 10
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coriander leaves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coriander leaves', _ingredient_id,
  15, 'g', 'chopped',
  false, 'finish', 11
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('peas') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'peas', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 12
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat oil in a heavy pan over medium heat. Add the aromatics and cook for 6 to 8 minutes until they soften and smell sweet.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Stir in the ground spices, then add paneer. Cook for 3 to 4 minutes so the masala coats everything evenly and loses any raw edge.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Add water or other liquid as needed, cover, and simmer on medium heat until the main ingredient is cooked through and the gravy thickens.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 4, 'Add the finishing dairy and herbs, then simmer gently so the paneer stays soft. Simmer for 2 more minutes, then rest the dish for 5 minutes before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 54/215: Dum Aloo Kashmiri
-- -----------------------------------------------------------------------
INSERT INTO global_recipes (
  title, description, cuisine, cuisine_category, cuisine_region,
  meal_types, servings, prep_time_min, cook_time_min,
  difficulty, tags, cooking_style, dietary_tags,
  image_url, source_url, image_search_query,
  is_vegetarian, is_vegan, is_eggetarian, is_jain,
  is_batch_friendly, leftover_days, protein_category,
  dish_role, is_standalone, pairing_group, needs_roles
) VALUES (
  'Dum Aloo Kashmiri', 'Dum Aloo Kashmiri features potato cooked until flavorful yet distinct. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'kashmiri', NULL, 'dum-style',
  '{"lunch","dinner"}', 4, 20, 40,
  'hard', '{"homestyle","weekday-friendly","veg-side"}', '{"slow-cook","weekend-project"}', '{}',
  'https://www.vegrecipesofindia.com/wp-content/uploads/2024/12/kashmiri-dum-aloo-1.jpg', 'https://www.vegrecipesofindia.com/kashmiri-dum-aloo/', 'dum aloo kashmiri in a serving bowl, appetizing plated food photography',
  true, false, false, false,
  true, 2, NULL,
  'main', false, 'north', '{"staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('potato') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'potato', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('vegetable oil') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'vegetable oil', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('onion') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'onion', _ingredient_id,
  180, 'g', 'finely chopped',
  false, 'base', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('ginger garlic paste') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'ginger garlic paste', _ingredient_id,
  1, 'tablespoon', NULL,
  false, 'aromatics', 3
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('green chili') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'green chili', _ingredient_id,
  2, 'piece', 'slit',
  false, 'aromatics', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('turmeric powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'turmeric powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 5
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('red chili powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'red chili powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 6
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coriander powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coriander powder', _ingredient_id,
  2, 'teaspoon', NULL,
  false, 'spice mix', 7
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('salt') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'salt', _ingredient_id,
  5, 'g', NULL,
  false, 'seasoning', 8
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coriander leaves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coriander leaves', _ingredient_id,
  15, 'g', 'chopped',
  false, 'finish', 9
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('curd') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'curd', _ingredient_id,
  120, 'g', 'whisked',
  false, 'main', 10
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('fennel seeds') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'fennel seeds', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 11
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('kashmiri chili powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'kashmiri chili powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 12
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat oil in a wide skillet and bloom the tempering ingredients for 30 seconds. Add the base ingredients and cook for 4 to 5 minutes until lightly softened.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Add potato with the spice powders and salt. Toss well, then cook uncovered on medium heat until the vegetables or protein are just tender.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Finish with herbs and cook until the pan looks dry and glossy rather than wet. Cook for 2 more minutes so the masala clings to the ingredients instead of pooling in the pan.'
);

-- -----------------------------------------------------------------------
-- Recipe 55/215: Mushroom Masala
-- -----------------------------------------------------------------------
INSERT INTO global_recipes (
  title, description, cuisine, cuisine_category, cuisine_region,
  meal_types, servings, prep_time_min, cook_time_min,
  difficulty, tags, cooking_style, dietary_tags,
  image_url, source_url, image_search_query,
  is_vegetarian, is_vegan, is_eggetarian, is_jain,
  is_batch_friendly, leftover_days, protein_category,
  dish_role, is_standalone, pairing_group, needs_roles
) VALUES (
  'Mushroom Masala', 'Mushroom Masala features mushroom cooked until flavorful yet distinct. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'north_indian', NULL, 'restaurant-style',
  '{"lunch","dinner"}', 4, 15, 25,
  'medium', '{"homestyle","weekday-friendly","veg-side"}', '{"stir-fry"}', '{}',
  'https://www.vegrecipesofindia.com/wp-content/uploads/2025/04/mushroom-masala.jpg', 'https://www.vegrecipesofindia.com/mushroom-curry-recipe-mushroom-masala/', 'mushroom masala in a serving bowl, appetizing plated food photography',
  true, true, false, false,
  true, 2, NULL,
  'main', false, 'north', '{"staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('mushroom') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'mushroom', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('vegetable oil') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'vegetable oil', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('onion') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'onion', _ingredient_id,
  180, 'g', 'finely chopped',
  false, 'base', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('ginger garlic paste') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'ginger garlic paste', _ingredient_id,
  1, 'tablespoon', NULL,
  false, 'aromatics', 3
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('green chili') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'green chili', _ingredient_id,
  2, 'piece', 'slit',
  false, 'aromatics', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('turmeric powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'turmeric powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 5
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('red chili powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'red chili powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 6
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coriander powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coriander powder', _ingredient_id,
  2, 'teaspoon', NULL,
  false, 'spice mix', 7
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('salt') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'salt', _ingredient_id,
  5, 'g', NULL,
  false, 'seasoning', 8
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coriander leaves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coriander leaves', _ingredient_id,
  15, 'g', 'chopped',
  false, 'finish', 9
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('tomato') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'tomato', _ingredient_id,
  180, 'g', 'finely chopped',
  false, 'base', 10
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('kitchen king masala') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'kitchen king masala', _ingredient_id,
  2, 'teaspoon', NULL,
  false, 'spice mix', 11
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat oil in a wide skillet and bloom the tempering ingredients for 30 seconds. Add the base ingredients and cook for 4 to 5 minutes until lightly softened.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Add mushroom with the spice powders and salt. Toss well, then cook uncovered on medium heat until the vegetables or protein are just tender.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Finish with herbs and cook until the pan looks dry and glossy rather than wet. Cook for 2 more minutes so the masala clings to the ingredients instead of pooling in the pan.'
);

-- -----------------------------------------------------------------------
-- Recipe 56/215: Baby Corn Manchurian
-- -----------------------------------------------------------------------
INSERT INTO global_recipes (
  title, description, cuisine, cuisine_category, cuisine_region,
  meal_types, servings, prep_time_min, cook_time_min,
  difficulty, tags, cooking_style, dietary_tags,
  image_url, source_url, image_search_query,
  is_vegetarian, is_vegan, is_eggetarian, is_jain,
  is_batch_friendly, leftover_days, protein_category,
  dish_role, is_standalone, pairing_group, needs_roles
) VALUES (
  'Baby Corn Manchurian', 'Baby Corn Manchurian is a crowd-pleasing snack with crisp edges and punchy seasoning. It has the kind of bold flavor and texture that works well for sharing.', 'indo_chinese', NULL, 'restaurant-style',
  '{"snack"}', 4, 20, 25,
  'medium', '{"tea-time","crowd-pleaser","weekend-treat"}', '{"stir-fry"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2024/06/baby-corn-manchurian-recipe.jpg', 'https://www.indianhealthyrecipes.com/baby-corn-manchurian-recipe-baby-corn-recipes/', 'baby corn manchurian in a serving bowl, appetizing plated food photography',
  true, true, false, false,
  false, 1, NULL,
  'complete', true, 'indo_chinese', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('baby corn') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'baby corn', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('corn flour') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'corn flour', _ingredient_id,
  320, 'g', NULL,
  false, 'main', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('spring onion') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'spring onion', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('soy sauce') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'soy sauce', _ingredient_id,
  1, 'tablespoon', NULL,
  false, 'sauce', 3
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('vinegar') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'vinegar', _ingredient_id,
  1, 'tablespoon', NULL,
  false, 'sauce', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('tomato ketchup') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'tomato ketchup', _ingredient_id,
  1, 'tablespoon', NULL,
  false, 'sauce', 5
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('green chili') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'green chili', _ingredient_id,
  2, 'piece', 'slit',
  false, 'aromatics', 6
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('garlic') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'garlic', _ingredient_id,
  20, 'g', 'minced',
  false, 'aromatics', 7
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('vegetable oil') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'vegetable oil', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 8
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('salt') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'salt', _ingredient_id,
  5, 'g', NULL,
  false, 'seasoning', 9
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Coat the baby corn with corn flour, salt, and a splash of water, then shallow-fry or pan-fry until lightly crisp.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Saute garlic, green chili, and spring onion in hot oil for 1 minute, then stir in soy sauce, vinegar, and tomato ketchup.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Add the crisp baby corn and toss over high heat for 2 minutes so the sauce clings without turning watery.'
);

-- -----------------------------------------------------------------------
-- Recipe 57/215: Veg Manchurian
-- -----------------------------------------------------------------------
INSERT INTO global_recipes (
  title, description, cuisine, cuisine_category, cuisine_region,
  meal_types, servings, prep_time_min, cook_time_min,
  difficulty, tags, cooking_style, dietary_tags,
  image_url, source_url, image_search_query,
  is_vegetarian, is_vegan, is_eggetarian, is_jain,
  is_batch_friendly, leftover_days, protein_category,
  dish_role, is_standalone, pairing_group, needs_roles
) VALUES (
  'Veg Manchurian', 'Veg Manchurian is a crowd-pleasing snack with crisp edges and punchy seasoning. It has the kind of bold flavor and texture that works well for sharing.', 'indo_chinese', NULL, 'restaurant-style',
  '{"snack"}', 4, 20, 25,
  'medium', '{"tea-time","crowd-pleaser","weekend-treat"}', '{"stir-fry"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2021/07/veg-manchurian.jpg', 'https://www.indianhealthyrecipes.com/veg-manchurian-recipe/', 'veg manchurian in a serving bowl, appetizing plated food photography',
  true, true, false, false,
  false, 1, NULL,
  'complete', true, 'indo_chinese', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cabbage') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cabbage', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('carrot') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'carrot', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('capsicum') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'capsicum', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('corn flour') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'corn flour', _ingredient_id,
  320, 'g', NULL,
  false, 'main', 3
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('spring onion') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'spring onion', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('soy sauce') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'soy sauce', _ingredient_id,
  1, 'tablespoon', NULL,
  false, 'sauce', 5
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('vinegar') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'vinegar', _ingredient_id,
  1, 'tablespoon', NULL,
  false, 'sauce', 6
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('garlic') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'garlic', _ingredient_id,
  20, 'g', 'minced',
  false, 'aromatics', 7
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('vegetable oil') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'vegetable oil', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 8
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('salt') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'salt', _ingredient_id,
  5, 'g', NULL,
  false, 'seasoning', 9
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Finely chop the vegetables and mix them with corn flour and salt into a firm mixture. Shape into small balls and fry until lightly golden.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Make the sauce by sauteing garlic and spring onion, then adding soy sauce, vinegar, and a splash of water.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Fold in the fried vegetable balls and cook for 1 to 2 minutes so they stay coated but not soggy.'
);

-- -----------------------------------------------------------------------
-- Recipe 58/215: Chilli Paneer
-- -----------------------------------------------------------------------
INSERT INTO global_recipes (
  title, description, cuisine, cuisine_category, cuisine_region,
  meal_types, servings, prep_time_min, cook_time_min,
  difficulty, tags, cooking_style, dietary_tags,
  image_url, source_url, image_search_query,
  is_vegetarian, is_vegan, is_eggetarian, is_jain,
  is_batch_friendly, leftover_days, protein_category,
  dish_role, is_standalone, pairing_group, needs_roles
) VALUES (
  'Chilli Paneer', 'Chilli Paneer is a crowd-pleasing snack with crisp edges and punchy seasoning. It has the kind of bold flavor and texture that works well for sharing.', 'indo_chinese', NULL, 'restaurant-style',
  '{"snack","dinner"}', 4, 10, 18,
  'easy', '{"tea-time","crowd-pleaser","weekend-treat"}', '{"stir-fry","quick"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2022/02/chilli-paneer-recipe.jpg', 'https://www.indianhealthyrecipes.com/chilli-paneer-recipe/', 'chilli paneer in a serving bowl, appetizing plated food photography',
  true, false, false, false,
  false, 1, 'paneer',
  'complete', true, 'indo_chinese', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('paneer') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'paneer', _ingredient_id,
  250, 'g', 'cubed',
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('capsicum') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'capsicum', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('spring onion') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'spring onion', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('soy sauce') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'soy sauce', _ingredient_id,
  1, 'tablespoon', NULL,
  false, 'sauce', 3
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('vinegar') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'vinegar', _ingredient_id,
  1, 'tablespoon', NULL,
  false, 'sauce', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('garlic') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'garlic', _ingredient_id,
  20, 'g', 'minced',
  false, 'aromatics', 5
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('green chili') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'green chili', _ingredient_id,
  2, 'piece', 'slit',
  false, 'aromatics', 6
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('corn flour') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'corn flour', _ingredient_id,
  320, 'g', NULL,
  false, 'main', 7
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('vegetable oil') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'vegetable oil', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 8
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('salt') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'salt', _ingredient_id,
  5, 'g', NULL,
  false, 'seasoning', 9
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Toss paneer lightly with corn flour and pan-sear it on medium heat until the edges turn light golden.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Cook garlic, green chili, capsicum, and spring onion in a hot wok for 2 to 3 minutes so the vegetables stay crisp.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Add soy sauce and vinegar, return the paneer to the wok, and toss quickly until the sauce coats every piece.'
);

-- -----------------------------------------------------------------------
-- Recipe 59/215: Tofu Stir Fry
-- -----------------------------------------------------------------------
INSERT INTO global_recipes (
  title, description, cuisine, cuisine_category, cuisine_region,
  meal_types, servings, prep_time_min, cook_time_min,
  difficulty, tags, cooking_style, dietary_tags,
  image_url, source_url, image_search_query,
  is_vegetarian, is_vegan, is_eggetarian, is_jain,
  is_batch_friendly, leftover_days, protein_category,
  dish_role, is_standalone, pairing_group, needs_roles
) VALUES (
  'Tofu Stir Fry', 'Tofu Stir Fry is a quick skillet dish with focused seasoning and lively texture. It is easy enough for a weeknight but still feels intentional on the plate.', 'continental', NULL, 'weekday skillet',
  '{"breakfast","lunch","dinner"}', 4, 10, 15,
  'easy', '{"weekday-friendly","quick","veg-side"}', '{"quick","stir-fry"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2023/05/indian-tofu-stir-fry.jpg', 'https://www.indianhealthyrecipes.com/tofu-stir-fry-recipe/', 'tofu stir fry in a serving bowl, appetizing plated food photography',
  true, true, false, false,
  false, 1, 'tofu',
  'main', false, 'continental', '{"staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('tofu') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'tofu', _ingredient_id,
  250, 'g', 'cubed',
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('olive oil') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'olive oil', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('green chili') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'green chili', _ingredient_id,
  2, 'piece', 'slit',
  false, 'aromatics', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('black pepper') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'black pepper', _ingredient_id,
  1, 'teaspoon', 'coarsely crushed',
  false, 'spice mix', 3
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('salt') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'salt', _ingredient_id,
  5, 'g', NULL,
  false, 'seasoning', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('capsicum') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'capsicum', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 5
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('broccoli') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'broccoli', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 6
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('soy sauce') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'soy sauce', _ingredient_id,
  1, 'tablespoon', NULL,
  false, 'sauce', 7
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat oil in a wide skillet and bloom the tempering ingredients for 30 seconds. Add the base ingredients and cook for 4 to 5 minutes until lightly softened.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Add tofu with the spice powders and salt. Toss well, then cook uncovered on medium heat until the vegetables or protein are just tender.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Finish with the last seasoning additions and toss quickly so the ingredients stay vibrant. Cook for 2 more minutes so the masala clings to the ingredients instead of pooling in the pan.'
);

-- -----------------------------------------------------------------------
-- Recipe 60/215: Vegetable Sandwich
-- -----------------------------------------------------------------------
INSERT INTO global_recipes (
  title, description, cuisine, cuisine_category, cuisine_region,
  meal_types, servings, prep_time_min, cook_time_min,
  difficulty, tags, cooking_style, dietary_tags,
  image_url, source_url, image_search_query,
  is_vegetarian, is_vegan, is_eggetarian, is_jain,
  is_batch_friendly, leftover_days, protein_category,
  dish_role, is_standalone, pairing_group, needs_roles
) VALUES (
  'Vegetable Sandwich', 'Vegetable Sandwich is a crowd-pleasing snack with crisp edges and punchy seasoning. It has the kind of bold flavor and texture that works well for sharing.', 'continental', NULL, 'cafe-style',
  '{"breakfast","snack","lunch"}', 4, 10, 10,
  'easy', '{"tea-time","crowd-pleaser","weekend-treat"}', '{"quick"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2022/04/sandwich-recipes-swasthi.jpg', 'https://www.indianhealthyrecipes.com/sandwich-recipes/', 'vegetable sandwich in a serving bowl, appetizing plated food photography',
  true, true, false, false,
  false, 1, NULL,
  'complete', true, 'continental', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('bread') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'bread', _ingredient_id,
  8, 'piece', NULL,
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cucumber') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cucumber', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('tomato') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'tomato', _ingredient_id,
  180, 'g', 'finely chopped',
  false, 'base', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('onion') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'onion', _ingredient_id,
  180, 'g', 'finely chopped',
  false, 'base', 3
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('green chutney') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'green chutney', _ingredient_id,
  2, 'tablespoon', NULL,
  false, 'finish', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('black pepper') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'black pepper', _ingredient_id,
  1, 'teaspoon', 'coarsely crushed',
  false, 'spice mix', 5
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('salt') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'salt', _ingredient_id,
  5, 'g', NULL,
  false, 'seasoning', 6
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Spread green chutney evenly on the bread slices so each bite tastes bright and savory.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Layer cucumber, tomato, and onion over one slice, season with salt and black pepper, then close with the second slice.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Press gently, trim if desired, and cut into triangles just before serving so the bread stays soft.'
);

-- -----------------------------------------------------------------------
-- Recipe 61/215: Corn Cheese Sandwich
-- -----------------------------------------------------------------------
INSERT INTO global_recipes (
  title, description, cuisine, cuisine_category, cuisine_region,
  meal_types, servings, prep_time_min, cook_time_min,
  difficulty, tags, cooking_style, dietary_tags,
  image_url, source_url, image_search_query,
  is_vegetarian, is_vegan, is_eggetarian, is_jain,
  is_batch_friendly, leftover_days, protein_category,
  dish_role, is_standalone, pairing_group, needs_roles
) VALUES (
  'Corn Cheese Sandwich', 'Corn Cheese Sandwich is a crowd-pleasing snack with crisp edges and punchy seasoning. It has the kind of bold flavor and texture that works well for sharing.', 'continental', NULL, 'cafe-style',
  '{"breakfast","snack","lunch"}', 4, 10, 10,
  'easy', '{"tea-time","crowd-pleaser","weekend-treat"}', '{"quick"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2022/04/corn-sandwich-recipe.jpg', 'https://www.indianhealthyrecipes.com/corn-cheese-sandwich-recipe/', 'corn cheese sandwich in a serving bowl, appetizing plated food photography',
  true, false, false, false,
  false, 1, NULL,
  'complete', true, 'continental', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('bread') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'bread', _ingredient_id,
  8, 'piece', NULL,
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('corn') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'corn', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cheese') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cheese', _ingredient_id,
  120, 'g', 'grated',
  false, 'finish', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('black pepper') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'black pepper', _ingredient_id,
  1, 'teaspoon', 'coarsely crushed',
  false, 'spice mix', 3
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('butter') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'butter', _ingredient_id,
  25, 'g', NULL,
  false, 'cooking fat', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('salt') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'salt', _ingredient_id,
  5, 'g', NULL,
  false, 'seasoning', 5
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Mix corn, grated cheese, salt, and black pepper into a simple sandwich filling.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Butter the bread lightly, spread the filling, and close the sandwich.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Toast on a pan or sandwich press until the outside turns golden and the cheese melts fully.'
);

-- -----------------------------------------------------------------------
-- Recipe 62/215: Broccoli Soup
-- -----------------------------------------------------------------------
INSERT INTO global_recipes (
  title, description, cuisine, cuisine_category, cuisine_region,
  meal_types, servings, prep_time_min, cook_time_min,
  difficulty, tags, cooking_style, dietary_tags,
  image_url, source_url, image_search_query,
  is_vegetarian, is_vegan, is_eggetarian, is_jain,
  is_batch_friendly, leftover_days, protein_category,
  dish_role, is_standalone, pairing_group, needs_roles
) VALUES (
  'Broccoli Soup', 'Broccoli Soup is a warming bowl with clean flavors and gentle seasoning. It is light enough for a quick meal yet still satisfying.', 'continental', NULL, 'home-style',
  '{"lunch","dinner"}', 4, 10, 15,
  'easy', '{"light-meal","comfort-food","quick"}', '{"quick"}', '{}',
  'https://www.vegrecipesofindia.com/wp-content/uploads/2021/02/cream-of-broccoli-soup-01.jpg', 'https://www.vegrecipesofindia.com/veg-cream-of-broccoli-soup/', 'broccoli soup in a serving bowl, appetizing plated food photography',
  true, true, false, false,
  true, 2, NULL,
  'complete', true, 'continental', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('broccoli') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'broccoli', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('olive oil') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'olive oil', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('onion') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'onion', _ingredient_id,
  180, 'g', 'finely chopped',
  false, 'base', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('garlic') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'garlic', _ingredient_id,
  20, 'g', 'minced',
  false, 'aromatics', 3
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('black pepper') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'black pepper', _ingredient_id,
  1, 'teaspoon', 'coarsely crushed',
  false, 'spice mix', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('salt') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'salt', _ingredient_id,
  5, 'g', NULL,
  false, 'seasoning', 5
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('water') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'water', _ingredient_id,
  500, 'ml', NULL,
  false, 'cooking liquid', 6
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat fat in a saucepan, add the aromatics, and cook for 3 to 4 minutes until fragrant.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Add broccoli, seasoning, and liquid. Simmer gently for 10 to 15 minutes until the flavors meld and the vegetables or protein are tender.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Blend lightly if needed, adjust salt and pepper, then simmer for 2 more minutes before serving hot.'
);

-- -----------------------------------------------------------------------
-- Recipe 63/215: Tomato Soup
-- -----------------------------------------------------------------------
INSERT INTO global_recipes (
  title, description, cuisine, cuisine_category, cuisine_region,
  meal_types, servings, prep_time_min, cook_time_min,
  difficulty, tags, cooking_style, dietary_tags,
  image_url, source_url, image_search_query,
  is_vegetarian, is_vegan, is_eggetarian, is_jain,
  is_batch_friendly, leftover_days, protein_category,
  dish_role, is_standalone, pairing_group, needs_roles
) VALUES (
  'Tomato Soup', 'Tomato Soup is a warming bowl with clean flavors and gentle seasoning. It is light enough for a quick meal yet still satisfying.', 'continental', NULL, 'classic',
  '{"lunch","dinner"}', 4, 10, 15,
  'easy', '{"light-meal","comfort-food","quick"}', '{"quick"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2022/11/tomato-soup-recipe.jpg', 'https://www.indianhealthyrecipes.com/tomato-soup-recipe/', 'tomato soup in a serving bowl, appetizing plated food photography',
  true, true, false, false,
  true, 2, NULL,
  'complete', true, 'continental', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('tomato') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'tomato', _ingredient_id,
  180, 'g', 'finely chopped',
  false, 'base', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('olive oil') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'olive oil', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('onion') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'onion', _ingredient_id,
  180, 'g', 'finely chopped',
  false, 'base', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('garlic') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'garlic', _ingredient_id,
  20, 'g', 'minced',
  false, 'aromatics', 3
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('black pepper') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'black pepper', _ingredient_id,
  1, 'teaspoon', 'coarsely crushed',
  false, 'spice mix', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('salt') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'salt', _ingredient_id,
  5, 'g', NULL,
  false, 'seasoning', 5
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('water') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'water', _ingredient_id,
  500, 'ml', NULL,
  false, 'cooking liquid', 6
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('oregano') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'oregano', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'seasoning', 7
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat fat in a saucepan, add the aromatics, and cook for 3 to 4 minutes until fragrant.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Add tomato, seasoning, and liquid. Simmer gently for 10 to 15 minutes until the flavors meld and the vegetables or protein are tender.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Blend lightly if needed, adjust salt and pepper, then simmer for 2 more minutes before serving hot.'
);

-- -----------------------------------------------------------------------
-- Recipe 64/215: Spinach Soup
-- -----------------------------------------------------------------------
INSERT INTO global_recipes (
  title, description, cuisine, cuisine_category, cuisine_region,
  meal_types, servings, prep_time_min, cook_time_min,
  difficulty, tags, cooking_style, dietary_tags,
  image_url, source_url, image_search_query,
  is_vegetarian, is_vegan, is_eggetarian, is_jain,
  is_batch_friendly, leftover_days, protein_category,
  dish_role, is_standalone, pairing_group, needs_roles
) VALUES (
  'Spinach Soup', 'Spinach Soup is a warming bowl with clean flavors and gentle seasoning. It is light enough for a quick meal yet still satisfying.', 'continental', NULL, 'light meal',
  '{"lunch","dinner"}', 4, 10, 15,
  'easy', '{"light-meal","comfort-food","quick"}', '{"quick"}', '{}',
  'https://www.vegrecipesofindia.com/wp-content/uploads/2021/08/spinach-soup-01.jpg', 'https://www.vegrecipesofindia.com/palak-soup-or-spinach-soup/', 'spinach soup in a serving bowl, appetizing plated food photography',
  true, true, false, false,
  true, 2, NULL,
  'complete', true, 'continental', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('spinach') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'spinach', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('olive oil') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'olive oil', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('onion') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'onion', _ingredient_id,
  180, 'g', 'finely chopped',
  false, 'base', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('garlic') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'garlic', _ingredient_id,
  20, 'g', 'minced',
  false, 'aromatics', 3
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('black pepper') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'black pepper', _ingredient_id,
  1, 'teaspoon', 'coarsely crushed',
  false, 'spice mix', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('salt') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'salt', _ingredient_id,
  5, 'g', NULL,
  false, 'seasoning', 5
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('water') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'water', _ingredient_id,
  500, 'ml', NULL,
  false, 'cooking liquid', 6
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat fat in a saucepan, add the aromatics, and cook for 3 to 4 minutes until fragrant.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Add spinach, seasoning, and liquid. Simmer gently for 10 to 15 minutes until the flavors meld and the vegetables or protein are tender.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Blend lightly if needed, adjust salt and pepper, then simmer for 2 more minutes before serving hot.'
);

-- -----------------------------------------------------------------------
-- Recipe 65/215: Chickpea Salad
-- -----------------------------------------------------------------------
INSERT INTO global_recipes (
  title, description, cuisine, cuisine_category, cuisine_region,
  meal_types, servings, prep_time_min, cook_time_min,
  difficulty, tags, cooking_style, dietary_tags,
  image_url, source_url, image_search_query,
  is_vegetarian, is_vegan, is_eggetarian, is_jain,
  is_batch_friendly, leftover_days, protein_category,
  dish_role, is_standalone, pairing_group, needs_roles
) VALUES (
  'Chickpea Salad', 'Chickpea Salad combines fresh produce with a bright, savory dressing. It is crisp, colorful, and especially useful for lighter lunches.', 'continental', NULL, 'light lunch',
  '{"breakfast","lunch"}', 4, 15, 0,
  'easy', '{"light-meal","fresh","quick"}', '{"no-cook"}', '{}',
  'https://www.vegrecipesofindia.com/wp-content/uploads/2022/07/chickpea-salad.jpg', 'https://www.vegrecipesofindia.com/chickpea-salad/', 'chickpea salad in a serving bowl, appetizing plated food photography',
  true, true, false, false,
  false, 1, 'legume',
  'complete', true, 'continental', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('chickpeas') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'chickpeas', _ingredient_id,
  220, 'g', 'soaked overnight',
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cucumber') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cucumber', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('lettuce') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'lettuce', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('lemon juice') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'lemon juice', _ingredient_id,
  1, 'tablespoon', NULL,
  false, 'finish', 3
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('black pepper') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'black pepper', _ingredient_id,
  1, 'teaspoon', 'coarsely crushed',
  false, 'spice mix', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('salt') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'salt', _ingredient_id,
  5, 'g', NULL,
  false, 'seasoning', 5
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('tomato') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'tomato', _ingredient_id,
  180, 'g', 'finely chopped',
  false, 'base', 6
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('onion') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'onion', _ingredient_id,
  180, 'g', 'finely chopped',
  false, 'base', 7
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coriander leaves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coriander leaves', _ingredient_id,
  15, 'g', 'chopped',
  false, 'finish', 8
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Prep all the vegetables and chill them for 10 minutes if you want a crisper finish.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Cook the main ingredient briefly if needed, then let it cool until just warm.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Toss everything with the seasoning and dressing ingredients just before serving so the textures stay fresh.'
);

-- -----------------------------------------------------------------------
-- Recipe 66/215: Bread Upma
-- -----------------------------------------------------------------------
INSERT INTO global_recipes (
  title, description, cuisine, cuisine_category, cuisine_region,
  meal_types, servings, prep_time_min, cook_time_min,
  difficulty, tags, cooking_style, dietary_tags,
  image_url, source_url, image_search_query,
  is_vegetarian, is_vegan, is_eggetarian, is_jain,
  is_batch_friendly, leftover_days, protein_category,
  dish_role, is_standalone, pairing_group, needs_roles
) VALUES (
  'Bread Upma', 'Bread Upma is a tiffin-style favorite made for easy breakfasts and light meals. It is satisfying, familiar, and seasoned to feel bright rather than heavy.', 'street_food', NULL, 'quick breakfast',
  '{"breakfast","snack"}', 4, 10, 12,
  'easy', '{"tiffin","weekday-friendly","comfort-food"}', '{"quick"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2022/06/bread-upma-recipe.jpg', 'https://www.indianhealthyrecipes.com/bread-upma-recipe/', 'bread upma plated with chutney or side accompaniments, Indian breakfast photography',
  true, true, false, false,
  false, 1, NULL,
  'complete', true, 'street', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('bread') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'bread', _ingredient_id,
  8, 'piece', NULL,
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('onion') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'onion', _ingredient_id,
  180, 'g', 'finely chopped',
  false, 'base', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('tomato') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'tomato', _ingredient_id,
  180, 'g', 'finely chopped',
  false, 'base', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('green chili') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'green chili', _ingredient_id,
  2, 'piece', 'slit',
  false, 'aromatics', 3
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('mustard seeds') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'mustard seeds', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'tempering', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('curry leaves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'curry leaves', _ingredient_id,
  10, 'g', NULL,
  false, 'tempering', 5
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('vegetable oil') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'vegetable oil', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 6
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('salt') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'salt', _ingredient_id,
  5, 'g', NULL,
  false, 'seasoning', 7
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Cut the bread into small cubes and keep it loosely spread out so it does not clump.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Cook mustard seeds, curry leaves, onion, tomato, and green chili in oil until the base turns lightly saucy.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Fold in the bread cubes and salt, toss gently for 2 minutes, and serve while the edges stay soft with a little toast.'
);

-- -----------------------------------------------------------------------
-- Recipe 67/215: Semiya Upma
-- -----------------------------------------------------------------------
INSERT INTO global_recipes (
  title, description, cuisine, cuisine_category, cuisine_region,
  meal_types, servings, prep_time_min, cook_time_min,
  difficulty, tags, cooking_style, dietary_tags,
  image_url, source_url, image_search_query,
  is_vegetarian, is_vegan, is_eggetarian, is_jain,
  is_batch_friendly, leftover_days, protein_category,
  dish_role, is_standalone, pairing_group, needs_roles
) VALUES (
  'Semiya Upma', 'Semiya Upma is a tiffin-style favorite made for easy breakfasts and light meals. It is satisfying, familiar, and seasoned to feel bright rather than heavy.', 'south_indian', NULL, 'weekday tiffin',
  '{"breakfast","snack"}', 4, 10, 15,
  'easy', '{"tiffin","weekday-friendly","comfort-food"}', '{"quick","one-pot"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2021/07/semiya-upma-recipe.jpg', 'https://www.indianhealthyrecipes.com/semiya-upma-vermicelli-upma-recipe/', 'semiya upma plated with chutney or side accompaniments, Indian breakfast photography',
  true, true, false, false,
  false, 1, NULL,
  'complete', true, 'south', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('vermicelli') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'vermicelli', _ingredient_id,
  220, 'g', NULL,
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('onion') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'onion', _ingredient_id,
  180, 'g', 'finely chopped',
  false, 'base', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('green chili') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'green chili', _ingredient_id,
  2, 'piece', 'slit',
  false, 'aromatics', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('mustard seeds') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'mustard seeds', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'tempering', 3
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('curry leaves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'curry leaves', _ingredient_id,
  10, 'g', NULL,
  false, 'tempering', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('peas') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'peas', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 5
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('vegetable oil') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'vegetable oil', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 6
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('salt') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'salt', _ingredient_id,
  5, 'g', NULL,
  false, 'seasoning', 7
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('water') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'water', _ingredient_id,
  500, 'ml', NULL,
  false, 'cooking liquid', 8
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Roast the vermicelli lightly until it smells nutty, then set it aside.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Saute mustard seeds, curry leaves, onion, green chili, and peas in oil until the onion softens.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Add water and salt, bring to a boil, then stir in the vermicelli and cook until soft and fluffy.'
);

-- -----------------------------------------------------------------------
-- Recipe 68/215: Zucchini Stir Fry
-- -----------------------------------------------------------------------
INSERT INTO global_recipes (
  title, description, cuisine, cuisine_category, cuisine_region,
  meal_types, servings, prep_time_min, cook_time_min,
  difficulty, tags, cooking_style, dietary_tags,
  image_url, source_url, image_search_query,
  is_vegetarian, is_vegan, is_eggetarian, is_jain,
  is_batch_friendly, leftover_days, protein_category,
  dish_role, is_standalone, pairing_group, needs_roles
) VALUES (
  'Zucchini Stir Fry', 'Zucchini Stir Fry is a quick skillet dish with focused seasoning and lively texture. It is easy enough for a weeknight but still feels intentional on the plate.', 'continental', NULL, 'weekday skillet',
  '{"lunch","dinner"}', 4, 10, 12,
  'easy', '{"weekday-friendly","quick","veg-side"}', '{"stir-fry","quick"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2022/06/zucchini-stir-fry.jpg', 'https://www.indianhealthyrecipes.com/zucchini-stir-fry/', 'zucchini stir fry in a serving bowl, appetizing plated food photography',
  true, true, false, false,
  false, 1, NULL,
  'side', false, 'continental', '{"main","staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('zucchini') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'zucchini', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('olive oil') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'olive oil', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('green chili') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'green chili', _ingredient_id,
  2, 'piece', 'slit',
  false, 'aromatics', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('black pepper') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'black pepper', _ingredient_id,
  1, 'teaspoon', 'coarsely crushed',
  false, 'spice mix', 3
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('salt') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'salt', _ingredient_id,
  5, 'g', NULL,
  false, 'seasoning', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('garlic') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'garlic', _ingredient_id,
  20, 'g', 'minced',
  false, 'aromatics', 5
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('chili flakes') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'chili flakes', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'seasoning', 6
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat oil in a wide skillet and bloom the tempering ingredients for 30 seconds. Add the base ingredients and cook for 4 to 5 minutes until lightly softened.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Add zucchini with the spice powders and salt. Toss well, then cook uncovered on medium heat until the vegetables or protein are just tender.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Finish with the last seasoning additions and toss quickly so the ingredients stay vibrant. Cook for 2 more minutes so the masala clings to the ingredients instead of pooling in the pan.'
);

-- -----------------------------------------------------------------------
-- Recipe 69/215: Rava Dosa
-- -----------------------------------------------------------------------
INSERT INTO global_recipes (
  title, description, cuisine, cuisine_category, cuisine_region,
  meal_types, servings, prep_time_min, cook_time_min,
  difficulty, tags, cooking_style, dietary_tags,
  image_url, source_url, image_search_query,
  is_vegetarian, is_vegan, is_eggetarian, is_jain,
  is_batch_friendly, leftover_days, protein_category,
  dish_role, is_standalone, pairing_group, needs_roles
) VALUES (
  'Rava Dosa', 'Rava Dosa is a tiffin-style favorite made for easy breakfasts and light meals. It is satisfying, familiar, and seasoned to feel bright rather than heavy.', 'karnataka', NULL, 'hotel-style',
  '{"breakfast","snack"}', 4, 15, 20,
  'medium', '{"tiffin","weekday-friendly","comfort-food"}', '{"stir-fry"}', '{}',
  'https://www.vegrecipesofindia.com/wp-content/uploads/2013/05/rava-dosa-recipe.jpg', 'https://www.vegrecipesofindia.com/rava-dosa-crisp-rava-dosa/', 'rava dosa plated with chutney or side accompaniments, Indian breakfast photography',
  true, true, false, false,
  false, 1, NULL,
  'complete', true, 'south', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('semolina') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'semolina', _ingredient_id,
  220, 'g', NULL,
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('rice flour') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'rice flour', _ingredient_id,
  320, 'g', NULL,
  false, 'main', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('onion') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'onion', _ingredient_id,
  180, 'g', 'finely chopped',
  false, 'base', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('green chili') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'green chili', _ingredient_id,
  2, 'piece', 'slit',
  false, 'aromatics', 3
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cumin seeds') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cumin seeds', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'tempering', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('salt') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'salt', _ingredient_id,
  5, 'g', NULL,
  false, 'seasoning', 5
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('water') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'water', _ingredient_id,
  500, 'ml', NULL,
  false, 'cooking liquid', 6
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('vegetable oil') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'vegetable oil', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 7
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Whisk semolina, rice flour, salt, and water into a very thin batter, then rest it for 10 minutes before adding onion, green chili, and cumin.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Pour the batter over a very hot tawa from a height so it forms an irregular lace with tiny holes.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Drizzle oil around the edges and cook until the underside turns deep golden and crisp.'
);

-- -----------------------------------------------------------------------
-- Recipe 70/215: Baby Corn Pepper Fry
-- -----------------------------------------------------------------------
INSERT INTO global_recipes (
  title, description, cuisine, cuisine_category, cuisine_region,
  meal_types, servings, prep_time_min, cook_time_min,
  difficulty, tags, cooking_style, dietary_tags,
  image_url, source_url, image_search_query,
  is_vegetarian, is_vegan, is_eggetarian, is_jain,
  is_batch_friendly, leftover_days, protein_category,
  dish_role, is_standalone, pairing_group, needs_roles
) VALUES (
  'Baby Corn Pepper Fry', 'Baby Corn Pepper Fry is a quick skillet dish with focused seasoning and lively texture. It is easy enough for a weeknight but still feels intentional on the plate.', 'continental', NULL, 'pepper-style',
  '{"lunch","dinner"}', 4, 10, 12,
  'easy', '{"weekday-friendly","quick","veg-side"}', '{"stir-fry","quick"}', '{}',
  '/images/recipes/baby-corn-pepper-fry.png', 'https://www.indianhealthyrecipes.com/aloo-gobi-recipe/', 'baby corn pepper fry in a serving bowl, appetizing plated food photography',
  true, true, false, false,
  false, 1, NULL,
  'side', false, 'continental', '{"main","staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('baby corn') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'baby corn', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('olive oil') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'olive oil', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('green chili') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'green chili', _ingredient_id,
  2, 'piece', 'slit',
  false, 'aromatics', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('black pepper') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'black pepper', _ingredient_id,
  1, 'teaspoon', 'coarsely crushed',
  false, 'spice mix', 3
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('salt') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'salt', _ingredient_id,
  5, 'g', NULL,
  false, 'seasoning', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('onion') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'onion', _ingredient_id,
  180, 'g', 'finely chopped',
  false, 'base', 5
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat oil in a wide skillet and bloom the tempering ingredients for 30 seconds. Add the base ingredients and cook for 4 to 5 minutes until lightly softened.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Add baby corn with the spice powders and salt. Toss well, then cook uncovered on medium heat until the vegetables or protein are just tender.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Finish with the last seasoning additions and toss quickly so the ingredients stay vibrant. Cook for 2 more minutes so the masala clings to the ingredients instead of pooling in the pan.'
);

-- -----------------------------------------------------------------------
-- Recipe 71/215: Pumpkin Curry
-- -----------------------------------------------------------------------
INSERT INTO global_recipes (
  title, description, cuisine, cuisine_category, cuisine_region,
  meal_types, servings, prep_time_min, cook_time_min,
  difficulty, tags, cooking_style, dietary_tags,
  image_url, source_url, image_search_query,
  is_vegetarian, is_vegan, is_eggetarian, is_jain,
  is_batch_friendly, leftover_days, protein_category,
  dish_role, is_standalone, pairing_group, needs_roles
) VALUES (
  'Pumpkin Curry', 'Pumpkin Curry features pumpkin cooked until flavorful yet distinct. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'south_indian', NULL, 'home-style',
  '{"lunch","dinner"}', 4, 15, 20,
  'medium', '{"homestyle","weekday-friendly","veg-side"}', '{"stir-fry"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2022/10/pumpkin-curry-recipe.jpg', 'https://www.indianhealthyrecipes.com/pumpkin-curry-recipe/', 'pumpkin curry in a serving bowl, appetizing plated food photography',
  true, true, false, false,
  true, 2, NULL,
  'main', false, 'south', '{"staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('pumpkin') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'pumpkin', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coconut oil') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coconut oil', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('onion') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'onion', _ingredient_id,
  180, 'g', 'finely chopped',
  false, 'base', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('ginger garlic paste') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'ginger garlic paste', _ingredient_id,
  1, 'tablespoon', NULL,
  false, 'aromatics', 3
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('green chili') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'green chili', _ingredient_id,
  2, 'piece', 'slit',
  false, 'aromatics', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('turmeric powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'turmeric powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 5
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('red chili powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'red chili powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 6
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coriander powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coriander powder', _ingredient_id,
  2, 'teaspoon', NULL,
  false, 'spice mix', 7
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('salt') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'salt', _ingredient_id,
  5, 'g', NULL,
  false, 'seasoning', 8
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coriander leaves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coriander leaves', _ingredient_id,
  15, 'g', 'chopped',
  false, 'finish', 9
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('mustard seeds') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'mustard seeds', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'tempering', 10
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('curry leaves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'curry leaves', _ingredient_id,
  10, 'g', NULL,
  false, 'tempering', 11
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coconut fresh') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coconut fresh', _ingredient_id,
  100, 'g', 'grated',
  false, 'main', 12
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat oil in a wide skillet and bloom the tempering ingredients for 30 seconds. Add the base ingredients and cook for 4 to 5 minutes until lightly softened.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Add pumpkin with the spice powders and salt. Toss well, then cook uncovered on medium heat until the vegetables or protein are just tender.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Finish with herbs and cook until the pan looks dry and glossy rather than wet. Cook for 2 more minutes so the masala clings to the ingredients instead of pooling in the pan.'
);

-- -----------------------------------------------------------------------
-- Recipe 72/215: Jackfruit Masala
-- -----------------------------------------------------------------------
INSERT INTO global_recipes (
  title, description, cuisine, cuisine_category, cuisine_region,
  meal_types, servings, prep_time_min, cook_time_min,
  difficulty, tags, cooking_style, dietary_tags,
  image_url, source_url, image_search_query,
  is_vegetarian, is_vegan, is_eggetarian, is_jain,
  is_batch_friendly, leftover_days, protein_category,
  dish_role, is_standalone, pairing_group, needs_roles
) VALUES (
  'Jackfruit Masala', 'Jackfruit Masala features jackfruit raw cooked until flavorful yet distinct. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'north_indian', NULL, 'rustic',
  '{"lunch","dinner"}', 4, 20, 25,
  'medium', '{"homestyle","weekday-friendly","veg-side"}', '{"stir-fry"}', '{}',
  'https://www.vegrecipesofindia.com/wp-content/uploads/2017/05/kathal-masala-recipe.jpg', 'https://www.vegrecipesofindia.com/kathal-masala-recipe-kathal-curry/', 'jackfruit masala in a serving bowl, appetizing plated food photography',
  true, true, false, false,
  true, 2, NULL,
  'main', false, 'north', '{"staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('jackfruit raw') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'jackfruit raw', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('vegetable oil') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'vegetable oil', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('onion') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'onion', _ingredient_id,
  180, 'g', 'finely chopped',
  false, 'base', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('ginger garlic paste') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'ginger garlic paste', _ingredient_id,
  1, 'tablespoon', NULL,
  false, 'aromatics', 3
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('green chili') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'green chili', _ingredient_id,
  2, 'piece', 'slit',
  false, 'aromatics', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('turmeric powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'turmeric powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 5
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('red chili powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'red chili powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 6
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coriander powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coriander powder', _ingredient_id,
  2, 'teaspoon', NULL,
  false, 'spice mix', 7
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('salt') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'salt', _ingredient_id,
  5, 'g', NULL,
  false, 'seasoning', 8
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coriander leaves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coriander leaves', _ingredient_id,
  15, 'g', 'chopped',
  false, 'finish', 9
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('tomato') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'tomato', _ingredient_id,
  180, 'g', 'finely chopped',
  false, 'base', 10
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('garam masala') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'garam masala', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 11
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat oil in a wide skillet and bloom the tempering ingredients for 30 seconds. Add the base ingredients and cook for 4 to 5 minutes until lightly softened.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Add jackfruit raw with the spice powders and salt. Toss well, then cook uncovered on medium heat until the vegetables or protein are just tender.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Finish with herbs and cook until the pan looks dry and glossy rather than wet. Cook for 2 more minutes so the masala clings to the ingredients instead of pooling in the pan.'
);

-- -----------------------------------------------------------------------
-- Recipe 73/215: Raw Banana Fry
-- -----------------------------------------------------------------------
INSERT INTO global_recipes (
  title, description, cuisine, cuisine_category, cuisine_region,
  meal_types, servings, prep_time_min, cook_time_min,
  difficulty, tags, cooking_style, dietary_tags,
  image_url, source_url, image_search_query,
  is_vegetarian, is_vegan, is_eggetarian, is_jain,
  is_batch_friendly, leftover_days, protein_category,
  dish_role, is_standalone, pairing_group, needs_roles
) VALUES (
  'Raw Banana Fry', 'Raw Banana Fry features raw banana cooked until flavorful yet distinct. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'kerala', NULL, 'side-dish',
  '{"lunch","dinner"}', 4, 15, 20,
  'medium', '{"homestyle","weekday-friendly","veg-side"}', '{"stir-fry"}', '{}',
  'https://www.vegrecipesofindia.com/wp-content/uploads/2016/06/raw-banana-fry-recipe.jpg', 'https://www.vegrecipesofindia.com/raw-banana-fry-recipe-vazhakkai-fry/', 'raw banana fry in a serving bowl, appetizing plated food photography',
  true, true, false, false,
  true, 2, NULL,
  'side', false, 'south', '{"main","staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('raw banana') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'raw banana', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coconut oil') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coconut oil', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('onion') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'onion', _ingredient_id,
  180, 'g', 'finely chopped',
  false, 'base', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('ginger garlic paste') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'ginger garlic paste', _ingredient_id,
  1, 'tablespoon', NULL,
  false, 'aromatics', 3
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('green chili') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'green chili', _ingredient_id,
  2, 'piece', 'slit',
  false, 'aromatics', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('turmeric powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'turmeric powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 5
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('red chili powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'red chili powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 6
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coriander powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coriander powder', _ingredient_id,
  2, 'teaspoon', NULL,
  false, 'spice mix', 7
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('salt') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'salt', _ingredient_id,
  5, 'g', NULL,
  false, 'seasoning', 8
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coriander leaves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coriander leaves', _ingredient_id,
  15, 'g', 'chopped',
  false, 'finish', 9
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('mustard seeds') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'mustard seeds', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'tempering', 10
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('curry leaves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'curry leaves', _ingredient_id,
  10, 'g', NULL,
  false, 'tempering', 11
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat oil in a wide skillet and bloom the tempering ingredients for 30 seconds. Add the base ingredients and cook for 4 to 5 minutes until lightly softened.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Add raw banana with the spice powders and salt. Toss well, then cook uncovered on medium heat until the vegetables or protein are just tender.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Finish with herbs and cook until the pan looks dry and glossy rather than wet. Cook for 2 more minutes so the masala clings to the ingredients instead of pooling in the pan.'
);

-- -----------------------------------------------------------------------
-- Recipe 74/215: Yam Roast
-- -----------------------------------------------------------------------
INSERT INTO global_recipes (
  title, description, cuisine, cuisine_category, cuisine_region,
  meal_types, servings, prep_time_min, cook_time_min,
  difficulty, tags, cooking_style, dietary_tags,
  image_url, source_url, image_search_query,
  is_vegetarian, is_vegan, is_eggetarian, is_jain,
  is_batch_friendly, leftover_days, protein_category,
  dish_role, is_standalone, pairing_group, needs_roles
) VALUES (
  'Yam Roast', 'Yam Roast features yam cooked until flavorful yet distinct. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'south_indian', NULL, 'dry roast',
  '{"lunch","dinner"}', 4, 15, 20,
  'medium', '{"homestyle","weekday-friendly","veg-side"}', '{"stir-fry"}', '{}',
  'https://images.archanaskitchen.com/images/recipes/indian/main-course/south-indian-vegetarian-recipes/poriyal-recipes-south-indian-sabzi/Kalyana_Veetu_Senai_Curry_Recipe_South_Indian_Style_Roasted_Yam_1_c7e9e8030f.jpg', 'https://www.archanaskitchen.com/recipe/kalyana-veetu-senai-curry-recipe-south-indian-style-roasted-yam', 'yam roast in a serving bowl, appetizing plated food photography',
  true, true, false, false,
  true, 2, NULL,
  'side', false, 'south', '{"main","staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('yam') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'yam', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coconut oil') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coconut oil', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('onion') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'onion', _ingredient_id,
  180, 'g', 'finely chopped',
  false, 'base', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('ginger garlic paste') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'ginger garlic paste', _ingredient_id,
  1, 'tablespoon', NULL,
  false, 'aromatics', 3
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('green chili') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'green chili', _ingredient_id,
  2, 'piece', 'slit',
  false, 'aromatics', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('turmeric powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'turmeric powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 5
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('red chili powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'red chili powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 6
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coriander powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coriander powder', _ingredient_id,
  2, 'teaspoon', NULL,
  false, 'spice mix', 7
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('salt') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'salt', _ingredient_id,
  5, 'g', NULL,
  false, 'seasoning', 8
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coriander leaves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coriander leaves', _ingredient_id,
  15, 'g', 'chopped',
  false, 'finish', 9
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('mustard seeds') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'mustard seeds', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'tempering', 10
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('curry leaves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'curry leaves', _ingredient_id,
  10, 'g', NULL,
  false, 'tempering', 11
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat oil in a wide skillet and bloom the tempering ingredients for 30 seconds. Add the base ingredients and cook for 4 to 5 minutes until lightly softened.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Add yam with the spice powders and salt. Toss well, then cook uncovered on medium heat until the vegetables or protein are just tender.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Finish with herbs and cook until the pan looks dry and glossy rather than wet. Cook for 2 more minutes so the masala clings to the ingredients instead of pooling in the pan.'
);

-- -----------------------------------------------------------------------
-- Recipe 75/215: Ivy Gourd Stir Fry
-- -----------------------------------------------------------------------
INSERT INTO global_recipes (
  title, description, cuisine, cuisine_category, cuisine_region,
  meal_types, servings, prep_time_min, cook_time_min,
  difficulty, tags, cooking_style, dietary_tags,
  image_url, source_url, image_search_query,
  is_vegetarian, is_vegan, is_eggetarian, is_jain,
  is_batch_friendly, leftover_days, protein_category,
  dish_role, is_standalone, pairing_group, needs_roles
) VALUES (
  'Ivy Gourd Stir Fry', 'Ivy Gourd Stir Fry is a quick skillet dish with focused seasoning and lively texture. It is easy enough for a weeknight but still feels intentional on the plate.', 'south_indian', NULL, 'home-style',
  '{"lunch","dinner"}', 4, 10, 15,
  'easy', '{"weekday-friendly","quick","veg-side"}', '{"stir-fry","quick"}', '{}',
  'https://images.archanaskitchen.com/images/recipes/indian/main-course/north-indian-vegetarian-recipes/sabzi-recipes/Maharashtrian_Tindora_Sabzi_With_Peanuts_Recipe_1_59e81dfaba.jpg', 'https://www.archanaskitchen.com/recipe/maharashtrian-tendli-bhaji-recipe-with-peanuts-ivy-gourd-stir-fry-tindora-sabzi', 'ivy gourd stir fry in a serving bowl, appetizing plated food photography',
  true, true, false, false,
  false, 1, NULL,
  'side', false, 'south', '{"main","staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('ivy gourd') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'ivy gourd', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coconut oil') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coconut oil', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('green chili') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'green chili', _ingredient_id,
  2, 'piece', 'slit',
  false, 'aromatics', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('black pepper') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'black pepper', _ingredient_id,
  1, 'teaspoon', 'coarsely crushed',
  false, 'spice mix', 3
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('salt') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'salt', _ingredient_id,
  5, 'g', NULL,
  false, 'seasoning', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('mustard seeds') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'mustard seeds', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'tempering', 5
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('curry leaves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'curry leaves', _ingredient_id,
  10, 'g', NULL,
  false, 'tempering', 6
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat oil in a wide skillet and bloom the tempering ingredients for 30 seconds. Add the base ingredients and cook for 4 to 5 minutes until lightly softened.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Add ivy gourd with the spice powders and salt. Toss well, then cook uncovered on medium heat until the vegetables or protein are just tender.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Finish with the last seasoning additions and toss quickly so the ingredients stay vibrant. Cook for 2 more minutes so the masala clings to the ingredients instead of pooling in the pan.'
);

-- -----------------------------------------------------------------------
-- Recipe 76/215: Undhiyu
-- -----------------------------------------------------------------------
INSERT INTO global_recipes (
  title, description, cuisine, cuisine_category, cuisine_region,
  meal_types, servings, prep_time_min, cook_time_min,
  difficulty, tags, cooking_style, dietary_tags,
  image_url, source_url, image_search_query,
  is_vegetarian, is_vegan, is_eggetarian, is_jain,
  is_batch_friendly, leftover_days, protein_category,
  dish_role, is_standalone, pairing_group, needs_roles
) VALUES (
  'Undhiyu', 'Undhiyu is a Gujarati winter medley of vegetables and spiced herb masala cooked slowly until everything tastes deeply infused. It feels festive, earthy, and wonderfully abundant.', 'gujarati', NULL, 'winter-special',
  '{"lunch","dinner"}', 4, 30, 45,
  'hard', '{"homestyle","weekday-friendly","veg-side"}', '{"slow-cook","weekend-project"}', '{}',
  'https://www.vegrecipesofindia.com/wp-content/uploads/2015/04/undhiyu-recipe.jpg', 'https://www.vegrecipesofindia.com/undhiyu-recipe-gujarati-undhiyu-recipe/', 'undhiyu in a serving bowl, appetizing plated food photography',
  true, true, false, false,
  true, 2, NULL,
  'main', false, 'gujarati', '{"staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('raw banana') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'raw banana', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('sweet potato') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'sweet potato', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('green beans') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'green beans', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('brinjal') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'brinjal', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 3
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('vegetable oil') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'vegetable oil', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('onion') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'onion', _ingredient_id,
  180, 'g', 'finely chopped',
  false, 'base', 5
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('ginger garlic paste') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'ginger garlic paste', _ingredient_id,
  1, 'tablespoon', NULL,
  false, 'aromatics', 6
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('green chili') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'green chili', _ingredient_id,
  2, 'piece', 'slit',
  false, 'aromatics', 7
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('turmeric powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'turmeric powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 8
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('red chili powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'red chili powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 9
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coriander powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coriander powder', _ingredient_id,
  2, 'teaspoon', NULL,
  false, 'spice mix', 10
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('salt') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'salt', _ingredient_id,
  5, 'g', NULL,
  false, 'seasoning', 11
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coriander leaves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coriander leaves', _ingredient_id,
  15, 'g', 'chopped',
  false, 'finish', 12
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('methi leaves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'methi leaves', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 13
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coconut fresh') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coconut fresh', _ingredient_id,
  100, 'g', 'grated',
  false, 'main', 14
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('peanuts') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'peanuts', _ingredient_id,
  40, 'g', 'roasted',
  false, 'finish', 15
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('sesame seeds') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'sesame seeds', _ingredient_id,
  1, 'tablespoon', NULL,
  false, 'finish', 16
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('jaggery') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'jaggery', _ingredient_id,
  20, 'g', 'grated',
  false, 'sweetener', 17
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat oil in a wide skillet and bloom the tempering ingredients for 30 seconds. Add the base ingredients and cook for 4 to 5 minutes until lightly softened.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Add raw banana and sweet potato and green beans and brinjal with the spice powders and salt. Toss well, then cook uncovered on medium heat until the vegetables or protein are just tender.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Finish with herbs and cook until the pan looks dry and glossy rather than wet. Cook for 2 more minutes so the masala clings to the ingredients instead of pooling in the pan.'
);

-- -----------------------------------------------------------------------
-- Recipe 77/215: Drumstick Curry
-- -----------------------------------------------------------------------
INSERT INTO global_recipes (
  title, description, cuisine, cuisine_category, cuisine_region,
  meal_types, servings, prep_time_min, cook_time_min,
  difficulty, tags, cooking_style, dietary_tags,
  image_url, source_url, image_search_query,
  is_vegetarian, is_vegan, is_eggetarian, is_jain,
  is_batch_friendly, leftover_days, protein_category,
  dish_role, is_standalone, pairing_group, needs_roles
) VALUES (
  'Drumstick Curry', 'Drumstick Curry features drumstick cooked until flavorful yet distinct. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'south_indian', NULL, 'home-style',
  '{"lunch","dinner"}', 4, 15, 25,
  'medium', '{"homestyle","weekday-friendly","veg-side"}', '{"stir-fry"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2022/09/drumstick-curry-recipe.jpg', 'https://www.indianhealthyrecipes.com/drumstick-curry/', 'drumstick curry in a serving bowl, appetizing plated food photography',
  true, true, false, false,
  true, 2, NULL,
  'main', false, 'south', '{"staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('drumstick') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'drumstick', _ingredient_id,
  2, 'piece', 'cut into pieces',
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coconut oil') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coconut oil', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('onion') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'onion', _ingredient_id,
  180, 'g', 'finely chopped',
  false, 'base', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('ginger garlic paste') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'ginger garlic paste', _ingredient_id,
  1, 'tablespoon', NULL,
  false, 'aromatics', 3
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('green chili') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'green chili', _ingredient_id,
  2, 'piece', 'slit',
  false, 'aromatics', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('turmeric powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'turmeric powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 5
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('red chili powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'red chili powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 6
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coriander powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coriander powder', _ingredient_id,
  2, 'teaspoon', NULL,
  false, 'spice mix', 7
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('salt') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'salt', _ingredient_id,
  5, 'g', NULL,
  false, 'seasoning', 8
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coriander leaves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coriander leaves', _ingredient_id,
  15, 'g', 'chopped',
  false, 'finish', 9
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('tomato') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'tomato', _ingredient_id,
  180, 'g', 'finely chopped',
  false, 'base', 10
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('tamarind paste') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'tamarind paste', _ingredient_id,
  1, 'tablespoon', NULL,
  false, 'souring', 11
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('curry leaves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'curry leaves', _ingredient_id,
  10, 'g', NULL,
  false, 'tempering', 12
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat oil in a wide skillet and bloom the tempering ingredients for 30 seconds. Add the base ingredients and cook for 4 to 5 minutes until lightly softened.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Add drumstick with the spice powders and salt. Toss well, then cook uncovered on medium heat until the vegetables or protein are just tender.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Finish with herbs and cook until the pan looks dry and glossy rather than wet. Cook for 2 more minutes so the masala clings to the ingredients instead of pooling in the pan.'
);

-- -----------------------------------------------------------------------
-- Recipe 78/215: Banana Stem Poriyal
-- -----------------------------------------------------------------------
INSERT INTO global_recipes (
  title, description, cuisine, cuisine_category, cuisine_region,
  meal_types, servings, prep_time_min, cook_time_min,
  difficulty, tags, cooking_style, dietary_tags,
  image_url, source_url, image_search_query,
  is_vegetarian, is_vegan, is_eggetarian, is_jain,
  is_batch_friendly, leftover_days, protein_category,
  dish_role, is_standalone, pairing_group, needs_roles
) VALUES (
  'Banana Stem Poriyal', 'Banana Stem Poriyal is a quick skillet dish with focused seasoning and lively texture. It is easy enough for a weeknight but still feels intentional on the plate.', 'tamil', NULL, 'home-style',
  '{"lunch","dinner"}', 4, 10, 15,
  'easy', '{"weekday-friendly","quick","veg-side"}', '{"stir-fry","quick"}', '{}',
  'https://images.archanaskitchen.com/images/recipes/indian/main-course/south-indian-vegetarian-recipes/poriyal-recipes-south-indian-sabzi/Tamil_Nadu_Style_Vazha_Thandu_Poriyal_Recipe_Dry_Banana_Stem_Fry_Recipe_b5fe07658b.jpg', 'https://www.archanaskitchen.com/recipe/tamil-nadu-style-vazha-thandu-poriyal-recipe-dry-banana-stem-fry-recipe', 'banana stem poriyal in a serving bowl, appetizing plated food photography',
  true, true, false, false,
  false, 1, NULL,
  'side', false, 'south', '{"main","staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('banana stem') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'banana stem', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coconut oil') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coconut oil', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('green chili') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'green chili', _ingredient_id,
  2, 'piece', 'slit',
  false, 'aromatics', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('black pepper') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'black pepper', _ingredient_id,
  1, 'teaspoon', 'coarsely crushed',
  false, 'spice mix', 3
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('salt') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'salt', _ingredient_id,
  5, 'g', NULL,
  false, 'seasoning', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('mustard seeds') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'mustard seeds', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'tempering', 5
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('curry leaves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'curry leaves', _ingredient_id,
  10, 'g', NULL,
  false, 'tempering', 6
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coconut fresh') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coconut fresh', _ingredient_id,
  100, 'g', 'grated',
  false, 'main', 7
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat oil in a wide skillet and bloom the tempering ingredients for 30 seconds. Add the base ingredients and cook for 4 to 5 minutes until lightly softened.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Add banana stem with the spice powders and salt. Toss well, then cook uncovered on medium heat until the vegetables or protein are just tender.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Finish with the last seasoning additions and toss quickly so the ingredients stay vibrant. Cook for 2 more minutes so the masala clings to the ingredients instead of pooling in the pan.'
);

-- -----------------------------------------------------------------------
-- Recipe 79/215: Banana Flower Stir Fry
-- -----------------------------------------------------------------------
INSERT INTO global_recipes (
  title, description, cuisine, cuisine_category, cuisine_region,
  meal_types, servings, prep_time_min, cook_time_min,
  difficulty, tags, cooking_style, dietary_tags,
  image_url, source_url, image_search_query,
  is_vegetarian, is_vegan, is_eggetarian, is_jain,
  is_batch_friendly, leftover_days, protein_category,
  dish_role, is_standalone, pairing_group, needs_roles
) VALUES (
  'Banana Flower Stir Fry', 'Banana Flower Stir Fry features banana flower cooked until flavorful yet distinct. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'tamil', NULL, 'traditional',
  '{"lunch","dinner"}', 4, 20, 20,
  'medium', '{"homestyle","weekday-friendly","veg-side"}', '{"stir-fry"}', '{}',
  'https://images.archanaskitchen.com/images/recipes/indian/main-course/north-indian-vegetarian-recipes/sabzi-recipes/Maharashtrian_Style_Kelfulachi_Bhaji_Recipe_Banana_Floweret_Stir_Fry_Recipe_e0b0800596.jpg', 'https://www.archanaskitchen.com/recipe/maharashtrian-style-kelfulachi-bhaji-recipe-banana-floweret-stir-fry-recipe', 'banana flower stir fry in a serving bowl, appetizing plated food photography',
  true, true, false, false,
  true, 2, NULL,
  'side', false, 'south', '{"main","staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('banana flower') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'banana flower', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coconut oil') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coconut oil', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('onion') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'onion', _ingredient_id,
  180, 'g', 'finely chopped',
  false, 'base', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('ginger garlic paste') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'ginger garlic paste', _ingredient_id,
  1, 'tablespoon', NULL,
  false, 'aromatics', 3
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('green chili') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'green chili', _ingredient_id,
  2, 'piece', 'slit',
  false, 'aromatics', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('turmeric powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'turmeric powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 5
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('red chili powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'red chili powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 6
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coriander powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coriander powder', _ingredient_id,
  2, 'teaspoon', NULL,
  false, 'spice mix', 7
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('salt') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'salt', _ingredient_id,
  5, 'g', NULL,
  false, 'seasoning', 8
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coriander leaves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coriander leaves', _ingredient_id,
  15, 'g', 'chopped',
  false, 'finish', 9
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('mustard seeds') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'mustard seeds', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'tempering', 10
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('curry leaves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'curry leaves', _ingredient_id,
  10, 'g', NULL,
  false, 'tempering', 11
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coconut fresh') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coconut fresh', _ingredient_id,
  100, 'g', 'grated',
  false, 'main', 12
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat oil in a wide skillet and bloom the tempering ingredients for 30 seconds. Add the base ingredients and cook for 4 to 5 minutes until lightly softened.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Add banana flower with the spice powders and salt. Toss well, then cook uncovered on medium heat until the vegetables or protein are just tender.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Finish with herbs and cook until the pan looks dry and glossy rather than wet. Cook for 2 more minutes so the masala clings to the ingredients instead of pooling in the pan.'
);

-- -----------------------------------------------------------------------
-- Recipe 80/215: Paneer Tikka
-- -----------------------------------------------------------------------
INSERT INTO global_recipes (
  title, description, cuisine, cuisine_category, cuisine_region,
  meal_types, servings, prep_time_min, cook_time_min,
  difficulty, tags, cooking_style, dietary_tags,
  image_url, source_url, image_search_query,
  is_vegetarian, is_vegan, is_eggetarian, is_jain,
  is_batch_friendly, leftover_days, protein_category,
  dish_role, is_standalone, pairing_group, needs_roles
) VALUES (
  'Paneer Tikka', 'Paneer Tikka is a crowd-pleasing snack with crisp edges and punchy seasoning. It has the kind of bold flavor and texture that works well for sharing.', 'punjabi', NULL, 'tandoor-style',
  '{"snack","dinner"}', 4, 25, 35,
  'hard', '{"tea-time","crowd-pleaser","weekend-treat"}', '{"grill / tandoor","weekend-project"}', '{}',
  '/images/recipes/paneer-tikka.png', 'https://www.vegrecipesofindia.com/recipes/paneer/', 'paneer tikka in a serving bowl, appetizing plated food photography',
  true, false, false, true,
  false, 1, 'paneer',
  'complete', true, 'north', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('paneer') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'paneer', _ingredient_id,
  250, 'g', 'cubed',
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('curd') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'curd', _ingredient_id,
  120, 'g', 'whisked',
  false, 'main', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('capsicum') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'capsicum', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('tandoori masala') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'tandoori masala', _ingredient_id,
  2, 'teaspoon', NULL,
  false, 'spice mix', 3
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('lemon juice') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'lemon juice', _ingredient_id,
  1, 'tablespoon', NULL,
  false, 'finish', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('vegetable oil') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'vegetable oil', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 5
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('salt') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'salt', _ingredient_id,
  5, 'g', NULL,
  false, 'seasoning', 6
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Whisk curd, tandoori masala, lemon juice, oil, and salt into a thick marinade. Coat the paneer and capsicum, then rest them for 20 minutes.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Thread the marinated pieces onto skewers or arrange them on a lined tray with space between them.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Grill at high heat, turning once, until the edges char lightly and the marinade sets without drying the paneer.'
);

-- -----------------------------------------------------------------------
-- Recipe 81/215: Kheer
-- -----------------------------------------------------------------------
INSERT INTO global_recipes (
  title, description, cuisine, cuisine_category, cuisine_region,
  meal_types, servings, prep_time_min, cook_time_min,
  difficulty, tags, cooking_style, dietary_tags,
  image_url, source_url, image_search_query,
  is_vegetarian, is_vegan, is_eggetarian, is_jain,
  is_batch_friendly, leftover_days, protein_category,
  dish_role, is_standalone, pairing_group, needs_roles
) VALUES (
  'Kheer', 'Kheer is a classic sweet with slow-cooked milk and tender rice. Its texture and aroma make it feel special whether served warm or chilled.', 'north_indian', NULL, 'festive',
  '{"dessert","snack"}', 4, 15, 45,
  'hard', '{"festive","sweet","make-ahead"}', '{"slow-cook"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2022/06/kheer-recipe.jpg', 'https://www.indianhealthyrecipes.com/rice-kheer-recipe-chawal-ki-kheer/', 'kheer in a silver bowl garnished with nuts, close-up dessert photography',
  true, false, false, false,
  true, 3, NULL,
  'complete', true, 'north', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('milk') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'milk', _ingredient_id,
  750, 'ml', NULL,
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('basmati rice') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'basmati rice', _ingredient_id,
  320, 'g', 'washed',
  false, 'main', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('sugar') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'sugar', _ingredient_id,
  20, 'g', NULL,
  false, 'sweetener', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cardamom') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cardamom', _ingredient_id,
  1, 'piece', NULL,
  false, 'whole spices', 3
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('raisins') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'raisins', _ingredient_id,
  30, 'g', NULL,
  false, 'finish', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('almonds') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'almonds', _ingredient_id,
  30, 'g', 'slivered',
  false, 'finish', 5
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Rinse the rice and simmer it in milk on low heat, stirring often, until the grains turn soft and the milk reduces noticeably.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Add sugar, cardamom, and raisins, then continue cooking for 8 to 10 minutes until the kheer thickens enough to coat the spoon.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Finish with almonds and cool slightly before serving warm or chilled.'
);

-- -----------------------------------------------------------------------
-- Recipe 82/215: Vermicelli Kheer
-- -----------------------------------------------------------------------
INSERT INTO global_recipes (
  title, description, cuisine, cuisine_category, cuisine_region,
  meal_types, servings, prep_time_min, cook_time_min,
  difficulty, tags, cooking_style, dietary_tags,
  image_url, source_url, image_search_query,
  is_vegetarian, is_vegan, is_eggetarian, is_jain,
  is_batch_friendly, leftover_days, protein_category,
  dish_role, is_standalone, pairing_group, needs_roles
) VALUES (
  'Vermicelli Kheer', 'Vermicelli Kheer is a classic sweet with toasted vermicelli in creamy milk. Its texture and aroma make it feel special whether served warm or chilled.', 'south_indian', NULL, 'festive',
  '{"dessert","snack"}', 4, 10, 25,
  'medium', '{"festive","sweet","make-ahead"}', '{"slow-cook"}', '{}',
  'https://hebbarskitchen.com/wp-content/uploads/mainPhotos/seviyan-kheer-recipe-semiya-payasam-semiya-kheer-or-vermicelli-kheer-2.jpeg', 'https://hebbarskitchen.com/seviyan-kheer-recipe-semiya-payasam/', 'vermicelli kheer in a silver bowl garnished with nuts, close-up dessert photography',
  true, false, false, false,
  true, 3, NULL,
  'complete', true, 'south', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('milk') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'milk', _ingredient_id,
  750, 'ml', NULL,
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('vermicelli') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'vermicelli', _ingredient_id,
  220, 'g', NULL,
  false, 'main', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('sugar') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'sugar', _ingredient_id,
  20, 'g', NULL,
  false, 'sweetener', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cardamom') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cardamom', _ingredient_id,
  1, 'piece', NULL,
  false, 'whole spices', 3
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('raisins') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'raisins', _ingredient_id,
  30, 'g', NULL,
  false, 'finish', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cashews') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cashews', _ingredient_id,
  40, 'g', NULL,
  false, 'finish', 5
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Roast the vermicelli lightly until fragrant, then add it to simmering milk.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Cook on low heat until the vermicelli softens fully and the milk thickens slightly.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Stir in sugar, cardamom, and nuts, then cook for 2 more minutes before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 83/215: Fox Nut Kheer
-- -----------------------------------------------------------------------
INSERT INTO global_recipes (
  title, description, cuisine, cuisine_category, cuisine_region,
  meal_types, servings, prep_time_min, cook_time_min,
  difficulty, tags, cooking_style, dietary_tags,
  image_url, source_url, image_search_query,
  is_vegetarian, is_vegan, is_eggetarian, is_jain,
  is_batch_friendly, leftover_days, protein_category,
  dish_role, is_standalone, pairing_group, needs_roles
) VALUES (
  'Fox Nut Kheer', 'Fox Nut Kheer is a classic sweet with toasted fox nuts and creamy milk. Its texture and aroma make it feel special whether served warm or chilled.', 'north_indian', NULL, 'festive',
  '{"dessert","snack"}', 4, 10, 25,
  'medium', '{"festive","sweet","make-ahead"}', '{"slow-cook"}', '{}',
  'https://www.vegrecipesofindia.com/wp-content/uploads/2013/09/makhane-ki-kheer.jpg', 'https://www.vegrecipesofindia.com/makhane-ki-kheer/', 'fox nut kheer in a silver bowl garnished with nuts, close-up dessert photography',
  true, false, false, false,
  true, 3, NULL,
  'complete', true, 'north', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('milk') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'milk', _ingredient_id,
  750, 'ml', NULL,
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('fox nuts') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'fox nuts', _ingredient_id,
  80, 'g', 'lightly crushed',
  false, 'main', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('sugar') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'sugar', _ingredient_id,
  20, 'g', NULL,
  false, 'sweetener', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cardamom') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cardamom', _ingredient_id,
  1, 'piece', NULL,
  false, 'whole spices', 3
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('pistachios') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'pistachios', _ingredient_id,
  20, 'g', 'slivered',
  false, 'finish', 4
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Lightly toast the fox nuts in a dry pan, then crush half of them for texture and keep the rest whole.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Simmer them in milk on low heat for 15 to 18 minutes until the mixture thickens gently.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Add sugar and cardamom, then finish with pistachios before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 84/215: Gajar Ka Halwa
-- -----------------------------------------------------------------------
INSERT INTO global_recipes (
  title, description, cuisine, cuisine_category, cuisine_region,
  meal_types, servings, prep_time_min, cook_time_min,
  difficulty, tags, cooking_style, dietary_tags,
  image_url, source_url, image_search_query,
  is_vegetarian, is_vegan, is_eggetarian, is_jain,
  is_batch_friendly, leftover_days, protein_category,
  dish_role, is_standalone, pairing_group, needs_roles
) VALUES (
  'Gajar Ka Halwa', 'Gajar Ka Halwa is a classic sweet with slow-cooked carrots, milk, and khoya. Its texture and aroma make it feel special whether served warm or chilled.', 'north_indian', NULL, 'winter-special',
  '{"dessert","snack"}', 4, 20, 50,
  'hard', '{"festive","sweet","make-ahead"}', '{"slow-cook"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2021/07/carrot-halwa-gajar-halwa.jpg', 'https://www.indianhealthyrecipes.com/carrot-halwa-recipe-gajar-ka-halwa-recipe/', 'gajar ka halwa in a silver bowl garnished with nuts, close-up dessert photography',
  true, false, false, false,
  true, 3, NULL,
  'complete', true, 'north', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('carrot') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'carrot', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('milk') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'milk', _ingredient_id,
  750, 'ml', NULL,
  false, 'main', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('ghee') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'ghee', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('sugar') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'sugar', _ingredient_id,
  20, 'g', NULL,
  false, 'sweetener', 3
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('khoya') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'khoya', _ingredient_id,
  120, 'g', 'crumbled',
  false, 'main', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cardamom') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cardamom', _ingredient_id,
  1, 'piece', NULL,
  false, 'whole spices', 5
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cashews') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cashews', _ingredient_id,
  40, 'g', NULL,
  false, 'finish', 6
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Cook the grated carrot in milk on medium heat, stirring often, until the milk reduces almost completely and the carrot softens.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Add sugar and ghee, then continue cooking until the halwa turns glossy and leaves the sides of the pan.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Fold in khoya, cardamom, and nuts, then cook for 3 more minutes before serving warm.'
);

-- -----------------------------------------------------------------------
-- Recipe 85/215: Beetroot Halwa
-- -----------------------------------------------------------------------
INSERT INTO global_recipes (
  title, description, cuisine, cuisine_category, cuisine_region,
  meal_types, servings, prep_time_min, cook_time_min,
  difficulty, tags, cooking_style, dietary_tags,
  image_url, source_url, image_search_query,
  is_vegetarian, is_vegan, is_eggetarian, is_jain,
  is_batch_friendly, leftover_days, protein_category,
  dish_role, is_standalone, pairing_group, needs_roles
) VALUES (
  'Beetroot Halwa', 'Beetroot Halwa is a classic sweet with earthy sweetness and soft texture. Its texture and aroma make it feel special whether served warm or chilled.', 'south_indian', NULL, 'home-style',
  '{"dessert","snack"}', 4, 15, 35,
  'medium', '{"festive","sweet","make-ahead"}', '{"slow-cook"}', '{}',
  'https://images.archanaskitchen.com/images/recipes/indian/sweet-recipes/Beetroot_Halwa_Recipe_1_70e965d005.jpg', 'https://www.archanaskitchen.com/recipe/beetroot-halwa', 'beetroot halwa in a silver bowl garnished with nuts, close-up dessert photography',
  true, false, false, false,
  true, 3, NULL,
  'complete', true, 'south', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('beetroot') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'beetroot', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('milk') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'milk', _ingredient_id,
  750, 'ml', NULL,
  false, 'main', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('ghee') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'ghee', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('sugar') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'sugar', _ingredient_id,
  20, 'g', NULL,
  false, 'sweetener', 3
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cardamom') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cardamom', _ingredient_id,
  1, 'piece', NULL,
  false, 'whole spices', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cashews') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cashews', _ingredient_id,
  40, 'g', NULL,
  false, 'finish', 5
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Cook grated beetroot in a little ghee for 3 to 4 minutes so its raw smell fades.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Add milk and simmer until the beetroot softens and the mixture thickens noticeably.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Stir in sugar, cardamom, and nuts, then cook until glossy and spoonable.'
);

-- -----------------------------------------------------------------------
-- Recipe 86/215: Gulab Jamun
-- -----------------------------------------------------------------------
INSERT INTO global_recipes (
  title, description, cuisine, cuisine_category, cuisine_region,
  meal_types, servings, prep_time_min, cook_time_min,
  difficulty, tags, cooking_style, dietary_tags,
  image_url, source_url, image_search_query,
  is_vegetarian, is_vegan, is_eggetarian, is_jain,
  is_batch_friendly, leftover_days, protein_category,
  dish_role, is_standalone, pairing_group, needs_roles
) VALUES (
  'Gulab Jamun', 'Gulab Jamun is a classic sweet with soft syrup-soaked dumplings. Its texture and aroma make it feel special whether served warm or chilled.', 'north_indian', NULL, 'mithai-shop style',
  '{"dessert","snack"}', 4, 30, 40,
  'hard', '{"festive","sweet","make-ahead"}', '{"deep-fry","weekend-project"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2021/11/gulab-jamun.jpg', 'https://www.indianhealthyrecipes.com/gulab-jamun-recipe-using-milk-powder/', 'gulab jamun in a silver bowl garnished with nuts, close-up dessert photography',
  true, false, false, false,
  true, 3, NULL,
  'complete', true, 'north', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('khoya') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'khoya', _ingredient_id,
  120, 'g', 'crumbled',
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('paneer') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'paneer', _ingredient_id,
  250, 'g', 'cubed',
  false, 'main', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('maida') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'maida', _ingredient_id,
  220, 'g', NULL,
  false, 'main', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('baking powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'baking powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'batter', 3
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('sugar') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'sugar', _ingredient_id,
  20, 'g', NULL,
  false, 'sweetener', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cardamom') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cardamom', _ingredient_id,
  1, 'piece', NULL,
  false, 'whole spices', 5
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('rose water') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'rose water', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'finish', 6
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('vegetable oil') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'vegetable oil', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 7
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Make a soft dough with khoya, paneer, maida, and baking powder, then shape smooth crack-free balls.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Fry the balls on low heat until they turn evenly deep golden brown, taking care not to rush the coloring.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Simmer sugar, water, cardamom, and rose water into a light syrup, then soak the warm jamuns in it for at least 1 hour.'
);

-- -----------------------------------------------------------------------

END $$;
