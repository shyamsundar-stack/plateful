-- Plateful seed part 5: recipes 173-215
-- Run AFTER part 4

DO $$
DECLARE
  _recipe_id UUID;
  _ingredient_id UUID;
BEGIN

-- Recipe 173/215: Surmai Curry
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
  'Surmai Curry', 'Surmai Curry features surmai in tangy coastal masala. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'maharashtrian', NULL, 'coastal-style',
  '{"lunch","dinner"}', 4, 15, 25,
  'medium', '{"seafood","family-favorite","meal-prep"}', '{"one-pot"}', '{}',
  'https://i0.wp.com/sanshreefoods.com/wp-content/uploads/2025/08/benefits-of-seer-fish.png', 'https://sanshreefoods.com/benefits-of-seer-fish/', 'surmai curry in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  true, 1, 'fish',
  'main', false, 'maharashtrian', '{"staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('surmai') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'surmai', _ingredient_id,
  600, 'g', 'cut into steaks',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('tamarind paste') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'tamarind paste', _ingredient_id,
  1, 'tablespoon', NULL,
  false, 'souring', 10
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

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat oil in a heavy pan over medium heat. Add the aromatics and cook for 6 to 8 minutes until they soften and smell sweet.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Stir in the ground spices, then add the surmai. Cook for 3 to 4 minutes so the masala coats everything evenly and loses any raw edge.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Add water or other liquid as needed, cover, and simmer on medium heat until the main ingredient is cooked through and the gravy thickens.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 4, 'Slide the fish pieces in at the end and cook only until they turn opaque and flaky. Simmer for 2 more minutes, then rest the dish for 5 minutes before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 174/215: Rohu Kalia
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
  'Rohu Kalia', 'Rohu Kalia features mustard oil and warm spices. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'bengali', NULL, 'celebration-style',
  '{"lunch","dinner"}', 4, 20, 30,
  'medium', '{"seafood","family-favorite","meal-prep"}', '{"one-pot"}', '{}',
  '/images/recipes/rohu-kalia.png', 'https://www.indianhealthyrecipes.com/fish-fry-recipe/', 'rohu kalia in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  true, 1, 'fish',
  'main', false, 'bengali', '{"staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('rohu') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'rohu', _ingredient_id,
  600, 'g', 'cut into steaks',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('potato') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'potato', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 10
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
  _recipe_id, 1, 'Heat oil in a heavy pan over medium heat. Add the aromatics and cook for 6 to 8 minutes until they soften and smell sweet.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Stir in the ground spices, then add the rohu. Cook for 3 to 4 minutes so the masala coats everything evenly and loses any raw edge.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Add water or other liquid as needed, cover, and simmer on medium heat until the main ingredient is cooked through and the gravy thickens.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 4, 'Slide the fish pieces in at the end and cook only until they turn opaque and flaky. Simmer for 2 more minutes, then rest the dish for 5 minutes before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 175/215: Rohu Mustard Curry
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
  'Rohu Mustard Curry', 'Rohu Mustard Curry features sharp mustard-style finish. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'bengali', NULL, 'mustard-style',
  '{"lunch","dinner"}', 4, 20, 25,
  'medium', '{"seafood","family-favorite","meal-prep"}', '{"one-pot"}', '{}',
  '/images/recipes/rohu-mustard-curry.png', 'https://www.indianhealthyrecipes.com/fish-fry-recipe/', 'rohu mustard curry in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  true, 1, 'fish',
  'main', false, 'bengali', '{"staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('rohu') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'rohu', _ingredient_id,
  600, 'g', 'cut into steaks',
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

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat oil in a heavy pan over medium heat. Add the aromatics and cook for 6 to 8 minutes until they soften and smell sweet.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Stir in the ground spices, then add the rohu. Cook for 3 to 4 minutes so the masala coats everything evenly and loses any raw edge.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Add water or other liquid as needed, cover, and simmer on medium heat until the main ingredient is cooked through and the gravy thickens.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 4, 'Slide the fish pieces in at the end and cook only until they turn opaque and flaky. Simmer for 2 more minutes, then rest the dish for 5 minutes before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 176/215: Fish Cutlet
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
  'Fish Cutlet', 'Fish Cutlet is a crowd-pleasing snack with crisp edges and punchy seasoning. It has the kind of bold flavor and texture that works well for sharing.', 'bengali', NULL, 'snack-shop style',
  '{"snack","dinner"}', 4, 20, 20,
  'medium', '{"tea-time","crowd-pleaser","weekend-treat"}', '{"deep-fry"}', '{}',
  '/images/recipes/fish-cutlet.png', 'https://www.indianhealthyrecipes.com/fish-fry-recipe/', 'fish cutlet in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  false, 1, 'fish',
  'complete', true, 'bengali', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('fish fillet') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'fish fillet', _ingredient_id,
  700, 'g', 'cut into pieces',
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('potato') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'potato', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('bread crumbs') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'bread crumbs', _ingredient_id,
  320, 'g', NULL,
  false, 'main', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('eggs') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'eggs', _ingredient_id,
  6, 'piece', NULL,
  false, 'main', 3
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('garam masala') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'garam masala', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 5
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
  _recipe_id, 1, 'Cook and flake the fish, then mix it with mashed potato, spices, green chili, and salt.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Shape into cutlets, dip in beaten egg, and coat thoroughly with bread crumbs.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Fry until crisp and evenly golden on both sides.'
);

