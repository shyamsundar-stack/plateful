-- Part B: Recipes 55-108 of 215
-- Run AFTER 018a

DO $$
DECLARE
  _recipe_id UUID;
  _ingredient_id UUID;
BEGIN
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
-- Recipe 87/215: Rasgulla
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
  'Rasgulla', 'Rasgulla is a classic sweet with spongy chenna dumplings in light syrup. Its texture and aroma make it feel special whether served warm or chilled.', 'bengali', NULL, 'kolkata-style',
  '{"dessert","snack"}', 4, 35, 45,
  'hard', '{"festive","sweet","make-ahead"}', '{"slow-cook"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2014/09/rasgulla-recipe-1.jpg', 'https://www.indianhealthyrecipes.com/rasgulla-recipe-bengali-rasgulla-recipe-easy-diwali-sweet-recipe/', 'rasgulla in a silver bowl garnished with nuts, close-up dessert photography',
  true, false, false, false,
  true, 3, NULL,
  'complete', true, 'bengali', '{}'
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('lemon juice') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'lemon juice', _ingredient_id,
  1, 'tablespoon', NULL,
  false, 'finish', 1
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('rose water') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'rose water', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'finish', 3
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('water') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'water', _ingredient_id,
  500, 'ml', NULL,
  false, 'cooking liquid', 4
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Boil the milk, curdle it with lemon juice, and strain the chenna. Rinse it briefly, then knead until smooth and slightly glossy.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Shape small balls without cracks and keep them covered so they do not dry out.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Cook the balls in rapidly boiling sugar syrup until they puff up and turn springy, then cool them in the syrup before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 88/215: Ras Malai
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
  'Ras Malai', 'Ras Malai is a classic sweet with soft chenna patties in saffron milk. Its texture and aroma make it feel special whether served warm or chilled.', 'bengali', NULL, 'festive',
  '{"dessert","snack"}', 4, 35, 45,
  'hard', '{"festive","sweet","make-ahead"}', '{"slow-cook"}', '{}',
  'https://www.vegrecipesofindia.com/wp-content/uploads/2015/01/rasmalai-recipe-bengali.jpg', 'https://www.vegrecipesofindia.com/rasmalai-recipe/', 'ras malai in a silver bowl garnished with nuts, close-up dessert photography',
  true, false, false, false,
  true, 3, NULL,
  'complete', true, 'bengali', '{}'
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('saffron') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'saffron', _ingredient_id,
  0.5, 'teaspoon', NULL,
  false, 'finish', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('pistachios') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'pistachios', _ingredient_id,
  20, 'g', 'slivered',
  false, 'finish', 5
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Knead paneer until smooth, shape it into flat discs, and cook them in light sugar syrup until puffed and tender.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'In a separate pan, reduce milk with sugar, saffron, and cardamom until lightly thickened.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Squeeze the syrup gently from the cooked discs, transfer them to the saffron milk, and chill before garnishing with pistachios.'
);