-- -----------------------------------------------------------------------
-- Recipe 177/215: Prawn Masala
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
  'Prawn Masala', 'Prawn Masala features prawns in a rich masala coating. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'south_indian', NULL, 'coastal-style',
  '{"lunch","dinner"}', 4, 15, 25,
  'medium', '{"seafood","weekend-favorite","meal-prep"}', '{"stir-fry"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2015/07/prawn-biryani.jpg', 'https://www.indianhealthyrecipes.com/prawn-biryani-recipe-prawn-recipes/', 'prawn masala in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  true, 1, 'prawns',
  'main', false, 'south', '{"staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('prawns') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'prawns', _ingredient_id,
  500, 'g', 'cleaned and deveined',
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

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat oil in a heavy pan over medium heat. Add the aromatics and cook for 6 to 8 minutes until they soften and smell sweet.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Stir in the ground spices, then add the prawns. Cook for 3 to 4 minutes so the masala coats everything evenly and loses any raw edge.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Add water or other liquid as needed, cover, and simmer on medium heat until the main ingredient is cooked through and the gravy thickens.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 4, 'Cook only until the prawns curl and turn opaque, then take the pan off the heat immediately. Simmer for 2 more minutes, then rest the dish for 5 minutes before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 178/215: Prawn Curry Kerala
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
  'Prawn Curry Kerala', 'Prawn Curry Kerala features coconut milk curry with curry leaves. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'kerala', NULL, 'home-style',
  '{"lunch","dinner"}', 4, 15, 25,
  'medium', '{"seafood","weekend-favorite","meal-prep"}', '{"stir-fry"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2024/06/prawn-curry-prawn-masala-recipe.jpg', 'https://www.indianhealthyrecipes.com/prawn-curry-prawn-masala/', 'prawn curry kerala in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  true, 1, 'prawns',
  'main', false, 'south', '{"staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('prawns') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'prawns', _ingredient_id,
  500, 'g', 'cleaned and deveined',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coconut milk') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coconut milk', _ingredient_id,
  200, 'ml', NULL,
  false, 'main', 10
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('black pepper') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'black pepper', _ingredient_id,
  1, 'teaspoon', 'coarsely crushed',
  false, 'spice mix', 12
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat oil in a heavy pan over medium heat. Add the aromatics and cook for 6 to 8 minutes until they soften and smell sweet.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Stir in the ground spices, then add the prawns. Cook for 3 to 4 minutes so the masala coats everything evenly and loses any raw edge.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Add water or other liquid as needed, cover, and simmer on medium heat until the main ingredient is cooked through and the gravy thickens.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 4, 'Cook only until the prawns curl and turn opaque, then take the pan off the heat immediately. Simmer for 2 more minutes, then rest the dish for 5 minutes before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 179/215: Prawn Fry
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
  'Prawn Fry', 'Prawn Fry features quick spice crust. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'south_indian', NULL, 'quick pan fry',
  '{"lunch","dinner"}', 4, 10, 15,
  'easy', '{"seafood","weekend-favorite","meal-prep"}', '{"quick","stir-fry"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2024/05/prawns-fry-recipe.jpg', 'https://www.indianhealthyrecipes.com/prawn-fry-recipe-royyala-vepudu/', 'prawn fry in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  true, 1, 'prawns',
  'main', false, 'south', '{"staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('prawns') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'prawns', _ingredient_id,
  500, 'g', 'cleaned and deveined',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('black pepper') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'black pepper', _ingredient_id,
  1, 'teaspoon', 'coarsely crushed',
  false, 'spice mix', 10
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
  _recipe_id, 1, 'Heat oil in a heavy pan over medium heat. Add the aromatics and cook for 6 to 8 minutes until they soften and smell sweet.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Stir in the ground spices, then add the prawns. Cook for 3 to 4 minutes so the masala coats everything evenly and loses any raw edge.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Add water or other liquid as needed, cover, and simmer on medium heat until the main ingredient is cooked through and the gravy thickens.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 4, 'Cook only until the prawns curl and turn opaque, then take the pan off the heat immediately. Simmer for 2 more minutes, then rest the dish for 5 minutes before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 180/215: Prawn Biryani
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
  'Prawn Biryani', 'Prawn Biryani is a fragrant rice dish with juicy prawns with aromatic rice. It cooks into a complete meal that feels festive without being fussy.', 'hyderabadi', NULL, 'dum-style',
  '{"lunch","dinner"}', 4, 25, 40,
  'hard', '{"one-pot","crowd-pleaser","meal-prep"}', '{"one-pot"}', '{}',
  '/images/recipes/prawn-biryani.png', 'https://www.indianhealthyrecipes.com/prawn-biryani-recipe-prawn-recipes/', 'prawn biryani in a handi bowl garnished with herbs, overhead food photography',
  false, false, false, false,
  true, 2, 'prawns',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('prawns') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'prawns', _ingredient_id,
  500, 'g', 'cleaned and deveined',
  false, 'main', 6
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('curd') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'curd', _ingredient_id,
  120, 'g', 'whisked',
  false, 'main', 7
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('mint leaves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'mint leaves', _ingredient_id,
  15, 'g', 'chopped',
  false, 'finish', 8
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('biryani masala') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'biryani masala', _ingredient_id,
  2, 'teaspoon', NULL,
  false, 'spice mix', 10
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cinnamon') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cinnamon', _ingredient_id,
  1, 'piece', NULL,
  false, 'whole spices', 11
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cardamom') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cardamom', _ingredient_id,
  1, 'piece', NULL,
  false, 'whole spices', 12
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cloves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cloves', _ingredient_id,
  1, 'piece', NULL,
  false, 'whole spices', 13
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
  _recipe_id, 4, 'Fluff the rice gently and finish with herbs before serving. Rest the rice off the heat for 10 minutes before fluffing gently.'
);

-- -----------------------------------------------------------------------
-- Recipe 181/215: Prawn Coconut Curry
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
  'Prawn Coconut Curry', 'Prawn Coconut Curry features creamy coconut gravy. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'kerala', NULL, 'coastal-style',
  '{"lunch","dinner"}', 4, 15, 25,
  'medium', '{"seafood","weekend-favorite","meal-prep"}', '{"stir-fry"}', '{}',
  '/images/recipes/prawn-coconut-curry.png', 'https://www.indianhealthyrecipes.com/prawn-biryani-recipe-prawn-recipes/', 'prawn coconut curry in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  true, 1, 'prawns',
  'main', false, 'south', '{"staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('prawns') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'prawns', _ingredient_id,
  500, 'g', 'cleaned and deveined',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coconut milk') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coconut milk', _ingredient_id,
  200, 'ml', NULL,
  false, 'main', 10
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
  _recipe_id, 1, 'Heat oil in a heavy pan over medium heat. Add the aromatics and cook for 6 to 8 minutes until they soften and smell sweet.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Stir in the ground spices, then add the prawns. Cook for 3 to 4 minutes so the masala coats everything evenly and loses any raw edge.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Add water or other liquid as needed, cover, and simmer on medium heat until the main ingredient is cooked through and the gravy thickens.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 4, 'Cook only until the prawns curl and turn opaque, then take the pan off the heat immediately. Simmer for 2 more minutes, then rest the dish for 5 minutes before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 182/215: Prawn Pepper Fry
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
  'Prawn Pepper Fry', 'Prawn Pepper Fry features black pepper heat and quick finish. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'south_indian', NULL, 'pepper-style',
  '{"lunch","dinner"}', 4, 10, 15,
  'easy', '{"seafood","weekend-favorite","meal-prep"}', '{"quick","stir-fry"}', '{}',
  '/images/recipes/prawn-pepper-fry.png', 'https://www.indianhealthyrecipes.com/prawn-biryani-recipe-prawn-recipes/', 'prawn pepper fry in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  true, 1, 'prawns',
  'main', false, 'south', '{"staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('prawns') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'prawns', _ingredient_id,
  500, 'g', 'cleaned and deveined',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('black pepper') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'black pepper', _ingredient_id,
  1, 'teaspoon', 'coarsely crushed',
  false, 'spice mix', 10
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
  _recipe_id, 1, 'Heat oil in a heavy pan over medium heat. Add the aromatics and cook for 6 to 8 minutes until they soften and smell sweet.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Stir in the ground spices, then add the prawns. Cook for 3 to 4 minutes so the masala coats everything evenly and loses any raw edge.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Add water or other liquid as needed, cover, and simmer on medium heat until the main ingredient is cooked through and the gravy thickens.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 4, 'Cook only until the prawns curl and turn opaque, then take the pan off the heat immediately. Simmer for 2 more minutes, then rest the dish for 5 minutes before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 183/215: Prawn Ghee Roast
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
  'Prawn Ghee Roast', 'Prawn Ghee Roast features ghee-roasted masala and tangy finish. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'karnataka', NULL, 'mangalorean',
  '{"lunch","dinner"}', 4, 20, 20,
  'medium', '{"seafood","weekend-favorite","meal-prep"}', '{"stir-fry"}', '{}',
  '/images/recipes/prawn-ghee-roast.png', 'https://www.indianhealthyrecipes.com/prawn-biryani-recipe-prawn-recipes/', 'prawn ghee roast in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  true, 1, 'prawns',
  'main', false, 'south', '{"staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('prawns') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'prawns', _ingredient_id,
  500, 'g', 'cleaned and deveined',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('ghee') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'ghee', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 10
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('kashmiri chili powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'kashmiri chili powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 11
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('tamarind paste') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'tamarind paste', _ingredient_id,
  1, 'tablespoon', NULL,
  false, 'souring', 12
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat oil in a heavy pan over medium heat. Add the aromatics and cook for 6 to 8 minutes until they soften and smell sweet.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Stir in the ground spices, then add the prawns. Cook for 3 to 4 minutes so the masala coats everything evenly and loses any raw edge.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Add water or other liquid as needed, cover, and simmer on medium heat until the main ingredient is cooked through and the gravy thickens.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 4, 'Cook only until the prawns curl and turn opaque, then take the pan off the heat immediately. Simmer for 2 more minutes, then rest the dish for 5 minutes before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 184/215: Prawn Fried Rice
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
  'Prawn Fried Rice', 'Prawn Fried Rice is a fragrant rice dish with quick prawns and smoky rice. It cooks into a complete meal that feels festive without being fussy.', 'indo_chinese', NULL, 'wok-style',
  '{"lunch","dinner"}', 4, 15, 12,
  'easy', '{"one-pot","crowd-pleaser","meal-prep"}', '{"quick","stir-fry"}', '{}',
  '/images/recipes/prawn-fried-rice.png', 'https://www.indianhealthyrecipes.com/prawn-biryani-recipe-prawn-recipes/', 'prawn fried rice in a handi bowl garnished with herbs, overhead food photography',
  false, false, false, false,
  true, 2, 'prawns',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('prawns') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'prawns', _ingredient_id,
  500, 'g', 'cleaned and deveined',
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

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Rinse the rice well, then soak it for 15 minutes while you prepare the masala base.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Saute the aromatics in fat, add the prawns, vegetables, and sauces, and cook for 3 to 4 minutes so the mixture becomes fragrant and lightly glossy.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Stir in the rice and measured water, bring the pot to a boil, then cover and cook on low heat until the grains are tender.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 4, 'Cook just until the prawns turn pink and the rice smells smoky. Rest the rice off the heat for 10 minutes before fluffing gently.'
);

-- -----------------------------------------------------------------------
-- Recipe 185/215: Prawn Manchurian
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
  'Prawn Manchurian', 'Prawn Manchurian is a crowd-pleasing snack with crisp edges and punchy seasoning. It has the kind of bold flavor and texture that works well for sharing.', 'indo_chinese', NULL, 'restaurant-style',
  '{"snack","dinner"}', 4, 20, 20,
  'medium', '{"tea-time","crowd-pleaser","weekend-treat"}', '{"stir-fry"}', '{}',
  '/images/recipes/prawn-manchurian.png', 'https://www.indianhealthyrecipes.com/prawn-biryani-recipe-prawn-recipes/', 'prawn manchurian in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  false, 1, 'prawns',
  'complete', true, 'indo_chinese', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('prawns') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'prawns', _ingredient_id,
  500, 'g', 'cleaned and deveined',
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
  _recipe_id, 1, 'Coat the cleaned prawns lightly with corn flour and salt, then fry or pan-sear until just cooked.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Cook garlic, green chili, and spring onion in a hot wok, then add soy sauce, vinegar, and tomato ketchup.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Toss the prawns in the sauce briefly so they stay juicy and glossy.'
);

-- -----------------------------------------------------------------------
-- Recipe 186/215: Prawn Sukka
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
  'Prawn Sukka', 'Prawn Sukka features dry coconut masala clinging to prawns. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'karnataka', NULL, 'coastal-style',
  '{"lunch","dinner"}', 4, 15, 25,
  'medium', '{"seafood","weekend-favorite","meal-prep"}', '{"stir-fry"}', '{}',
  '/images/recipes/prawn-sukka.png', 'https://www.indianhealthyrecipes.com/prawn-biryani-recipe-prawn-recipes/', 'prawn sukka in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  true, 1, 'prawns',
  'main', false, 'south', '{"staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('prawns') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'prawns', _ingredient_id,
  500, 'g', 'cleaned and deveined',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('dry coconut') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'dry coconut', _ingredient_id,
  40, 'g', 'grated',
  false, 'finish', 10
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
  _recipe_id, 1, 'Heat oil in a heavy pan over medium heat. Add the aromatics and cook for 6 to 8 minutes until they soften and smell sweet.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Stir in the ground spices, then add the prawns. Cook for 3 to 4 minutes so the masala coats everything evenly and loses any raw edge.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Add water or other liquid as needed, cover, and simmer on medium heat until the main ingredient is cooked through and the gravy thickens.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 4, 'Cook only until the prawns curl and turn opaque, then take the pan off the heat immediately. Simmer for 2 more minutes, then rest the dish for 5 minutes before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 187/215: Mutton Rogan Josh
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
  'Mutton Rogan Josh', 'Mutton Rogan Josh features deep red gravy and warming spices. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'kashmiri', NULL, 'slow-cooked',
  '{"lunch","dinner"}', 4, 20, 50,
  'hard', '{"slow-cooked","special-occasion","meal-prep"}', '{"slow-cook"}', '{}',
  'https://www.whiskaffair.com/wp-content/uploads/2019/02/Mutton-Rogan-Josh-2-3.jpg', 'https://www.whiskaffair.com/mutton-rogan-josh-recipe/', 'mutton rogan josh in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  true, 2, 'mutton',
  'main', false, 'north', '{"staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('mutton') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'mutton', _ingredient_id,
  700, 'g', 'cut into pieces',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('meat masala') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'meat masala', _ingredient_id,
  2, 'teaspoon', NULL,
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('fennel seeds') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'fennel seeds', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 13
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat oil in a heavy pan over medium heat. Add the aromatics and cook for 6 to 8 minutes until they soften and smell sweet.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Stir in the ground spices, then add the mutton. Cook for 3 to 4 minutes so the masala coats everything evenly and loses any raw edge.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Add water or other liquid as needed, cover, and simmer on medium heat until the main ingredient is cooked through and the gravy thickens.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 4, 'Cook low and slow until the meat yields easily and the masala turns rich and glossy. Simmer for 2 more minutes, then rest the dish for 5 minutes before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 188/215: Keema Matar
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
  'Keema Matar', 'Keema Matar combines finely chopped lamb-style mince and peas in a savory masala that feels hearty without being heavy. It is a familiar North Indian staple that works beautifully with roti or rice.', 'north_indian', NULL, 'home-style',
  '{"lunch","dinner"}', 4, 20, 30,
  'medium', '{"slow-cooked","special-occasion","meal-prep"}', '{"slow-cook"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2018/08/mutton-keema-recipe.jpg', 'https://www.indianhealthyrecipes.com/keema-recipe-mutton-keema-curry/', 'keema matar in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  true, 2, 'lamb',
  'main', false, 'north', '{"staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('lamb') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'lamb', _ingredient_id,
  700, 'g', 'cut into pieces',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('meat masala') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'meat masala', _ingredient_id,
  2, 'teaspoon', NULL,
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('peas') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'peas', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 11
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Finely chop the lamb by hand or pulse it briefly so it resembles a mince texture. Heat oil and cook onion, ginger garlic paste, tomato, and spices into a concentrated masala.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Add the chopped lamb and cook on medium heat, breaking it up constantly, until it loses its raw color and starts to brown lightly.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Stir in peas and a splash of water, then cook until the meat is tender and the masala turns thick rather than saucy.'
);