-- -----------------------------------------------------------------------
-- Recipe 89/215: Coconut Ladoo
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
  'Coconut Ladoo', 'Coconut Ladoo is a classic sweet with soft coconut sweetness. Its texture and aroma make it feel special whether served warm or chilled.', 'south_indian', NULL, 'festive',
  '{"dessert","snack"}', 4, 10, 15,
  'easy', '{"festive","sweet","make-ahead"}', '{"slow-cook"}', '{}',
  'https://www.vegrecipesofindia.com/wp-content/uploads/2022/05/coconut-ladoo-nariyal-laddu-1.jpg', 'https://www.vegrecipesofindia.com/coconut-ladoo-recipe-with-condensed-milk/', 'coconut ladoo in a silver bowl garnished with nuts, close-up dessert photography',
  true, false, false, false,
  true, 3, NULL,
  'complete', true, 'south', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coconut fresh') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coconut fresh', _ingredient_id,
  100, 'g', 'grated',
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('condensed milk') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'condensed milk', _ingredient_id,
  100, 'g', NULL,
  false, 'sweetener', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cardamom') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cardamom', _ingredient_id,
  1, 'piece', NULL,
  false, 'whole spices', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('dry coconut') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'dry coconut', _ingredient_id,
  40, 'g', 'grated',
  false, 'finish', 3
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Cook coconut fresh and condensed milk together on low heat until the mixture thickens and starts leaving the sides of the pan.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Stir in cardamom and cool the mixture until warm enough to handle.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Shape into small balls and roll them in dry coconut before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 90/215: Besan Ladoo
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
  'Besan Ladoo', 'Besan Ladoo is a classic sweet with deeply roasted gram flour aroma. Its texture and aroma make it feel special whether served warm or chilled.', 'north_indian', NULL, 'festive',
  '{"dessert","snack"}', 4, 15, 20,
  'medium', '{"festive","sweet","make-ahead"}', '{"slow-cook"}', '{}',
  'https://www.vegrecipesofindia.com/wp-content/uploads/2017/04/besan-recipes.jpg', 'https://www.vegrecipesofindia.com/besan-recipes/', 'besan ladoo in a silver bowl garnished with nuts, close-up dessert photography',
  true, false, false, false,
  true, 3, NULL,
  'complete', true, 'north', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('besan') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'besan', _ingredient_id,
  220, 'g', NULL,
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('ghee') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'ghee', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 1
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cashews') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cashews', _ingredient_id,
  40, 'g', NULL,
  false, 'finish', 4
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Roast the besan slowly in ghee over low heat until it turns aromatic, loose, and a shade darker.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Take the pan off the heat and let the mixture cool until warm, then stir in sugar, cardamom, and chopped nuts.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Shape into tight ladoos while the mixture is still pliable.'
);

-- -----------------------------------------------------------------------
-- Recipe 91/215: Moong Dal Halwa
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
  'Moong Dal Halwa', 'Moong Dal Halwa is a classic sweet with rich roasted dal and ghee. Its texture and aroma make it feel special whether served warm or chilled.', 'north_indian', NULL, 'wedding-style',
  '{"dessert","snack"}', 4, 25, 45,
  'hard', '{"festive","sweet","make-ahead"}', '{"slow-cook"}', '{}',
  'https://img-cdn.publive.online/fit-in/1200x675/sanjeev-kapoor/media/media_files/2025/02/01/Ka824PjCqJdlhbmdxSsc.jpeg', 'https://www.sanjeevkapoor.com/Articles/how-to-use-moong-whole-split-with-skin-and-split-skinless-for-maximum-benefits-8680314', 'moong dal halwa in a silver bowl garnished with nuts, close-up dessert photography',
  true, false, false, false,
  true, 3, NULL,
  'complete', true, 'north', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('moong dal') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'moong dal', _ingredient_id,
  220, 'g', 'washed',
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('ghee') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'ghee', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('milk') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'milk', _ingredient_id,
  750, 'ml', NULL,
  false, 'main', 2
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
  _recipe_id, 1, 'Soak the moong dal, grind it coarsely, then roast it patiently in ghee until the mixture smells nutty and turns deep golden.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Heat milk and sugar separately, then add it carefully to the roasted dal and stir until fully absorbed.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Cook until the halwa turns glossy and grainy, then finish with cardamom and almonds.'
);