-- -----------------------------------------------------------------------
-- Recipe 189/215: Mutton Biryani
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
  'Mutton Biryani', 'Mutton Biryani is a fragrant rice dish with slow-cooked mutton and layered rice. It cooks into a complete meal that feels festive without being fussy.', 'hyderabadi', NULL, 'dum-style',
  '{"lunch","dinner"}', 4, 30, 45,
  'hard', '{"one-pot","crowd-pleaser","meal-prep"}', '{"one-pot"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2019/02/mutton-biryani-recipe.jpg', 'https://www.indianhealthyrecipes.com/mutton-biryani/', 'mutton biryani in a handi bowl garnished with herbs, overhead food photography',
  false, false, false, false,
  true, 2, 'mutton',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('mutton') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'mutton', _ingredient_id,
  700, 'g', 'cut into pieces',
  false, 'main', 6
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('curd') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'curd', _ingredient_id,
  120, 'g', 'whisked',
  false, 'main', 7
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('mint leaves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'mint leaves', _ingredient_id,
  15, 'g', 'chopped',
  false, 'finish', 8
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('biryani masala') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'biryani masala', _ingredient_id,
  2, 'teaspoon', NULL,
  false, 'spice mix', 10
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cinnamon') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cinnamon', _ingredient_id,
  1, 'piece', NULL,
  false, 'whole spices', 11
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cardamom') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cardamom', _ingredient_id,
  1, 'piece', NULL,
  false, 'whole spices', 12
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cloves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cloves', _ingredient_id,
  1, 'piece', NULL,
  false, 'whole spices', 13
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
  _recipe_id, 4, 'Fluff the rice gently and finish with herbs before serving. Rest the rice off the heat for 10 minutes before fluffing gently.'
);

-- -----------------------------------------------------------------------
-- Recipe 190/215: Mutton Curry
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
  'Mutton Curry', 'Mutton Curry features slow-simmered mutton in robust gravy. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'north_indian', NULL, 'home-style',
  '{"lunch","dinner"}', 4, 20, 45,
  'hard', '{"slow-cooked","special-occasion","meal-prep"}', '{"slow-cook"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2016/05/mutton-curry-1.jpg', 'https://www.indianhealthyrecipes.com/mutton-curry-recipe-mutton-gravy/', 'mutton curry in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  true, 2, 'mutton',
  'main', false, 'north', '{"staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('mutton') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'mutton', _ingredient_id,
  700, 'g', 'cut into pieces',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('meat masala') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'meat masala', _ingredient_id,
  2, 'teaspoon', NULL,
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
  _recipe_id, 2, 'Stir in the ground spices, then add the mutton. Cook for 3 to 4 minutes so the masala coats everything evenly and loses any raw edge.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Add water or other liquid as needed, cover, and simmer on medium heat until the main ingredient is cooked through and the gravy thickens.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 4, 'Cook low and slow until the meat yields easily and the masala turns rich and glossy. Simmer for 2 more minutes, then rest the dish for 5 minutes before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 191/215: Mutton Korma
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
  'Mutton Korma', 'Mutton Korma features curd, nuts, and whole spice richness. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'mughlai', NULL, 'royal-style',
  '{"lunch","dinner"}', 4, 20, 45,
  'hard', '{"slow-cooked","special-occasion","meal-prep"}', '{"slow-cook"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2018/05/mutton-korma-goat-korma-recipe.jpg', 'https://www.indianhealthyrecipes.com/mutton-korma-recipe/', 'mutton korma in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  true, 2, 'mutton',
  'main', false, 'north', '{"staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('mutton') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'mutton', _ingredient_id,
  700, 'g', 'cut into pieces',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('meat masala') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'meat masala', _ingredient_id,
  2, 'teaspoon', NULL,
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

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat oil in a heavy pan over medium heat. Add the aromatics and cook for 6 to 8 minutes until they soften and smell sweet.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Stir in the ground spices, then add the mutton. Cook for 3 to 4 minutes so the masala coats everything evenly and loses any raw edge.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Add water or other liquid as needed, cover, and simmer on medium heat until the main ingredient is cooked through and the gravy thickens.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 4, 'Cook low and slow until the meat yields easily and the masala turns rich and glossy. Simmer for 2 more minutes, then rest the dish for 5 minutes before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 192/215: Mutton Fry
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
  'Mutton Fry', 'Mutton Fry features reduced masala and pepper finish. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'south_indian', NULL, 'dry roast',
  '{"lunch","dinner"}', 4, 20, 25,
  'medium', '{"slow-cooked","special-occasion","meal-prep"}', '{"stir-fry"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2017/07/mutton-fry.jpg', 'https://www.indianhealthyrecipes.com/mutton-fry-recipe/', 'mutton fry in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  true, 2, 'mutton',
  'main', false, 'south', '{"staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('mutton') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'mutton', _ingredient_id,
  700, 'g', 'cut into pieces',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('meat masala') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'meat masala', _ingredient_id,
  2, 'teaspoon', NULL,
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('black pepper') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'black pepper', _ingredient_id,
  1, 'teaspoon', 'coarsely crushed',
  false, 'spice mix', 11
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
  _recipe_id, 1, 'Heat oil in a heavy pan over medium heat. Add the aromatics and cook for 6 to 8 minutes until they soften and smell sweet.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Stir in the ground spices, then add the mutton. Cook for 3 to 4 minutes so the masala coats everything evenly and loses any raw edge.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Add water or other liquid as needed, cover, and simmer on medium heat until the main ingredient is cooked through and the gravy thickens.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 4, 'Cook low and slow until the meat yields easily and the masala turns rich and glossy. Simmer for 2 more minutes, then rest the dish for 5 minutes before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 193/215: Mutton Stew
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
  'Mutton Stew', 'Mutton Stew features light coconut milk broth and tender meat. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'kerala', NULL, 'stew-style',
  '{"lunch","dinner"}', 4, 20, 40,
  'hard', '{"slow-cooked","special-occasion","meal-prep"}', '{"slow-cook"}', '{}',
  'https://myfoodstory.com/wp-content/uploads/2020/06/Mutton-Stew-Ishtu-with-Coconut-3.jpg', 'https://myfoodstory.com/mutton-stew-ishtu-recipe/', 'mutton stew in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  true, 2, 'mutton',
  'main', false, 'south', '{"staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('mutton') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'mutton', _ingredient_id,
  700, 'g', 'cut into pieces',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('meat masala') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'meat masala', _ingredient_id,
  2, 'teaspoon', NULL,
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coconut milk') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coconut milk', _ingredient_id,
  200, 'ml', NULL,
  false, 'main', 11
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coconut cream') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coconut cream', _ingredient_id,
  100, 'ml', NULL,
  false, 'finish', 12
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('potato') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'potato', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 13
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cinnamon') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cinnamon', _ingredient_id,
  1, 'piece', NULL,
  false, 'whole spices', 14
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
  _recipe_id, 2, 'Stir in the ground spices, then add the mutton. Cook for 3 to 4 minutes so the masala coats everything evenly and loses any raw edge.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Add water or other liquid as needed, cover, and simmer on medium heat until the main ingredient is cooked through and the gravy thickens.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 4, 'Cook low and slow until the meat yields easily and the masala turns rich and glossy. Simmer for 2 more minutes, then rest the dish for 5 minutes before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 194/215: Mutton Seekh Kebab
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
  'Mutton Seekh Kebab', 'Mutton Seekh Kebab is a crowd-pleasing snack with crisp edges and punchy seasoning. It has the kind of bold flavor and texture that works well for sharing.', 'mughlai', NULL, 'kebab-house style',
  '{"snack","dinner"}', 4, 30, 30,
  'hard', '{"tea-time","crowd-pleaser","weekend-treat"}', '{"grill / tandoor","weekend-project"}', '{}',
  '/images/recipes/mutton-seekh-kebab.png', 'https://www.indianhealthyrecipes.com/mutton-biryani/', 'mutton seekh kebab in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  false, 1, 'mutton',
  'complete', true, 'north', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('mutton') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'mutton', _ingredient_id,
  700, 'g', 'cut into pieces',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('garam masala') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'garam masala', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('bread crumbs') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'bread crumbs', _ingredient_id,
  320, 'g', NULL,
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

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Finely chop or grind the mutton, then mix it with onion, green chili, ginger garlic paste, bread crumbs, salt, and garam masala until tacky.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Shape the mixture around skewers or into compact logs and chill for 15 minutes.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Grill or pan-sear, turning often, until cooked through and charred in spots.'
);

-- -----------------------------------------------------------------------
-- Recipe 195/215: Mutton Sukka
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
  'Mutton Sukka', 'Mutton Sukka features dry coconut and dark roasted masala. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'maharashtrian', NULL, 'dry masala',
  '{"lunch","dinner"}', 4, 20, 30,
  'medium', '{"slow-cooked","special-occasion","meal-prep"}', '{"stir-fry"}', '{}',
  '/images/recipes/mutton-sukka.png', 'https://www.indianhealthyrecipes.com/mutton-biryani/', 'mutton sukka in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  true, 2, 'mutton',
  'main', false, 'maharashtrian', '{"staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('mutton') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'mutton', _ingredient_id,
  700, 'g', 'cut into pieces',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('meat masala') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'meat masala', _ingredient_id,
  2, 'teaspoon', NULL,
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('dry coconut') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'dry coconut', _ingredient_id,
  40, 'g', 'grated',
  false, 'finish', 11
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('black pepper') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'black pepper', _ingredient_id,
  1, 'teaspoon', 'coarsely crushed',
  false, 'spice mix', 12
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat oil in a heavy pan over medium heat. Add the aromatics and cook for 6 to 8 minutes until they soften and smell sweet.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Stir in the ground spices, then add the mutton. Cook for 3 to 4 minutes so the masala coats everything evenly and loses any raw edge.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Add water or other liquid as needed, cover, and simmer on medium heat until the main ingredient is cooked through and the gravy thickens.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 4, 'Cook low and slow until the meat yields easily and the masala turns rich and glossy. Simmer for 2 more minutes, then rest the dish for 5 minutes before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 196/215: Lamb Curry
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
  'Lamb Curry', 'Lamb Curry features slow-simmered lamb in rich masala. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'north_indian', NULL, 'home-style',
  '{"lunch","dinner"}', 4, 20, 45,
  'hard', '{"slow-cooked","special-occasion","meal-prep"}', '{"slow-cook"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2023/04/lamb-curry-recipe.jpg', 'https://www.indianhealthyrecipes.com/lamb-curry/', 'lamb curry in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  true, 2, 'lamb',
  'main', false, 'north', '{"staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('lamb') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'lamb', _ingredient_id,
  700, 'g', 'cut into pieces',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('meat masala') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'meat masala', _ingredient_id,
  2, 'teaspoon', NULL,
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
  _recipe_id, 2, 'Stir in the ground spices, then add the lamb. Cook for 3 to 4 minutes so the masala coats everything evenly and loses any raw edge.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Add water or other liquid as needed, cover, and simmer on medium heat until the main ingredient is cooked through and the gravy thickens.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 4, 'Cook low and slow until the meat yields easily and the masala turns rich and glossy. Simmer for 2 more minutes, then rest the dish for 5 minutes before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 197/215: Lamb Korma
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
  'Lamb Korma', 'Lamb Korma features cashew-curd gravy and tender lamb. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'mughlai', NULL, 'royal-style',
  '{"lunch","dinner"}', 4, 20, 45,
  'hard', '{"slow-cooked","special-occasion","meal-prep"}', '{"slow-cook"}', '{}',
  '/images/recipes/lamb-korma.png', 'https://www.indianhealthyrecipes.com/keema-recipe-mutton-keema-curry/', 'lamb korma in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  true, 2, 'lamb',
  'main', false, 'north', '{"staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('lamb') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'lamb', _ingredient_id,
  700, 'g', 'cut into pieces',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('meat masala') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'meat masala', _ingredient_id,
  2, 'teaspoon', NULL,
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

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat oil in a heavy pan over medium heat. Add the aromatics and cook for 6 to 8 minutes until they soften and smell sweet.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Stir in the ground spices, then add the lamb. Cook for 3 to 4 minutes so the masala coats everything evenly and loses any raw edge.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Add water or other liquid as needed, cover, and simmer on medium heat until the main ingredient is cooked through and the gravy thickens.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 4, 'Cook low and slow until the meat yields easily and the masala turns rich and glossy. Simmer for 2 more minutes, then rest the dish for 5 minutes before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 198/215: Lamb Kebabs
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
  'Lamb Kebabs', 'Lamb Kebabs is a crowd-pleasing snack with crisp edges and punchy seasoning. It has the kind of bold flavor and texture that works well for sharing.', 'mughlai', NULL, 'kebab-house style',
  '{"snack","dinner"}', 4, 25, 35,
  'hard', '{"tea-time","crowd-pleaser","weekend-treat"}', '{"grill / tandoor","weekend-project"}', '{}',
  '/images/recipes/lamb-kebabs.png', 'https://www.indianhealthyrecipes.com/keema-recipe-mutton-keema-curry/', 'lamb kebabs in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  false, 1, 'lamb',
  'complete', true, 'north', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('lamb') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'lamb', _ingredient_id,
  700, 'g', 'cut into pieces',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('garam masala') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'garam masala', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 4
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('bread crumbs') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'bread crumbs', _ingredient_id,
  320, 'g', NULL,
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

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Finely chop or mince the lamb, then mix it thoroughly with onion, green chili, ginger garlic paste, bread crumbs, salt, and garam masala.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Shape into kebabs and chill briefly so they firm up and hold their shape.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Grill or pan-sear until browned outside and fully cooked at the center.'
);

-- -----------------------------------------------------------------------
-- Recipe 199/215: Lamb Pulao
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
  'Lamb Pulao', 'Lamb Pulao is a fragrant rice dish with tender lamb and fragrant whole spices. It cooks into a complete meal that feels festive without being fussy.', 'lucknowi', NULL, 'aromatic stock-based',
  '{"lunch","dinner"}', 4, 25, 40,
  'hard', '{"one-pot","crowd-pleaser","meal-prep"}', '{"one-pot"}', '{}',
  '/images/recipes/lamb-pulao.png', 'https://www.indianhealthyrecipes.com/yakhni-pulao/', 'lamb pulao in a handi bowl garnished with herbs, overhead food photography',
  false, false, false, false,
  true, 2, 'lamb',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('lamb') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'lamb', _ingredient_id,
  700, 'g', 'cut into pieces',
  false, 'main', 6
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('curd') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'curd', _ingredient_id,
  120, 'g', 'whisked',
  false, 'main', 7
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('mint leaves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'mint leaves', _ingredient_id,
  15, 'g', 'chopped',
  false, 'finish', 8
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cinnamon') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cinnamon', _ingredient_id,
  1, 'piece', NULL,
  false, 'whole spices', 9
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cardamom') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cardamom', _ingredient_id,
  1, 'piece', NULL,
  false, 'whole spices', 10
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cloves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cloves', _ingredient_id,
  1, 'piece', NULL,
  false, 'whole spices', 11
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('bay leaf') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'bay leaf', _ingredient_id,
  1, 'piece', NULL,
  false, 'whole spices', 12
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
  _recipe_id, 4, 'Fluff the rice gently and finish with herbs before serving. Rest the rice off the heat for 10 minutes before fluffing gently.'
);