-- -----------------------------------------------------------------------
-- Recipe 92/215: Shrikhand
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
  'Shrikhand', 'Shrikhand is a classic sweet with thick hung curd and saffron. Its texture and aroma make it feel special whether served warm or chilled.', 'maharashtrian', NULL, 'festive',
  '{"dessert","snack"}', 4, 15, 0,
  'easy', '{"festive","sweet","make-ahead"}', '{"no-cook"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2021/11/shrikhand.jpg', 'https://www.indianhealthyrecipes.com/shrikhand-recipe/', 'shrikhand in a silver bowl garnished with nuts, close-up dessert photography',
  true, false, false, false,
  true, 3, NULL,
  'complete', true, 'maharashtrian', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('curd') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'curd', _ingredient_id,
  120, 'g', 'whisked',
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('sugar') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'sugar', _ingredient_id,
  20, 'g', NULL,
  false, 'sweetener', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cardamom') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cardamom', _ingredient_id,
  1, 'piece', NULL,
  false, 'whole spices', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('saffron') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'saffron', _ingredient_id,
  0.5, 'teaspoon', NULL,
  false, 'finish', 3
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
  _recipe_id, 1, 'Hang the curd until thick, then whisk it until completely smooth and creamy.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Add sugar, cardamom, and saffron, whisking until the sugar dissolves fully.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Chill well and garnish with pistachios before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 93/215: Phirni
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
  'Phirni', 'Phirni is a classic sweet with ground rice pudding with saffron. Its texture and aroma make it feel special whether served warm or chilled.', 'north_indian', NULL, 'mughlai',
  '{"dessert","snack"}', 4, 15, 30,
  'medium', '{"festive","sweet","make-ahead"}', '{"slow-cook"}', '{}',
  'https://www.vegrecipesofindia.com/wp-content/uploads/2021/08/phirni-1.jpg', 'https://www.vegrecipesofindia.com/phirni-recipe-punjabi-phirni-recipe/', 'phirni in a silver bowl garnished with nuts, close-up dessert photography',
  true, false, false, false,
  true, 3, NULL,
  'complete', true, 'north', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('basmati rice') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'basmati rice', _ingredient_id,
  320, 'g', 'washed',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('saffron') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'saffron', _ingredient_id,
  0.5, 'teaspoon', NULL,
  false, 'finish', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('pistachios') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'pistachios', _ingredient_id,
  20, 'g', 'slivered',
  false, 'finish', 5
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Soak the rice briefly, then grind it to a coarse paste.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Simmer milk on low heat, stir in the ground rice, and cook until the mixture thickens to a pudding-like consistency.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Add sugar, cardamom, and saffron, then chill in individual bowls before garnishing with pistachios.'
);

-- -----------------------------------------------------------------------
-- Recipe 94/215: Sandesh
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
  'Sandesh', 'Sandesh is a classic sweet with soft chenna sweet with delicate texture. Its texture and aroma make it feel special whether served warm or chilled.', 'bengali', NULL, 'sweet-shop style',
  '{"dessert","snack"}', 4, 20, 20,
  'medium', '{"festive","sweet","make-ahead"}', '{"slow-cook"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2019/10/sandesh-sweet.jpg', 'https://www.indianhealthyrecipes.com/sandesh/', 'sandesh in a silver bowl garnished with nuts, close-up dessert photography',
  true, false, false, false,
  true, 3, NULL,
  'complete', true, 'bengali', '{}'
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('sugar') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'sugar', _ingredient_id,
  20, 'g', NULL,
  false, 'sweetener', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cardamom') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cardamom', _ingredient_id,
  1, 'piece', NULL,
  false, 'whole spices', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('pistachios') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'pistachios', _ingredient_id,
  20, 'g', 'slivered',
  false, 'finish', 3
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Knead the fresh paneer until smooth and lump-free.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Cook it gently with sugar over low heat for a few minutes until the mixture thickens but does not dry out.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Cool slightly, shape into rounds or diamonds, and finish with cardamom and pistachios.'
);

-- -----------------------------------------------------------------------
-- Recipe 95/215: Rava Kesari
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
  'Rava Kesari', 'Rava Kesari is a classic sweet with soft semolina halwa with saffron. Its texture and aroma make it feel special whether served warm or chilled.', 'south_indian', NULL, 'temple-style',
  '{"dessert","snack"}', 4, 10, 15,
  'easy', '{"festive","sweet","make-ahead"}', '{"slow-cook"}', '{}',
  'https://www.vegrecipesofindia.com/wp-content/uploads/2021/06/kesari-recipe.jpg', 'https://www.vegrecipesofindia.com/rava-kesari-recipe/', 'rava kesari in a silver bowl garnished with nuts, close-up dessert photography',
  true, false, false, false,
  true, 3, NULL,
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('ghee') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'ghee', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 1
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('saffron') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'saffron', _ingredient_id,
  0.5, 'teaspoon', NULL,
  false, 'finish', 3
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cashews') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cashews', _ingredient_id,
  40, 'g', NULL,
  false, 'finish', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('raisins') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'raisins', _ingredient_id,
  30, 'g', NULL,
  false, 'finish', 5
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Roast the semolina lightly in ghee until aromatic and loose.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Bring water, saffron, and sugar to a boil, then whisk in the roasted semolina so no lumps form.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Cook until thick and glossy, then finish with fried cashews and raisins.'
);