-- -----------------------------------------------------------------------
-- Recipe 200/215: Lamb Bhuna
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
  'Lamb Bhuna', 'Lamb Bhuna features reduced masala clinging to lamb. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'north_indian', NULL, 'dry masala style',
  '{"lunch","dinner"}', 4, 20, 30,
  'medium', '{"slow-cooked","special-occasion","meal-prep"}', '{"stir-fry"}', '{}',
  '/images/recipes/lamb-bhuna.png', 'https://www.indianhealthyrecipes.com/lamb-curry/', 'lamb bhuna in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  true, 2, 'lamb',
  'main', false, 'north', '{"staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('lamb') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'lamb', _ingredient_id,
  700, 'g', 'cut into pieces',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('meat masala') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'meat masala', _ingredient_id,
  2, 'teaspoon', NULL,
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
  _recipe_id, 2, 'Stir in the ground spices, then add the lamb. Cook for 3 to 4 minutes so the masala coats everything evenly and loses any raw edge.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Add water or other liquid as needed, cover, and simmer on medium heat until the main ingredient is cooked through and the gravy thickens.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 4, 'Cook low and slow until the meat yields easily and the masala turns rich and glossy. Simmer for 2 more minutes, then rest the dish for 5 minutes before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 201/215: Chapati
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
  'Chapati', 'Chapati is the everyday Indian flatbread — soft, pliable, and made from just whole wheat flour and water. It pairs with virtually any curry, dal, or sabzi.', 'north_indian', NULL, 'everyday',
  '{"breakfast","lunch","dinner"}', 4, 15, 20,
  'easy', '{"tiffin","weekday-friendly","comfort-food"}', '{"quick"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2022/11/chapati-recipe-soft.jpg', 'https://www.indianhealthyrecipes.com/chapati/', 'chapati plated with chutney or side accompaniments, Indian breakfast photography',
  true, true, false, true,
  true, 1, NULL,
  'staple', false, 'north', '{"main"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('atta') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'atta', _ingredient_id,
  220, 'g', NULL,
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('salt') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'salt', _ingredient_id,
  5, 'g', NULL,
  false, 'seasoning', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('water') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'water', _ingredient_id,
  500, 'ml', NULL,
  false, 'cooking liquid', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('ghee') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'ghee', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 3
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Mix atta, salt, and water into a smooth soft dough. Knead it for 5 minutes until elastic, then rest it covered for 10 minutes.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Divide into small balls, dust with dry flour, and roll each into a thin even round.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Cook on a hot tawa until brown spots appear on both sides, then puff directly on the flame for a few seconds. Brush with a little ghee.'
);

-- -----------------------------------------------------------------------
-- Recipe 202/215: Phulka
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
  'Phulka', 'Phulka is a lighter version of chapati that puffs up on the open flame. It is soft, oil-free, and the most common everyday Indian bread.', 'north_indian', NULL, 'home-style',
  '{"breakfast","lunch","dinner"}', 4, 15, 15,
  'easy', '{"tiffin","weekday-friendly","comfort-food"}', '{"quick"}', '{}',
  'https://www.vegrecipesofindia.com/wp-content/uploads/2021/08/roti.jpg', 'https://www.vegrecipesofindia.com/rotis-made-from-whole-wheat-flour/', 'phulka plated with chutney or side accompaniments, Indian breakfast photography',
  true, true, false, true,
  true, 1, NULL,
  'staple', false, 'north', '{"main"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('atta') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'atta', _ingredient_id,
  220, 'g', NULL,
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('salt') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'salt', _ingredient_id,
  5, 'g', NULL,
  false, 'seasoning', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('water') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'water', _ingredient_id,
  500, 'ml', NULL,
  false, 'cooking liquid', 2
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Knead atta, salt, and water into a soft pliable dough. Rest it covered for 10 minutes.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Roll each portion into a thin round and cook on a dry hot tawa until light spots appear on the underside.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Flip and place directly on the open flame so the phulka puffs up completely. Remove immediately.'
);

-- -----------------------------------------------------------------------
-- Recipe 203/215: Paratha
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
  'Paratha', 'Paratha is a layered Indian flatbread enriched with ghee for flaky texture. It is heartier than chapati and pairs well with curd, pickle, or any rich curry.', 'north_indian', NULL, 'home-style',
  '{"breakfast","lunch","dinner"}', 4, 20, 20,
  'easy', '{"tiffin","weekday-friendly","comfort-food"}', '{"quick"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2025/08/paratha-recipe.jpg', 'https://www.indianhealthyrecipes.com/paratha-recipe-plain-paratha/', 'paratha plated with chutney or side accompaniments, Indian breakfast photography',
  true, false, false, false,
  true, 1, NULL,
  'staple', false, 'north', '{"main"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('atta') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'atta', _ingredient_id,
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('salt') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'salt', _ingredient_id,
  5, 'g', NULL,
  false, 'seasoning', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('water') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'water', _ingredient_id,
  500, 'ml', NULL,
  false, 'cooking liquid', 3
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Make a soft dough with atta, salt, and water. Rest it for 10 minutes, then divide into equal portions.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Roll each portion, spread ghee and fold into layers, then roll again into a round or triangle.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Cook on a hot tawa with ghee until golden brown spots appear on both sides. The paratha should be flaky and layered.'
);

-- -----------------------------------------------------------------------
-- Recipe 204/215: Naan
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
  'Naan', 'Naan is a soft leavened flatbread with a pillowy texture and slight tang from curd. It is the classic partner for rich gravies like Butter Chicken and Dal Makhani.', 'mughlai', NULL, 'tandoor-style',
  '{"lunch","dinner"}', 4, 20, 20,
  'medium', '{"tea-time","crowd-pleaser","weekend-treat"}', '{"grill / tandoor"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2022/03/butter-naan.jpg', 'https://www.indianhealthyrecipes.com/naan/', 'naan in a serving bowl, appetizing plated food photography',
  true, false, false, false,
  false, 1, NULL,
  'staple', false, 'north', '{"main"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('maida') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'maida', _ingredient_id,
  220, 'g', NULL,
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('baking powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'baking powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'batter', 2
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('ghee') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'ghee', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 5
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
  _recipe_id, 1, 'Mix maida with curd, baking powder, sugar, salt, and a little ghee. Knead into a smooth elastic dough and rest it covered for 1 hour.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Divide into portions and roll or stretch each into an oval shape, slightly thicker than chapati.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Cook on a very hot tawa or in a preheated oven at maximum temperature until the naan puffs and develops charred spots. Brush with ghee.'
);

-- -----------------------------------------------------------------------
-- Recipe 205/215: Garlic Naan
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
  'Garlic Naan', 'Garlic Naan adds punchy roasted garlic and fresh coriander to the classic leavened bread. It is especially good with creamy or tomato-based gravies.', 'mughlai', NULL, 'restaurant-style',
  '{"lunch","dinner"}', 4, 20, 20,
  'medium', '{"tea-time","crowd-pleaser","weekend-treat"}', '{"grill / tandoor"}', '{}',
  'https://www.vegrecipesofindia.com/wp-content/uploads/2022/12/garlic-naan-1.jpg', 'https://www.vegrecipesofindia.com/garlic-naan-recipe/', 'garlic naan in a serving bowl, appetizing plated food photography',
  true, false, false, false,
  false, 1, NULL,
  'staple', false, 'north', '{"main"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('maida') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'maida', _ingredient_id,
  220, 'g', NULL,
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('baking powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'baking powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'batter', 2
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('ghee') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'ghee', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 5
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coriander leaves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coriander leaves', _ingredient_id,
  15, 'g', 'chopped',
  false, 'finish', 7
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
  _recipe_id, 1, 'Make the naan dough with maida, curd, baking powder, sugar, salt, and a little ghee. Rest it for 1 hour until soft and puffy.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Roll or stretch into oval shapes. Press minced garlic and chopped coriander into the surface before cooking.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Cook on a very hot tawa or in a preheated oven until puffed and charred in spots. Brush generously with garlic butter.'
);

-- -----------------------------------------------------------------------
-- Recipe 206/215: Steamed Rice
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
  'Steamed Rice', 'Plain steamed rice is the universal Indian staple — fluffy, neutral, and designed to carry any curry, dal, or sambar. Every Indian kitchen makes it daily.', 'south_indian', NULL, 'everyday',
  '{"lunch","dinner"}', 4, 5, 15,
  'easy', '{"tiffin","weekday-friendly","comfort-food"}', '{"quick","one-pot"}', '{}',
  '/images/recipes/steamed-rice.png', 'https://www.indianhealthyrecipes.com/aloo-gobi-recipe/', 'steamed rice plated with chutney or side accompaniments, Indian breakfast photography',
  true, true, false, true,
  true, 2, NULL,
  'staple', false, 'south', '{"main"}'
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('water') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'water', _ingredient_id,
  500, 'ml', NULL,
  false, 'cooking liquid', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('salt') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'salt', _ingredient_id,
  5, 'g', NULL,
  false, 'seasoning', 2
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Rinse the rice two or three times until the water runs mostly clear, then soak it for 10 minutes.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Bring water and salt to a rolling boil, add the rice, and cook until the grains are tender but not mushy.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Drain any excess water if needed, then fluff gently with a fork and rest it covered for 5 minutes.'
);

-- -----------------------------------------------------------------------
-- Recipe 207/215: Jeera Paratha
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
  'Jeera Paratha', 'Jeera Paratha adds the warm aroma of toasted cumin to a flaky layered flatbread. It pairs beautifully with dals and light vegetable curries.', 'north_indian', NULL, 'home-style',
  '{"breakfast","lunch","dinner"}', 4, 20, 20,
  'easy', '{"tiffin","weekday-friendly","comfort-food"}', '{"quick"}', '{}',
  'https://www.vegrecipesofindia.com/wp-content/uploads/2013/02/ajwain-paratha.jpg', 'https://www.vegrecipesofindia.com/ajwain-paratha/', 'jeera paratha plated with chutney or side accompaniments, Indian breakfast photography',
  true, false, false, false,
  true, 1, NULL,
  'staple', false, 'north', '{"main"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('atta') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'atta', _ingredient_id,
  220, 'g', NULL,
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cumin seeds') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cumin seeds', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'tempering', 1
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('salt') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'salt', _ingredient_id,
  5, 'g', NULL,
  false, 'seasoning', 3
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
  _recipe_id, 1, 'Mix atta with toasted cumin seeds, salt, and water into a soft dough. Rest for 10 minutes.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Divide into portions, roll each into rounds, and layer with ghee for flakiness.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Cook on a hot tawa with ghee until golden on both sides. The cumin should smell toasted and nutty.'
);

-- -----------------------------------------------------------------------
-- Recipe 208/215: Cucumber Raita
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
  'Cucumber Raita', 'Cucumber Raita is a cooling yogurt side that balances spicy mains. It is creamy, fresh, and takes almost no effort to put together.', 'north_indian', NULL, 'everyday',
  '{"lunch","dinner"}', 4, 10, 0,
  'easy', '{"quick","side-dish","cooling"}', '{"no-cook"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2015/03/cucumber-raita.jpg', 'https://www.indianhealthyrecipes.com/cucumber-raita-recipe/', 'cucumber raita in a bowl, Indian food photography',
  true, false, false, false,
  false, 1, NULL,
  'accompaniment', false, 'north', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('curd') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'curd', _ingredient_id,
  250, 'g', 'whisked smooth',
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cucumber') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cucumber', _ingredient_id,
  150, 'g', 'finely grated',
  false, 'main', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cumin powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cumin powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('salt') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'salt', _ingredient_id,
  5, 'g', NULL,
  false, 'seasoning', 3
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coriander leaves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coriander leaves', _ingredient_id,
  15, 'g', 'chopped',
  false, 'finish', 4
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Whisk the curd until completely smooth and creamy.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Fold in the grated cucumber, cumin powder, and salt. Mix gently without overworking.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Chill for 10 minutes if possible, then garnish with coriander before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 209/215: Boondi Raita
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
  'Boondi Raita', 'Boondi Raita combines crispy fried boondi with spiced yogurt for a textured side that is both cooling and satisfying.', 'north_indian', NULL, 'everyday',
  '{"lunch","dinner"}', 4, 10, 0,
  'easy', '{"quick","side-dish","cooling"}', '{"no-cook"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2021/10/boondi-raita-recipe.jpg', 'https://www.indianhealthyrecipes.com/boondi-raita/', 'boondi raita in a bowl, Indian food photography',
  true, false, false, false,
  false, 1, NULL,
  'accompaniment', false, 'north', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('curd') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'curd', _ingredient_id,
  250, 'g', 'whisked smooth',
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('besan') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'besan', _ingredient_id,
  220, 'g', NULL,
  false, 'main', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cumin powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cumin powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('red chili powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'red chili powder', _ingredient_id,
  1, 'teaspoon', NULL,
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coriander leaves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coriander leaves', _ingredient_id,
  15, 'g', 'chopped',
  false, 'finish', 5
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

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'If using homemade boondi, drop besan batter through a slotted spoon into hot oil and fry until crisp. Drain well.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Soak the boondi in water for 2 minutes to soften slightly, then squeeze out the excess water.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Fold the boondi into whisked curd with cumin powder, chili powder, salt, and coriander leaves. Chill briefly before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 210/215: Onion Raita
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
  'Onion Raita', 'Onion Raita is a sharp, crunchy yogurt side that cuts through rich gravies. It comes together in minutes with no cooking.', 'north_indian', NULL, 'everyday',
  '{"lunch","dinner"}', 4, 10, 0,
  'easy', '{"quick","side-dish","cooling"}', '{"no-cook"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2022/04/onion-raita-recipe.jpg', 'https://www.indianhealthyrecipes.com/onion-raita-recipe-make-onion-raita-recipe/', 'onion raita in a bowl, Indian food photography',
  true, false, false, false,
  false, 1, NULL,
  'accompaniment', false, 'north', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('curd') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'curd', _ingredient_id,
  250, 'g', 'whisked smooth',
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('onion') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'onion', _ingredient_id,
  100, 'g', 'finely chopped',
  false, 'main', 1
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cumin powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cumin powder', _ingredient_id,
  1, 'teaspoon', NULL,
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coriander leaves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coriander leaves', _ingredient_id,
  15, 'g', 'chopped',
  false, 'finish', 5
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Whisk the curd until smooth and add salt and cumin powder.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Fold in the finely chopped onion and green chili.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Garnish with coriander leaves and serve immediately so the onion stays crunchy.'
);

-- -----------------------------------------------------------------------
-- Recipe 211/215: Coconut Chutney
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
  'Coconut Chutney', 'Coconut Chutney is the essential South Indian accompaniment — creamy, subtly spiced, and made for dipping dosa, idli, and vada.', 'south_indian', NULL, 'tiffin-style',
  '{"breakfast","lunch","dinner"}', 4, 10, 5,
  'easy', '{"tiffin","side-dish","south-indian-essential"}', '{"quick"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2024/06/idli-chutney-dosa-chutney-recipe.jpg', 'https://www.indianhealthyrecipes.com/coconut-chutney-recipe-idli-dosa-chutney/', 'coconut chutney in a small bowl with dosa, Indian food photography',
  true, true, false, true,
  false, 1, NULL,
  'accompaniment', false, 'south', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coconut fresh') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coconut fresh', _ingredient_id,
  120, 'g', 'grated',
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('green chili') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'green chili', _ingredient_id,
  2, 'piece', 'slit',
  false, 'aromatics', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('ginger') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'ginger', _ingredient_id,
  20, 'g', 'grated',
  false, 'aromatics', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('salt') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'salt', _ingredient_id,
  5, 'g', NULL,
  false, 'seasoning', 3
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coconut oil') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coconut oil', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 6
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('water') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'water', _ingredient_id,
  500, 'ml', NULL,
  false, 'cooking liquid', 7
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Grind coconut, green chili, ginger, salt, and a splash of water into a smooth paste.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Adjust the consistency with water until it is thick but pourable.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Temper mustard seeds and curry leaves in coconut oil, pour over the chutney, and fold in gently.'
);