-- -----------------------------------------------------------------------
-- Recipe 96/215: Pineapple Kesari
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
  'Pineapple Kesari', 'Pineapple Kesari is a classic sweet with fruity semolina halwa. Its texture and aroma make it feel special whether served warm or chilled.', 'south_indian', NULL, 'festive',
  '{"dessert","snack"}', 4, 10, 18,
  'easy', '{"festive","sweet","make-ahead"}', '{"slow-cook"}', '{}',
  'https://www.vegrecipesofindia.com/wp-content/uploads/2015/01/pineapple-kesari-recipe.jpg', 'https://www.vegrecipesofindia.com/pineapple-kesari-recipe/', 'pineapple kesari in a silver bowl garnished with nuts, close-up dessert photography',
  true, false, false, false,
  true, 3, NULL,
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('pineapple') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'pineapple', _ingredient_id,
  220, 'g', 'chopped',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cashews') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cashews', _ingredient_id,
  40, 'g', NULL,
  false, 'finish', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('raisins') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'raisins', _ingredient_id,
  30, 'g', NULL,
  false, 'finish', 5
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Cook the pineapple briefly with a little sugar until it softens and smells sweet.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Roast the semolina in ghee, then add hot water and cook until the grains swell.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Fold in the pineapple mixture, remaining sugar, and nuts, then cook until the kesari turns glossy.'
);

-- -----------------------------------------------------------------------
-- Recipe 97/215: Lauki Halwa
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
  'Lauki Halwa', 'Lauki Halwa is a classic sweet with soft bottle gourd cooked down with milk. Its texture and aroma make it feel special whether served warm or chilled.', 'north_indian', NULL, 'home-style',
  '{"dessert","snack"}', 4, 15, 35,
  'medium', '{"festive","sweet","make-ahead"}', '{"slow-cook"}', '{}',
  '/images/recipes/lauki-halwa.png', 'https://www.vegrecipesofindia.com/lauki-recipes/', 'lauki halwa in a silver bowl garnished with nuts, close-up dessert photography',
  true, false, false, false,
  true, 3, NULL,
  'complete', true, 'north', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('bottle gourd') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'bottle gourd', _ingredient_id,
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
  _recipe_id, 1, 'Saute grated bottle gourd in a little ghee for 4 minutes so excess raw moisture starts to evaporate.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Add milk and cook until the bottle gourd softens and the mixture reduces noticeably.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Stir in sugar, khoya, and cardamom, then cook until thick and glossy before finishing with cashews.'
);

-- -----------------------------------------------------------------------
-- Recipe 98/215: Coconut Barfi
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
  'Coconut Barfi', 'Coconut Barfi is a classic sweet with set coconut fudge. Its texture and aroma make it feel special whether served warm or chilled.', 'south_indian', NULL, 'festive',
  '{"dessert","snack"}', 4, 20, 25,
  'medium', '{"festive","sweet","make-ahead"}', '{"slow-cook"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2022/07/coconut-burfi-coconut-barfi.jpg', 'https://www.indianhealthyrecipes.com/coconut-burfi-recipe-coconut-barfi/', 'coconut barfi in a silver bowl garnished with nuts, close-up dessert photography',
  true, false, false, false,
  true, 3, NULL,
  'complete', true, 'south', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coconut fresh') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coconut fresh', _ingredient_id,
  100, 'g', 'grated',
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('sugar') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'sugar', _ingredient_id,
  20, 'g', NULL,
  false, 'sweetener', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('milk') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'milk', _ingredient_id,
  750, 'ml', NULL,
  false, 'main', 2
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('ghee') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'ghee', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 4
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Cook coconut, milk, and sugar together on medium heat until the mixture thickens substantially.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Add cardamom and a little ghee, then keep stirring until the mixture gathers into a mass and leaves the sides of the pan.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Spread it into a greased tray, cool until set, and cut into squares.'
);