-- -----------------------------------------------------------------------
-- Recipe 212/215: Tomato Chutney
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
  'Tomato Chutney', 'Tomato Chutney is a tangy, slightly sweet South Indian condiment that brightens any tiffin plate or rice meal.', 'south_indian', NULL, 'home-style',
  '{"breakfast","lunch","dinner"}', 4, 10, 10,
  'easy', '{"tiffin","side-dish","tangy"}', '{"quick"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2022/08/tomato-pachadi-recipe.jpg', 'https://www.indianhealthyrecipes.com/tomato-pachadi/', 'tomato chutney in a small bowl, South Indian food photography',
  true, true, false, false,
  true, 3, NULL,
  'accompaniment', false, 'south', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('tomato') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'tomato', _ingredient_id,
  300, 'g', 'roughly chopped',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('dry red chili') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'dry red chili', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 2
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coconut oil') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coconut oil', _ingredient_id,
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
  _recipe_id, 1, 'Cook tomato, onion, and dry red chili in a little oil until the tomato breaks down completely and the mixture turns jammy.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Cool slightly and grind to a coarse or smooth paste depending on preference.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Temper mustard seeds and curry leaves in oil, pour over the chutney, and stir.'
);

-- -----------------------------------------------------------------------
-- Recipe 213/215: Mint Chutney
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
  'Mint Chutney', 'Mint Chutney is a bright, herby condiment that pairs with snacks, kebabs, sandwiches, and chaats. It is sharp, cooling, and deeply green.', 'north_indian', NULL, 'street-style',
  '{"breakfast","lunch","dinner","snack"}', 4, 10, 0,
  'easy', '{"quick","condiment","no-cook"}', '{"no-cook"}', '{}',
  '/images/recipes/mint-chutney.png', 'https://www.vegrecipesofindia.com/', 'green mint chutney in a bowl, Indian food photography',
  true, true, false, false,
  true, 3, NULL,
  'accompaniment', false, 'north', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('mint leaves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'mint leaves', _ingredient_id,
  60, 'g', 'chopped',
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coriander leaves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coriander leaves', _ingredient_id,
  15, 'g', 'chopped',
  false, 'finish', 1
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('water') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'water', _ingredient_id,
  500, 'ml', NULL,
  false, 'cooking liquid', 5
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Wash the mint and coriander leaves thoroughly and shake off excess water.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Blend with green chili, lemon juice, salt, and a splash of water into a smooth bright green paste.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Adjust salt and lemon to taste. The chutney should be punchy and slightly tart.'
);

-- -----------------------------------------------------------------------
-- Recipe 214/215: Tamarind Chutney
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
  'Tamarind Chutney', 'Tamarind Chutney is a sweet-sour condiment essential for chaats, samosas, and snack plates. It is dark, sticky, and intensely flavored.', 'north_indian', NULL, 'chaat-style',
  '{"snack","lunch","dinner"}', 4, 10, 15,
  'easy', '{"condiment","sweet-sour","make-ahead"}', '{"quick"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2022/09/tamarind-chutney-imlu-chutney-recipe.jpg', 'https://www.indianhealthyrecipes.com/tamarind-chutney/', 'tamarind chutney in a jar, Indian food photography',
  true, true, false, false,
  true, 7, NULL,
  'accompaniment', false, 'north', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('tamarind') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'tamarind', _ingredient_id,
  100, 'g', 'seedless',
  false, 'main', 0
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('jaggery') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'jaggery', _ingredient_id,
  80, 'g', 'grated',
  false, 'main', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cumin powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cumin powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 2
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('red chili powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'red chili powder', _ingredient_id,
  1, 'teaspoon', NULL,
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('water') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'water', _ingredient_id,
  500, 'ml', NULL,
  false, 'cooking liquid', 5
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Soak the tamarind in warm water for 15 minutes, then squeeze and strain the pulp.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Simmer the tamarind pulp with jaggery, cumin, chili powder, salt, and water for 10 to 12 minutes until slightly thick.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Cool completely. The chutney will thicken further as it cools. Store in a clean jar.'
);

-- -----------------------------------------------------------------------
-- Recipe 215/215: Roasted Papad
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
  'Roasted Papad', 'Roasted Papad is the simplest Indian accompaniment — a thin lentil wafer crisped over flame or in a pan. It adds crunch to any meal.', 'north_indian', NULL, 'everyday',
  '{"lunch","dinner"}', 4, 0, 2,
  'easy', '{"quick","side-dish","crunchy"}', '{"quick"}', '{}',
  'https://food.fnr.sndimg.com/content/dam/images/food/fullset/2025/09/15/WU3901_Ree-Drummond_Slow-Roasted-Chicken-and-Vegetables_s4x3.jpg.rend.hgtvcom.616.462.suffix/1757966799143.webp', 'https://www.foodnetwork.com/recipes/ree-drummond/slow-roasted-chicken-and-vegetables-21360868', 'roasted papad on a plate, Indian food photography',
  true, true, false, true,
  false, 0, NULL,
  'accompaniment', false, 'north', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('papad') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'papad', _ingredient_id,
  4, 'piece', 'roasted',
  false, 'main', 0
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Hold the papad with tongs over a medium flame, rotating slowly and evenly.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'The papad will puff and develop roasted spots within 10 to 15 seconds per side.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Remove as soon as the surface is evenly blistered. It crisps further as it cools.'
);


END $$;

-- Verification
-- ---------------------------------------------------------------------------
SELECT 'global_recipes' AS table_name, count(*) AS row_count FROM global_recipes
UNION ALL
SELECT 'global_recipe_ingredients', count(*) FROM global_recipe_ingredients
UNION ALL
SELECT 'global_recipe_steps', count(*) FROM global_recipe_steps;

-- Dependency distribution
SELECT dish_role, count(*) AS cnt FROM global_recipes GROUP BY dish_role ORDER BY cnt DESC;

-- Recipes with no ingredients (should be 0)
SELECT title FROM global_recipes gr
WHERE NOT EXISTS (SELECT 1 FROM global_recipe_ingredients gri WHERE gri.global_recipe_id = gr.id);

-- Recipes with no steps (should be 0)
SELECT title FROM global_recipes gr
WHERE NOT EXISTS (SELECT 1 FROM global_recipe_steps grs WHERE grs.global_recipe_id = gr.id);

-- Ingredient matching rate
SELECT
  count(*) AS total_ingredients,
  count(global_ingredient_id) AS matched,
  count(*) - count(global_ingredient_id) AS unmatched,
  round(100.0 * count(global_ingredient_id) / count(*), 1) AS match_pct
FROM global_recipe_ingredients;

-- ---------------------------------------------------------------------------
-- Rollback (uncomment if needed)
-- ---------------------------------------------------------------------------
-- DELETE FROM global_recipe_ingredients;
-- DELETE FROM global_recipe_steps;
-- DELETE FROM global_recipes;