-- -----------------------------------------------------------------------
-- Recipe 99/215: Dates Ladoo
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
  'Dates Ladoo', 'Dates Ladoo is a classic sweet with natural sweetness from dates. Its texture and aroma make it feel special whether served warm or chilled.', 'continental', NULL, 'healthy sweet',
  '{"dessert","snack"}', 4, 10, 15,
  'easy', '{"festive","sweet","make-ahead"}', '{"slow-cook"}', '{}',
  'https://hebbarskitchen.com/wp-content/uploads/mainPhotos/dates-ladoo-recipe-khajur-laduu-recipe-dates-nuts-laddu-recipe-2.jpeg', 'https://hebbarskitchen.com/dates-ladoo-recipe-khajur-laduu-recipe/', 'dates ladoo in a silver bowl garnished with nuts, close-up dessert photography',
  true, false, false, false,
  true, 3, NULL,
  'complete', true, 'continental', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('dates') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'dates', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('almonds') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'almonds', _ingredient_id,
  30, 'g', 'slivered',
  false, 'finish', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cashews') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cashews', _ingredient_id,
  40, 'g', NULL,
  false, 'finish', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('pistachios') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'pistachios', _ingredient_id,
  20, 'g', 'slivered',
  false, 'finish', 3
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('ghee') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'ghee', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('dry coconut') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'dry coconut', _ingredient_id,
  40, 'g', 'grated',
  false, 'finish', 5
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Toast the nuts lightly and chop them so the final ladoos have bite.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Cook the dates with a little ghee just until soft and sticky, then fold in the nuts.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Cool until warm, shape into ladoos, and roll in dry coconut if desired.'
);

-- -----------------------------------------------------------------------
-- Recipe 100/215: Mango Shrikhand
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
  'Mango Shrikhand', 'Mango Shrikhand is a classic sweet with hung curd and sweet mango puree. Its texture and aroma make it feel special whether served warm or chilled.', 'maharashtrian', NULL, 'summer-special',
  '{"dessert","snack"}', 4, 15, 0,
  'easy', '{"festive","sweet","make-ahead"}', '{"no-cook"}', '{}',
  'https://hebbarskitchen.com/wp-content/uploads/2017/04/mango-shrikhand-recipe-amrakhand-recipe-aam-shrikhand-2.jpeg', 'https://hebbarskitchen.com/mango-shrikhand-recipe-amrakhand-recipe/', 'mango shrikhand in a silver bowl garnished with nuts, close-up dessert photography',
  true, false, false, false,
  true, 3, NULL,
  'complete', true, 'maharashtrian', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('curd') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'curd', _ingredient_id,
  120, 'g', 'whisked',
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('mango ripe') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'mango ripe', _ingredient_id,
  220, 'g', 'chopped',
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
  _recipe_id, 1, 'Whisk thick hung curd until smooth and creamy.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Fold in mango puree, sugar, and cardamom until evenly combined and silky.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Chill well and garnish with pistachios before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 101/215: Chicken Biryani
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
  'Chicken Biryani', 'Chicken Biryani layers fragrant basmati rice with spiced chicken and herbs for a deeply satisfying festive meal. It is aromatic, hearty, and built for sharing.', 'hyderabadi', NULL, 'dum-style',
  '{"lunch","dinner"}', 4, 30, 45,
  'hard', '{"one-pot","crowd-pleaser","meal-prep"}', '{"slow-cook","weekend-project"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2021/12/chicken-biryani-recipe.jpg', 'https://www.indianhealthyrecipes.com/chicken-biryani-recipe/', 'chicken biryani in a handi bowl garnished with herbs, overhead food photography',
  false, false, false, false,
  true, 2, 'chicken',
  'complete', true, 'south', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('basmati rice') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'basmati rice', _ingredient_id,
  320, 'g', 'washed',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('chicken thigh') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'chicken thigh', _ingredient_id,
  550, 'g', 'cut into pieces',
  false, 'main', 6
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('tomato') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'tomato', _ingredient_id,
  180, 'g', 'finely chopped',
  false, 'base', 7
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('curd') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'curd', _ingredient_id,
  120, 'g', 'whisked',
  false, 'main', 8
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('mint leaves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'mint leaves', _ingredient_id,
  15, 'g', 'chopped',
  false, 'finish', 9
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('biryani masala') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'biryani masala', _ingredient_id,
  2, 'teaspoon', NULL,
  false, 'spice mix', 11
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cinnamon') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cinnamon', _ingredient_id,
  1, 'piece', NULL,
  false, 'whole spices', 12
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cardamom') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cardamom', _ingredient_id,
  1, 'piece', NULL,
  false, 'whole spices', 13
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cloves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cloves', _ingredient_id,
  1, 'piece', NULL,
  false, 'whole spices', 14
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('bay leaf') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'bay leaf', _ingredient_id,
  1, 'piece', NULL,
  false, 'whole spices', 15
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Rinse the rice well, then soak it for 15 minutes while you prepare the masala base.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Saute the aromatics in fat, add the protein and spices, and cook for 3 to 4 minutes so the mixture becomes fragrant and lightly glossy.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Stir in the rice and measured water, bring the pot to a boil, then cover and cook on low heat until the grains are tender.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 4, 'Seal the pot if desired and steam on very low heat so the chicken stays juicy and the rice absorbs the aroma. Rest the rice off the heat for 10 minutes before fluffing gently.'
);

-- -----------------------------------------------------------------------
-- Recipe 102/215: Butter Chicken
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
  'Butter Chicken', 'Butter Chicken features juicy chicken and a buttery tomato gravy. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'punjabi', NULL, 'restaurant-style',
  '{"lunch","dinner"}', 4, 20, 30,
  'medium', '{"family-favorite","protein-rich","meal-prep"}', '{"one-pot"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2023/04/butter-chicken-recipe.jpg', 'https://www.indianhealthyrecipes.com/butter-chicken/', 'butter chicken in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  true, 2, 'chicken',
  'main', false, 'north', '{"staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('chicken thigh') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'chicken thigh', _ingredient_id,
  550, 'g', 'cut into pieces',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('butter') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'butter', _ingredient_id,
  25, 'g', NULL,
  false, 'cooking fat', 11
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('curd') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'curd', _ingredient_id,
  120, 'g', 'whisked',
  false, 'main', 13
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('kashmiri chili powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'kashmiri chili powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 14
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('kasuri methi') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'kasuri methi', _ingredient_id,
  1, 'teaspoon', 'crushed',
  false, 'finish', 15
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat oil in a heavy pan over medium heat. Add the aromatics and cook for 6 to 8 minutes until they soften and smell sweet.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Stir in the ground spices, then add the chicken. Cook for 3 to 4 minutes so the masala coats everything evenly and loses any raw edge.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Add water or other liquid as needed, cover, and simmer on medium heat until the main ingredient is cooked through and the gravy thickens.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 4, 'Finish with herbs or dairy as needed and simmer very gently so the chicken stays tender. Simmer for 2 more minutes, then rest the dish for 5 minutes before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 103/215: Chicken Curry
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
  'Chicken Curry', 'Chicken Curry features juicy chicken and a homestyle onion-tomato gravy. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'north_indian', NULL, 'home-style',
  '{"lunch","dinner"}', 4, 15, 35,
  'medium', '{"family-favorite","protein-rich","meal-prep"}', '{"one-pot"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2021/07/chicken-curry-recipe.jpg', 'https://www.indianhealthyrecipes.com/chicken-curry/', 'chicken curry in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  true, 2, 'chicken',
  'main', false, 'north', '{"staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('chicken thigh') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'chicken thigh', _ingredient_id,
  550, 'g', 'cut into pieces',
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

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat oil in a heavy pan over medium heat. Add the aromatics and cook for 6 to 8 minutes until they soften and smell sweet.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Stir in the ground spices, then add the chicken. Cook for 3 to 4 minutes so the masala coats everything evenly and loses any raw edge.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Add water or other liquid as needed, cover, and simmer on medium heat until the main ingredient is cooked through and the gravy thickens.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 4, 'Finish with herbs or dairy as needed and simmer very gently so the chicken stays tender. Simmer for 2 more minutes, then rest the dish for 5 minutes before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 104/215: Chicken Tikka Masala
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
  'Chicken Tikka Masala', 'Chicken Tikka Masala features juicy chicken and a charred chicken in creamy spiced sauce. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'punjabi', NULL, 'restaurant-style',
  '{"lunch","dinner"}', 4, 25, 30,
  'medium', '{"family-favorite","protein-rich","meal-prep"}', '{"one-pot"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2022/06/chicken-tikka-masala.jpg', 'https://www.indianhealthyrecipes.com/chicken-tikka-masala/', 'chicken tikka masala in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  true, 2, 'chicken',
  'main', false, 'north', '{"staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('chicken thigh') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'chicken thigh', _ingredient_id,
  550, 'g', 'cut into pieces',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('curd') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'curd', _ingredient_id,
  120, 'g', 'whisked',
  false, 'main', 11
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('tandoori masala') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'tandoori masala', _ingredient_id,
  2, 'teaspoon', NULL,
  false, 'spice mix', 13
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('butter') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'butter', _ingredient_id,
  25, 'g', NULL,
  false, 'cooking fat', 14
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('capsicum') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'capsicum', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 15
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat oil in a heavy pan over medium heat. Add the aromatics and cook for 6 to 8 minutes until they soften and smell sweet.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Stir in the ground spices, then add the chicken. Cook for 3 to 4 minutes so the masala coats everything evenly and loses any raw edge.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Add water or other liquid as needed, cover, and simmer on medium heat until the main ingredient is cooked through and the gravy thickens.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 4, 'Finish with herbs or dairy as needed and simmer very gently so the chicken stays tender. Simmer for 2 more minutes, then rest the dish for 5 minutes before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 105/215: Tandoori Chicken
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
  'Tandoori Chicken', 'Tandoori Chicken features juicy chicken and a smoky curd marinade and charred edges. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'punjabi', NULL, 'tandoor-style',
  '{"lunch","dinner"}', 4, 25, 40,
  'hard', '{"family-favorite","protein-rich","meal-prep"}', '{"grill / tandoor","weekend-project"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2021/12/tandoori-chicken-recipe.jpg', 'https://www.indianhealthyrecipes.com/tandoori-chicken-recipe/', 'tandoori chicken in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  true, 2, 'chicken',
  'main', false, 'north', '{"staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('chicken whole') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'chicken whole', _ingredient_id,
  1.2, 'kg', 'cut into portions',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('curd') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'curd', _ingredient_id,
  120, 'g', 'whisked',
  false, 'main', 11
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('tandoori masala') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'tandoori masala', _ingredient_id,
  2, 'teaspoon', NULL,
  false, 'spice mix', 12
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('lemon juice') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'lemon juice', _ingredient_id,
  1, 'tablespoon', NULL,
  false, 'finish', 13
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('kashmiri chili powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'kashmiri chili powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 14
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat oil in a heavy pan over medium heat. Add the aromatics and cook for 6 to 8 minutes until they soften and smell sweet.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Stir in the ground spices, then add the chicken. Cook for 3 to 4 minutes so the masala coats everything evenly and loses any raw edge.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Add water or other liquid as needed, cover, and simmer on medium heat until the main ingredient is cooked through and the gravy thickens.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 4, 'Rest the chicken for 5 minutes, then brush with a little butter or oil before serving. Simmer for 2 more minutes, then rest the dish for 5 minutes before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 106/215: Chicken Fried Rice
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
  'Chicken Fried Rice', 'Chicken Fried Rice is a fragrant rice dish with wok-tossed chicken, rice, and vegetables. It cooks into a complete meal that feels festive without being fussy.', 'indo_chinese', NULL, 'wok-style',
  '{"lunch","dinner"}', 4, 15, 12,
  'easy', '{"one-pot","crowd-pleaser","meal-prep"}', '{"quick","stir-fry"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2019/05/chicken-fried-rice.jpg', 'https://www.indianhealthyrecipes.com/chicken-fried-rice-recipe/', 'chicken fried rice in a handi bowl garnished with herbs, overhead food photography',
  false, false, false, false,
  true, 2, 'chicken',
  'complete', true, 'indo_chinese', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('basmati rice') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'basmati rice', _ingredient_id,
  320, 'g', 'washed',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('chicken breast') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'chicken breast', _ingredient_id,
  550, 'g', 'cut into pieces',
  false, 'main', 6
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('spring onion') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'spring onion', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 7
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('capsicum') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'capsicum', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 8
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('soy sauce') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'soy sauce', _ingredient_id,
  1, 'tablespoon', NULL,
  false, 'sauce', 9
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('vinegar') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'vinegar', _ingredient_id,
  1, 'tablespoon', NULL,
  false, 'sauce', 10
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('egg white') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'egg white', _ingredient_id,
  4, 'piece', NULL,
  false, 'main', 11
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Rinse the rice well, then soak it for 15 minutes while you prepare the masala base.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Saute the aromatics in fat, add the chicken, vegetables, and sauces, and cook for 3 to 4 minutes so the mixture becomes fragrant and lightly glossy.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Stir in the rice and measured water, bring the pot to a boil, then cover and cook on low heat until the grains are tender.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 4, 'Toss over high heat so the grains stay separate and lightly smoky. Rest the rice off the heat for 10 minutes before fluffing gently.'
);

-- -----------------------------------------------------------------------
-- Recipe 107/215: Chicken Manchurian
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
  'Chicken Manchurian', 'Chicken Manchurian is an Indo-Chinese favorite with crisp chicken and a glossy, savory-spicy sauce. It is bold, familiar, and especially good with fried rice.', 'indo_chinese', NULL, 'restaurant-style',
  '{"lunch","dinner"}', 4, 20, 20,
  'medium', '{"tea-time","crowd-pleaser","weekend-treat"}', '{"stir-fry"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2019/04/chicken-manchurian.jpg', 'https://www.indianhealthyrecipes.com/chicken-manchurian-recipe/', 'chicken manchurian in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  false, 1, 'chicken',
  'complete', true, 'indo_chinese', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('chicken breast') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'chicken breast', _ingredient_id,
  550, 'g', 'cut into pieces',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('garlic') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'garlic', _ingredient_id,
  20, 'g', 'minced',
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
  _recipe_id, 1, 'Coat the chicken with corn flour and salt, then fry or pan-sear until just cooked and lightly crisp at the edges.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'In a hot wok, cook garlic, green chili, and spring onion for 1 minute, then stir in soy sauce, vinegar, and tomato ketchup.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Add the chicken and toss over high heat until the sauce reduces and clings to each piece.'
);

-- -----------------------------------------------------------------------
-- Recipe 108/215: Chicken Korma
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
  'Chicken Korma', 'Chicken Korma features juicy chicken and a cashew-curd gravy scented with whole spices. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'mughlai', NULL, 'royal-style',
  '{"lunch","dinner"}', 4, 20, 35,
  'medium', '{"family-favorite","protein-rich","meal-prep"}', '{"one-pot"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2022/08/chicken-korma-recipe.jpg', 'https://www.indianhealthyrecipes.com/chicken-korma-recipe/', 'chicken korma in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  true, 2, 'chicken',
  'main', false, 'north', '{"staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('chicken thigh') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'chicken thigh', _ingredient_id,
  550, 'g', 'cut into pieces',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('curd') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'curd', _ingredient_id,
  120, 'g', 'whisked',
  false, 'main', 11
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cashews') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cashews', _ingredient_id,
  40, 'g', NULL,
  false, 'finish', 12
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cardamom') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cardamom', _ingredient_id,
  1, 'piece', NULL,
  false, 'whole spices', 14
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cinnamon') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cinnamon', _ingredient_id,
  1, 'piece', NULL,
  false, 'whole spices', 15
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cloves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cloves', _ingredient_id,
  1, 'piece', NULL,
  false, 'whole spices', 16
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat oil in a heavy pan over medium heat. Add the aromatics and cook for 6 to 8 minutes until they soften and smell sweet.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Stir in the ground spices, then add the chicken. Cook for 3 to 4 minutes so the masala coats everything evenly and loses any raw edge.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Add water or other liquid as needed, cover, and simmer on medium heat until the main ingredient is cooked through and the gravy thickens.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 4, 'Finish with herbs or dairy as needed and simmer very gently so the chicken stays tender. Simmer for 2 more minutes, then rest the dish for 5 minutes before serving.'
);

-- -----------------------------------------------------------------------
END $$;
