-- Part C: Recipes 109-162 of 215
-- Run AFTER 018a

DO $$
DECLARE
  _recipe_id UUID;
  _ingredient_id UUID;
BEGIN
-- Recipe 109/215: Chettinad Chicken
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
  'Chettinad Chicken', 'Chettinad Chicken features juicy chicken and a fresh black pepper and roasted spice depth. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'chettinad', NULL, 'spicy south indian',
  '{"lunch","dinner"}', 4, 20, 30,
  'medium', '{"family-favorite","protein-rich","meal-prep"}', '{"one-pot"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2024/06/chicken-chukka-varuval-recipe.jpg', 'https://www.indianhealthyrecipes.com/chettinad-chicken-dry-chicken-fry-recipe-step-by-step-pics/', 'chettinad chicken in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  true, 2, 'chicken',
  'main', false, 'south', '{"staple"}'
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('fennel seeds') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'fennel seeds', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 12
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('black pepper') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'black pepper', _ingredient_id,
  1, 'teaspoon', 'coarsely crushed',
  false, 'spice mix', 13
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coconut dried') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coconut dried', _ingredient_id,
  60, 'g', 'grated',
  false, 'main', 14
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
-- Recipe 110/215: Chicken 65
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
  'Chicken 65', 'Chicken 65 is a crowd-pleasing snack with crisp edges and punchy seasoning. It has the kind of bold flavor and texture that works well for sharing.', 'andhra', NULL, 'restaurant-style',
  '{"snack","dinner"}', 4, 20, 20,
  'medium', '{"tea-time","crowd-pleaser","weekend-treat"}', '{"deep-fry"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2022/03/chicken-65-restaurant-style.jpg', 'https://www.indianhealthyrecipes.com/chicken-65-recipe-no-egg-restaurant-style-chicken-recipes/', 'chicken 65 in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  false, 1, 'chicken',
  'complete', true, 'south', '{}'
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('curd') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'curd', _ingredient_id,
  120, 'g', 'whisked',
  false, 'main', 2
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('red chili powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'red chili powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 4
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('lemon juice') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'lemon juice', _ingredient_id,
  1, 'tablespoon', NULL,
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

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Marinate the chicken with curd, ginger garlic paste, red chili powder, salt, and a little corn flour for 20 minutes.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Fry the marinated chicken on medium heat until the pieces turn crisp outside while staying juicy inside.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Toss the fried chicken briefly with hot curry leaves and lemon juice just before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 111/215: Chicken Pulao
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
  'Chicken Pulao', 'Chicken Pulao is a fragrant rice dish with one-pot chicken and warm whole spices. It cooks into a complete meal that feels festive without being fussy.', 'north_indian', NULL, 'home-style',
  '{"lunch","dinner"}', 4, 20, 30,
  'medium', '{"one-pot","crowd-pleaser","meal-prep"}', '{"one-pot"}', '{}',
  'https://myfoodstory.com/wp-content/uploads/2021/05/Easy-Chicken-Pulao-2.jpg', 'https://myfoodstory.com/chicken-pulao-easy/', 'chicken pulao in a handi bowl garnished with herbs, overhead food photography',
  false, false, false, false,
  true, 2, 'chicken',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cinnamon') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cinnamon', _ingredient_id,
  1, 'piece', NULL,
  false, 'whole spices', 10
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cardamom') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cardamom', _ingredient_id,
  1, 'piece', NULL,
  false, 'whole spices', 11
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cloves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cloves', _ingredient_id,
  1, 'piece', NULL,
  false, 'whole spices', 12
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('bay leaf') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'bay leaf', _ingredient_id,
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
-- Recipe 112/215: Chicken Tikka
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
  'Chicken Tikka', 'Chicken Tikka features juicy chicken and a charred yogurt-marinated bites. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'punjabi', NULL, 'tandoor-style',
  '{"lunch","dinner"}', 4, 25, 35,
  'hard', '{"family-favorite","protein-rich","meal-prep"}', '{"grill / tandoor","weekend-project"}', '{}',
  'https://www.whiskaffair.com/wp-content/uploads/2020/06/Chicken-Tikka-2-3.jpg', 'https://www.whiskaffair.com/chicken-tikka/', 'chicken tikka in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  true, 2, 'chicken',
  'complete', true, 'north', '{}'
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
  _recipe_id, 4, 'Finish with herbs or dairy as needed and simmer very gently so the chicken stays tender. Simmer for 2 more minutes, then rest the dish for 5 minutes before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 113/215: Chicken Roast
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
  'Chicken Roast', 'Chicken Roast features juicy chicken and a dark masala clinging to juicy chicken. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'kerala', NULL, 'roast-style',
  '{"lunch","dinner"}', 4, 20, 30,
  'medium', '{"family-favorite","protein-rich","meal-prep"}', '{"one-pot"}', '{}',
  'https://images.archanaskitchen.com/images/recipes/indian/main-course/indian-non-veg-recipes/chicken-recipes/Chettinad_Style_Chicken_Roast_Recipe_semigravy_62cf69d88e.jpg', 'https://www.archanaskitchen.com/recipe/chettinad-style-chicken-roast-recipe', 'chicken roast in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  true, 2, 'chicken',
  'main', false, 'south', '{"staple"}'
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
  _recipe_id, 2, 'Stir in the ground spices, then add the chicken. Cook for 3 to 4 minutes so the masala coats everything evenly and loses any raw edge.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Add water or other liquid as needed, cover, and simmer on medium heat until the main ingredient is cooked through and the gravy thickens.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 4, 'Finish with herbs or dairy as needed and simmer very gently so the chicken stays tender. Simmer for 2 more minutes, then rest the dish for 5 minutes before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 114/215: Chicken Sukka
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
  'Chicken Sukka', 'Chicken Sukka features juicy chicken and a dry coconut masala and bold spices. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'karnataka', NULL, 'mangalorean',
  '{"lunch","dinner"}', 4, 20, 30,
  'medium', '{"family-favorite","protein-rich","meal-prep"}', '{"one-pot"}', '{}',
  'https://myfoodstory.com/wp-content/uploads/2025/01/Mangalorean-Chicken-Sukka-2.jpg', 'https://myfoodstory.com/mangalorean-chicken-sukka/', 'chicken sukka in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  true, 2, 'chicken',
  'main', false, 'south', '{"staple"}'
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('black pepper') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'black pepper', _ingredient_id,
  1, 'teaspoon', 'coarsely crushed',
  false, 'spice mix', 13
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
-- Recipe 115/215: Pepper Chicken
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
  'Pepper Chicken', 'Pepper Chicken features juicy chicken and a black pepper heat and quick pan finish. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'south_indian', NULL, 'pepper-style',
  '{"lunch","dinner"}', 4, 10, 18,
  'easy', '{"family-favorite","protein-rich","meal-prep"}', '{"quick","stir-fry"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2018/07/pepper-chicken-recipe.jpg', 'https://www.indianhealthyrecipes.com/pepper-chicken-recipe/', 'pepper chicken in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  true, 2, 'chicken',
  'main', false, 'south', '{"staple"}'
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
  _recipe_id, 2, 'Stir in the ground spices, then add the chicken. Cook for 3 to 4 minutes so the masala coats everything evenly and loses any raw edge.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Add water or other liquid as needed, cover, and simmer on medium heat until the main ingredient is cooked through and the gravy thickens.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 4, 'Finish with herbs or dairy as needed and simmer very gently so the chicken stays tender. Simmer for 2 more minutes, then rest the dish for 5 minutes before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 116/215: Kadai Chicken
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
  'Kadai Chicken', 'Kadai Chicken features juicy chicken and a capsicum and a punchy masala. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'north_indian', NULL, 'dhaba-style',
  '{"lunch","dinner"}', 4, 20, 25,
  'medium', '{"family-favorite","protein-rich","meal-prep"}', '{"one-pot"}', '{}',
  'https://www.whiskaffair.com/wp-content/uploads/2020/09/Kadai-Chicken-2-2.jpg', 'https://www.whiskaffair.com/kadai-chicken-recipe/', 'kadai chicken in a serving bowl, appetizing plated food photography',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('capsicum') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'capsicum', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 11
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
-- Recipe 117/215: Chicken Jalfrezi
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
  'Chicken Jalfrezi', 'Chicken Jalfrezi features juicy chicken and a capsicum, tomato, and a bright masala. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'north_indian', NULL, 'restaurant-style',
  '{"lunch","dinner"}', 4, 15, 20,
  'medium', '{"family-favorite","protein-rich","meal-prep"}', '{"one-pot"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2022/11/chicken-jalfrezi-recipe.jpg', 'https://www.indianhealthyrecipes.com/chicken-jalfrezi/', 'chicken jalfrezi in a serving bowl, appetizing plated food photography',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('capsicum') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'capsicum', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 11
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('spring onion') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'spring onion', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 12
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
-- Recipe 118/215: Chicken Vindaloo
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
  'Chicken Vindaloo', 'Chicken Vindaloo features juicy chicken and a vinegar-led masala with deep spice. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'goan', NULL, 'sharp-spiced',
  '{"lunch","dinner"}', 4, 20, 30,
  'medium', '{"family-favorite","protein-rich","meal-prep"}', '{"one-pot"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2019/12/chicken-vindaloo-recipe-1.jpg', 'https://www.indianhealthyrecipes.com/chicken-vindaloo/', 'chicken vindaloo in a serving bowl, appetizing plated food photography',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('vinegar') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'vinegar', _ingredient_id,
  1, 'tablespoon', NULL,
  false, 'sauce', 11
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('mustard oil') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'mustard oil', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 12
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('kashmiri chili powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'kashmiri chili powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 13
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
-- Recipe 119/215: Kerala Chicken Stew
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
  'Kerala Chicken Stew', 'Kerala Chicken Stew features juicy chicken and a light coconut milk broth and whole spices. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'kerala', NULL, 'home-style',
  '{"lunch","dinner"}', 4, 15, 30,
  'medium', '{"family-favorite","protein-rich","meal-prep"}', '{"one-pot"}', '{}',
  'https://www.whiskaffair.com/wp-content/uploads/2023/02/Kerala-Style-Chicken-Stew-3-2.jpg', 'https://www.whiskaffair.com/kerala-style-chicken-stew-recipe/comment-page-2/', 'kerala chicken stew in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  true, 2, 'chicken',
  'main', false, 'south', '{"staple"}'
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cinnamon') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cinnamon', _ingredient_id,
  1, 'piece', NULL,
  false, 'whole spices', 13
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cloves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cloves', _ingredient_id,
  1, 'piece', NULL,
  false, 'whole spices', 15
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('potato') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'potato', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 16
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
-- Recipe 120/215: Andhra Chicken Curry
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
  'Andhra Chicken Curry', 'Andhra Chicken Curry features juicy chicken and a hot red chili and curry leaf masala. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'andhra', NULL, 'spicy home-style',
  '{"lunch","dinner"}', 4, 15, 30,
  'medium', '{"family-favorite","protein-rich","meal-prep"}', '{"one-pot"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2024/04/andhra-chicken-curry-recipe.jpg', 'https://www.indianhealthyrecipes.com/andhra-chicken-curry-recipe-kodi-kura-with-step-by-step-pictures/', 'andhra chicken curry in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  true, 2, 'chicken',
  'main', false, 'south', '{"staple"}'
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coriander leaves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coriander leaves', _ingredient_id,
  15, 'g', 'chopped',
  false, 'finish', 13
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
-- Recipe 121/215: Chicken Ghee Roast
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
  'Chicken Ghee Roast', 'Chicken Ghee Roast features juicy chicken and a deep roasted spices and glossy ghee finish. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'karnataka', NULL, 'mangalorean',
  '{"lunch","dinner"}', 4, 20, 25,
  'medium', '{"family-favorite","protein-rich","meal-prep"}', '{"one-pot"}', '{}',
  'https://myfoodstory.com/wp-content/uploads/2023/02/chicken-ghee-roast-square-2-1.jpg', 'https://myfoodstory.com/chicken-ghee-roast/', 'chicken ghee roast in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  true, 2, 'chicken',
  'main', false, 'south', '{"staple"}'
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('ghee') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'ghee', _ingredient_id,
  25, 'ml', NULL,
  false, 'cooking fat', 11
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('curry leaves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'curry leaves', _ingredient_id,
  10, 'g', NULL,
  false, 'tempering', 13
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('tamarind paste') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'tamarind paste', _ingredient_id,
  1, 'tablespoon', NULL,
  false, 'souring', 14
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
-- Recipe 122/215: Chicken Lollipop
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
  'Chicken Lollipop', 'Chicken Lollipop is a crowd-pleasing snack with crisp edges and punchy seasoning. It has the kind of bold flavor and texture that works well for sharing.', 'indo_chinese', NULL, 'party-style',
  '{"snack","dinner"}', 4, 25, 25,
  'medium', '{"tea-time","crowd-pleaser","weekend-treat"}', '{"deep-fry"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2021/12/chicken-lollipop-recipe.jpg', 'https://www.indianhealthyrecipes.com/chicken-lollipop-recipe/', 'chicken lollipop in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  false, 1, 'chicken',
  'complete', true, 'indo_chinese', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('chicken drumstick') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'chicken drumstick', _ingredient_id,
  6, 'piece', 'slashed',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('ginger garlic paste') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'ginger garlic paste', _ingredient_id,
  1, 'tablespoon', NULL,
  false, 'aromatics', 2
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('red chili powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'red chili powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 4
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
  _recipe_id, 1, 'Frenched drumsticks work best, but standard drumsticks also cook well. Marinate them with ginger garlic paste, soy sauce, chili powder, salt, and a little corn flour for 20 minutes.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Fry on medium heat until the chicken cooks through and the outer coating turns deep golden and crisp.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Rest briefly on a rack, then serve hot so the crust stays crunchy.'
);

-- -----------------------------------------------------------------------
-- Recipe 123/215: Chilli Chicken
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
  'Chilli Chicken', 'Chilli Chicken is a crowd-pleasing snack with crisp edges and punchy seasoning. It has the kind of bold flavor and texture that works well for sharing.', 'indo_chinese', NULL, 'restaurant-style',
  '{"snack","dinner"}', 4, 10, 18,
  'easy', '{"tea-time","crowd-pleaser","weekend-treat"}', '{"quick","stir-fry"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2023/12/chilli-chicken-recipe.jpg', 'https://www.indianhealthyrecipes.com/chilli-chicken-dry-recipe-indo-chinese-style/', 'chilli chicken in a serving bowl, appetizing plated food photography',
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
  _recipe_id, 1, 'Toss the chicken with corn flour and salt, then pan-sear it over medium-high heat until lightly crisp and just cooked.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Stir-fry garlic, green chili, capsicum, and spring onion in a hot wok for 2 minutes so the vegetables stay snappy.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Add soy sauce and vinegar, return the chicken to the wok, and toss for 1 minute until glossy.'
);

-- -----------------------------------------------------------------------
-- Recipe 124/215: Chicken Schezwan Fried Rice
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
  'Chicken Schezwan Fried Rice', 'Chicken Schezwan Fried Rice is a fragrant rice dish with schezwan sauce and smoky wok toss. It cooks into a complete meal that feels festive without being fussy.', 'indo_chinese', NULL, 'wok-style',
  '{"lunch","dinner"}', 4, 15, 12,
  'easy', '{"one-pot","crowd-pleaser","meal-prep"}', '{"quick","stir-fry"}', '{}',
  'https://www.vegrecipesofindia.com/wp-content/uploads/2021/02/schezwan-sauce-1.jpg', 'https://www.vegrecipesofindia.com/schezwan-sauce-recipe/', 'chicken schezwan fried rice in a handi bowl garnished with herbs, overhead food photography',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('schezwan sauce') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'schezwan sauce', _ingredient_id,
  1, 'tablespoon', NULL,
  false, 'sauce', 9
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('soy sauce') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'soy sauce', _ingredient_id,
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
  _recipe_id, 4, 'Toss on high heat for a smoky finish and serve immediately. Rest the rice off the heat for 10 minutes before fluffing gently.'
);

-- -----------------------------------------------------------------------
-- Recipe 125/215: Chicken Soup
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
  'Chicken Soup', 'Chicken Soup is a light but comforting bowl with tender chicken, vegetables, and gentle peppery warmth. It is soothing, practical, and ideal for a simple meal.', 'continental', NULL, 'home-style',
  '{"lunch","dinner"}', 4, 10, 15,
  'easy', '{"light-meal","comfort-food","quick"}', '{"quick"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2019/10/chicken-soup.jpg', 'https://www.indianhealthyrecipes.com/chicken-soup/', 'chicken soup in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  true, 2, 'chicken',
  'complete', true, 'continental', '{}'
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('ginger garlic paste') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'ginger garlic paste', _ingredient_id,
  1, 'tablespoon', NULL,
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('carrot') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'carrot', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 6
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cabbage') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cabbage', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 7
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat fat in a saucepan, add the aromatics, and cook for 3 to 4 minutes until fragrant.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Add chicken breast, seasoning, and liquid. Simmer gently for 10 to 15 minutes until the flavors meld and the vegetables or protein are tender.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Blend lightly if needed, adjust salt and pepper, then simmer for 2 more minutes before serving hot.'
);

-- -----------------------------------------------------------------------
-- Recipe 126/215: Chicken Wrap
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
  'Chicken Wrap', 'Chicken Wrap is a crowd-pleasing snack with crisp edges and punchy seasoning. It has the kind of bold flavor and texture that works well for sharing.', 'continental', NULL, 'meal-prep friendly',
  '{"breakfast","lunch","snack"}', 4, 15, 10,
  'easy', '{"tea-time","crowd-pleaser","weekend-treat"}', '{"quick"}', '{}',
  'https://images.archanaskitchen.com/images/recipes/snack-recipes/roll-recipes-wraps-frankies/Chicken_Tikka_Kathi_roll_recipe_10_2f385666a7.jpg', 'https://www.archanaskitchen.com/recipe/chicken-kathi-roll-recipe', 'chicken wrap in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  false, 1, 'chicken',
  'complete', true, 'continental', '{}'
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('chicken breast') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'chicken breast', _ingredient_id,
  550, 'g', 'cut into pieces',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('capsicum') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'capsicum', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 3
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('black pepper') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'black pepper', _ingredient_id,
  1, 'teaspoon', 'coarsely crushed',
  false, 'spice mix', 7
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Make quick flatbreads with atta, water, and salt, then cook them lightly on a hot pan and keep warm.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Cook seasoned chicken with onion and capsicum until the chicken is tender and the vegetables soften slightly.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Spread green chutney on the flatbread, add the filling, roll tightly, and serve warm.'
);

-- -----------------------------------------------------------------------
-- Recipe 127/215: Chicken Sandwich
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
  'Chicken Sandwich', 'Chicken Sandwich is a crowd-pleasing snack with crisp edges and punchy seasoning. It has the kind of bold flavor and texture that works well for sharing.', 'continental', NULL, 'cafe-style',
  '{"breakfast","snack","lunch"}', 4, 10, 10,
  'easy', '{"tea-time","crowd-pleaser","weekend-treat"}', '{"quick"}', '{}',
  'https://images.archanaskitchen.com/images/recipes/snack-recipes/sandwich-recipes/Chicken_Sandwich_with_sweet_corn_recipe_edited_7c093ad208.jpg', 'https://www.archanaskitchen.com/recipe/chicken-sandwich-with-sweet-corn-recipe', 'chicken sandwich in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  false, 1, 'chicken',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('chicken breast') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'chicken breast', _ingredient_id,
  550, 'g', 'cut into pieces',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cucumber') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cucumber', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 3
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
  _recipe_id, 1, 'Poach or pan-cook the chicken briefly, then shred it finely and season with salt and black pepper.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Butter the bread lightly and layer it with lettuce, cucumber, and the shredded chicken.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Close the sandwich, press lightly, and slice just before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 128/215: Chicken Cutlet
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
  'Chicken Cutlet', 'Chicken Cutlet is a crowd-pleasing snack with crisp edges and punchy seasoning. It has the kind of bold flavor and texture that works well for sharing.', 'continental', NULL, 'home-style',
  '{"snack","dinner"}', 4, 20, 20,
  'medium', '{"tea-time","crowd-pleaser","weekend-treat"}', '{"deep-fry"}', '{}',
  'https://images.archanaskitchen.com/images/recipes/world-recipes/continental-party-appetizer-starter-recipes/Simple_And_Easy_Chicken_Cutlet_Recipe_1_fdcb09458e.jpg', 'https://www.archanaskitchen.com/recipe/chicken-cutlet-recipe', 'chicken cutlet in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  false, 1, 'chicken',
  'complete', true, 'continental', '{}'
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
  _recipe_id, 1, 'Cook and shred the chicken, then mix it with mashed potato, green chili, garam masala, and salt into a firm cutlet mixture.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Shape into patties, dip in beaten egg, and coat well with bread crumbs.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Shallow-fry or deep-fry until crisp and evenly browned on both sides.'
);

-- -----------------------------------------------------------------------
-- Recipe 129/215: Chicken Kofta Curry
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
  'Chicken Kofta Curry', 'Chicken Kofta Curry combines tender meatball-style dumplings with a rich gravy that feels celebratory but comforting. It is savory, layered, and built for a proper dinner.', 'mughlai', NULL, 'special-occasion',
  '{"lunch","dinner"}', 4, 30, 35,
  'hard', '{"family-favorite","protein-rich","meal-prep"}', '{"one-pot"}', '{}',
  'https://images.archanaskitchen.com/images/recipes/indian/main-course/indian-non-veg-recipes/chicken-recipes/Chicken_Kofta_Curry_Makhani_recipe_2_eb99ecdf50.jpg', 'https://www.archanaskitchen.com/recipe/chicken-kofta-curry-recipe', 'chicken kofta curry in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  true, 2, 'chicken',
  'main', false, 'north', '{"staple"}'
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('bread crumbs') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'bread crumbs', _ingredient_id,
  320, 'g', NULL,
  false, 'main', 11
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('eggs') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'eggs', _ingredient_id,
  6, 'piece', NULL,
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

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Chop or grind the chicken finely, then mix it with egg, bread crumbs, salt, and spices. Shape into small koftas.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Make a rich onion-tomato gravy in a separate pan and simmer it until thick and aromatic.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Slide the koftas into the gravy and cook gently until they are fully done, then finish with cream.'
);

-- -----------------------------------------------------------------------
-- Recipe 130/215: Chicken Yakhni Pulao
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
  'Chicken Yakhni Pulao', 'Chicken Yakhni Pulao is a fragrant rice dish with brothy chicken stock and whole spices. It cooks into a complete meal that feels festive without being fussy.', 'lucknowi', NULL, 'aromatic stock-based',
  '{"lunch","dinner"}', 4, 25, 40,
  'hard', '{"one-pot","crowd-pleaser","meal-prep"}', '{"one-pot"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2026/02/yakhni-pulao-recipe.jpg', 'https://www.indianhealthyrecipes.com/yakhni-pulao/', 'chicken yakhni pulao in a handi bowl garnished with herbs, overhead food photography',
  false, false, false, false,
  true, 2, 'chicken',
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
-- Recipe 131/215: Chicken Rezala
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
  'Chicken Rezala', 'Chicken Rezala features juicy chicken and a light creamy gravy with whole spices. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'bengali', NULL, 'kolkata-style',
  '{"lunch","dinner"}', 4, 25, 35,
  'hard', '{"family-favorite","protein-rich","meal-prep"}', '{"one-pot"}', '{}',
  'https://www.whiskaffair.com/wp-content/uploads/2018/12/Bengali-Chicken-Rezala-2-2.jpg', 'https://www.whiskaffair.com/chicken-rezala/', 'chicken rezala in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  true, 2, 'chicken',
  'main', false, 'bengali', '{"staple"}'
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('kewra water') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'kewra water', _ingredient_id,
  1, 'teaspoon', NULL,
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
-- Recipe 132/215: Mughlai Chicken
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
  'Mughlai Chicken', 'Mughlai Chicken features juicy chicken and a rich onion-cashew gravy. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'mughlai', NULL, 'royal-style',
  '{"lunch","dinner"}', 4, 20, 30,
  'medium', '{"family-favorite","protein-rich","meal-prep"}', '{"one-pot"}', '{}',
  'https://www.archanaskitchen.com/logo.png', 'https://www.archanaskitchen.com/cuisine/mughlai', 'mughlai chicken in a serving bowl, appetizing plated food photography',
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
-- Recipe 133/215: Chicken Saagwala
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
  'Chicken Saagwala', 'Chicken Saagwala features juicy chicken and a spinach-based green gravy. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'north_indian', NULL, 'restaurant-style',
  '{"lunch","dinner"}', 4, 20, 25,
  'medium', '{"family-favorite","protein-rich","meal-prep"}', '{"one-pot"}', '{}',
  'https://images.archanaskitchen.com/images/recipes/indian/main-course/indian-non-veg-recipes/chicken-recipes/palak_or_spinach_chicken_or_murg_saagwala_2_ff43bda0e0.jpg', 'https://www.archanaskitchen.com/recipe/palak-chicken-curry-recipe-saag-wala-chicken', 'chicken saagwala in a serving bowl, appetizing plated food photography',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('spinach') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'spinach', _ingredient_id,
  220, 'g', 'chopped',
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
-- Recipe 134/215: Chicken Bhuna
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
  'Chicken Bhuna', 'Chicken Bhuna features juicy chicken and a reduced masala clinging closely to the chicken. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'north_indian', NULL, 'dry masala style',
  '{"lunch","dinner"}', 4, 15, 25,
  'medium', '{"family-favorite","protein-rich","meal-prep"}', '{"stir-fry"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2022/12/chicken-bhuna-recipe.jpg', 'https://www.indianhealthyrecipes.com/chicken-bhuna-masala/', 'chicken bhuna in a serving bowl, appetizing plated food photography',
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
-- Recipe 135/215: Chicken Handi
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
  'Chicken Handi', 'Chicken Handi features juicy chicken and a cooked down in a rich handi masala. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'punjabi', NULL, 'restaurant-style',
  '{"lunch","dinner"}', 4, 20, 25,
  'medium', '{"family-favorite","protein-rich","meal-prep"}', '{"one-pot"}', '{}',
  'https://myfoodstory.com/wp-content/uploads/2025/05/Chicken-Handi-3.jpg', 'https://myfoodstory.com/chicken-handi/', 'chicken handi in a serving bowl, appetizing plated food photography',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('kasuri methi') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'kasuri methi', _ingredient_id,
  1, 'teaspoon', 'crushed',
  false, 'finish', 13
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
-- Recipe 136/215: Chicken Kosha
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
  'Chicken Kosha', 'Chicken Kosha features juicy chicken and a dark caramelized masala. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'bengali', NULL, 'slow bhuna',
  '{"lunch","dinner"}', 4, 20, 35,
  'medium', '{"family-favorite","protein-rich","meal-prep"}', '{"one-pot"}', '{}',
  '/images/recipes/chicken-kosha.png', 'https://www.indianhealthyrecipes.com/chicken-biryani-recipe/', 'chicken kosha in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  true, 2, 'chicken',
  'main', false, 'bengali', '{"staple"}'
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('potato') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'potato', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 11
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
-- Recipe 137/215: Chicken Cafreal
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
  'Chicken Cafreal', 'Chicken Cafreal features juicy chicken and a herby green chili-coriander marinade. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'goan', NULL, 'green masala',
  '{"lunch","dinner"}', 4, 20, 30,
  'medium', '{"family-favorite","protein-rich","meal-prep"}', '{"one-pot"}', '{}',
  'https://www.whiskaffair.com/wp-content/uploads/2022/09/Chicken-Cafreal-2-3.jpg', 'https://www.whiskaffair.com/goan-chicken-cafreal-recipe/', 'chicken cafreal in a serving bowl, appetizing plated food photography',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('mint leaves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'mint leaves', _ingredient_id,
  15, 'g', 'chopped',
  false, 'finish', 12
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('vinegar') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'vinegar', _ingredient_id,
  1, 'tablespoon', NULL,
  false, 'sauce', 13
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
  _recipe_id, 2, 'Stir in the ground spices, then add the chicken. Cook for 3 to 4 minutes so the masala coats everything evenly and loses any raw edge.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Add water or other liquid as needed, cover, and simmer on medium heat until the main ingredient is cooked through and the gravy thickens.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 4, 'Finish with herbs or dairy as needed and simmer very gently so the chicken stays tender. Simmer for 2 more minutes, then rest the dish for 5 minutes before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 138/215: Chicken Malai Tikka
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
  'Chicken Malai Tikka', 'Chicken Malai Tikka features juicy chicken and a creamy mild marinade and smoky finish. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'mughlai', NULL, 'cream-marinated',
  '{"lunch","dinner"}', 4, 25, 35,
  'hard', '{"family-favorite","protein-rich","meal-prep"}', '{"grill / tandoor","weekend-project"}', '{}',
  '/images/recipes/chicken-malai-tikka.png', 'https://www.whiskaffair.com/chicken-tikka/', 'chicken malai tikka in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  true, 2, 'chicken',
  'complete', true, 'north', '{}'
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cheese') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cheese', _ingredient_id,
  120, 'g', 'grated',
  false, 'finish', 13
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('white pepper') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'white pepper', _ingredient_id,
  0.5, 'teaspoon', NULL,
  false, 'finish', 14
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
-- Recipe 139/215: Tandoori Chicken Drumsticks
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
  'Tandoori Chicken Drumsticks', 'Tandoori Chicken Drumsticks features juicy chicken and a spiced yogurt marinade on drumsticks. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'punjabi', NULL, 'tandoor-style',
  '{"lunch","dinner"}', 4, 20, 40,
  'hard', '{"family-favorite","protein-rich","meal-prep"}', '{"grill / tandoor","weekend-project"}', '{}',
  '/images/recipes/tandoori-chicken-drumsticks.png', 'https://www.indianhealthyrecipes.com/chicken-biryani-recipe/', 'tandoori chicken drumsticks in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  true, 2, 'chicken',
  'complete', true, 'north', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('chicken drumstick') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'chicken drumstick', _ingredient_id,
  6, 'piece', 'slashed',
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
  _recipe_id, 4, 'Finish with herbs or dairy as needed and simmer very gently so the chicken stays tender. Simmer for 2 more minutes, then rest the dish for 5 minutes before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 140/215: Chicken Shawarma Wrap
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
  'Chicken Shawarma Wrap', 'Chicken Shawarma Wrap is a crowd-pleasing snack with crisp edges and punchy seasoning. It has the kind of bold flavor and texture that works well for sharing.', 'arabian', NULL, 'street-style',
  '{"lunch","snack","dinner"}', 4, 20, 20,
  'medium', '{"tea-time","crowd-pleaser","weekend-treat"}', '{"stir-fry"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2023/05/chicken-shawarma-recipe.jpg', 'https://www.indianhealthyrecipes.com/chicken-shawarma/', 'chicken shawarma wrap in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  false, 1, 'chicken',
  'complete', true, 'arabian', '{}'
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('chicken breast') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'chicken breast', _ingredient_id,
  550, 'g', 'cut into pieces',
  false, 'main', 1
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('curd') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'curd', _ingredient_id,
  120, 'g', 'whisked',
  false, 'main', 2
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('coriander powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'coriander powder', _ingredient_id,
  2, 'teaspoon', NULL,
  false, 'spice mix', 4
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('lettuce') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'lettuce', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 6
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cucumber') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cucumber', _ingredient_id,
  220, 'g', 'chopped',
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
  _recipe_id, 1, 'Marinate the chicken with curd, cumin powder, coriander powder, black pepper, salt, and a little oil for 20 minutes.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Cook the marinated chicken in a hot pan until browned and fully cooked, then slice it thinly.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Wrap the chicken with lettuce and cucumber in a soft atta flatbread and serve while warm.'
);

-- -----------------------------------------------------------------------
-- Recipe 141/215: Chicken Clear Soup
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
  'Chicken Clear Soup', 'Chicken Clear Soup is clean, peppery, and soothing, with tender chicken and lightly cooked vegetables. It is simple enough for a weekday and restorative when you want something light.', 'continental', NULL, 'light meal',
  '{"breakfast","lunch","dinner"}', 4, 10, 15,
  'easy', '{"light-meal","comfort-food","quick"}', '{"quick"}', '{}',
  'https://www.whiskaffair.com/wp-content/uploads/2016/08/Clear-Chicken-Soup-2-2.jpg', 'https://www.whiskaffair.com/clear-chicken-soup/', 'chicken clear soup in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  true, 2, 'chicken',
  'complete', true, 'continental', '{}'
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('ginger garlic paste') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'ginger garlic paste', _ingredient_id,
  1, 'tablespoon', NULL,
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('carrot') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'carrot', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 6
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cabbage') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cabbage', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 7
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('spring onion') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'spring onion', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 8
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat fat in a saucepan, add the aromatics, and cook for 3 to 4 minutes until fragrant.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Add chicken breast, seasoning, and liquid. Simmer gently for 10 to 15 minutes until the flavors meld and the vegetables or protein are tender.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Blend lightly if needed, adjust salt and pepper, then simmer for 2 more minutes before serving hot.'
);

-- -----------------------------------------------------------------------
-- Recipe 142/215: Chicken Salad
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
  'Chicken Salad', 'Chicken Salad brings together lean chicken, crisp vegetables, and bright seasoning for a practical lighter meal. It tastes fresh, savory, and nicely balanced.', 'continental', NULL, 'light lunch',
  '{"breakfast","lunch"}', 4, 15, 0,
  'easy', '{"light-meal","fresh","quick"}', '{"no-cook"}', '{}',
  '/images/recipes/chicken-salad.png', 'https://www.indianhealthyrecipes.com/chicken-biryani-recipe/', 'chicken salad in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  false, 1, 'chicken',
  'complete', true, 'continental', '{}'
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
-- Recipe 143/215: Chicken Seekh Kebab
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
  'Chicken Seekh Kebab', 'Chicken Seekh Kebab is a crowd-pleasing snack with crisp edges and punchy seasoning. It has the kind of bold flavor and texture that works well for sharing.', 'mughlai', NULL, 'kebab-house style',
  '{"snack","dinner"}', 4, 30, 30,
  'hard', '{"tea-time","crowd-pleaser","weekend-treat"}', '{"grill / tandoor","weekend-project"}', '{}',
  '/images/recipes/chicken-seekh-kebab.png', 'https://www.indianhealthyrecipes.com/chicken-biryani-recipe/', 'chicken seekh kebab in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  false, 1, 'chicken',
  'complete', true, 'north', '{}'
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
  _recipe_id, 1, 'Finely chop or mince the chicken, then mix it with onion, green chili, ginger garlic paste, bread crumbs, salt, and garam masala until cohesive.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Shape the mixture tightly around skewers or into logs and chill for 15 minutes so it firms up.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Grill or pan-sear the kebabs, turning often, until cooked through and charred in spots.'
);

-- -----------------------------------------------------------------------
-- Recipe 144/215: Chicken Pakora
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
  'Chicken Pakora', 'Chicken Pakora is a crowd-pleasing snack with crisp edges and punchy seasoning. It has the kind of bold flavor and texture that works well for sharing.', 'street_food', NULL, 'tea-time style',
  '{"snack"}', 4, 20, 20,
  'medium', '{"tea-time","crowd-pleaser","weekend-treat"}', '{"deep-fry"}', '{}',
  'https://www.whiskaffair.com/wp-content/uploads/2021/04/Chicken-Pakora-2-2.jpg', 'https://www.whiskaffair.com/chicken-pakora-recipe/', 'chicken pakora in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  false, 1, 'chicken',
  'complete', true, 'street', '{}'
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('ginger garlic paste') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'ginger garlic paste', _ingredient_id,
  1, 'tablespoon', NULL,
  false, 'aromatics', 2
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
  _recipe_id, 1, 'Mix chicken with besan, ginger garlic paste, chili, salt, and just enough water to make a clingy coating.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Drop small clusters into medium-hot oil and fry until crisp outside and cooked through inside.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Drain well and serve hot while the crust stays crunchy.'
);

-- -----------------------------------------------------------------------
-- Recipe 145/215: Chicken Coconut Curry
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
  'Chicken Coconut Curry', 'Chicken Coconut Curry features juicy chicken and a coconut milk and curry leaves. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'kerala', NULL, 'home-style',
  '{"lunch","dinner"}', 4, 15, 25,
  'medium', '{"family-favorite","protein-rich","meal-prep"}', '{"one-pot"}', '{}',
  '/images/recipes/chicken-coconut-curry.png', 'https://www.indianhealthyrecipes.com/chicken-biryani-recipe/', 'chicken coconut curry in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  true, 2, 'chicken',
  'main', false, 'south', '{"staple"}'
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('black pepper') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'black pepper', _ingredient_id,
  1, 'teaspoon', 'coarsely crushed',
  false, 'spice mix', 13
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
-- Recipe 146/215: Chicken Do Pyaza
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
  'Chicken Do Pyaza', 'Chicken Do Pyaza features juicy chicken and a double onion sweetness and rich masala. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'north_indian', NULL, 'dhaba-style',
  '{"lunch","dinner"}', 4, 15, 25,
  'medium', '{"family-favorite","protein-rich","meal-prep"}', '{"one-pot"}', '{}',
  '/images/recipes/chicken-do-pyaza.png', 'https://www.indianhealthyrecipes.com/chicken-biryani-recipe/', 'chicken do pyaza in a serving bowl, appetizing plated food photography',
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
  _recipe_id, 2, 'Stir in the ground spices, then add the chicken. Cook for 3 to 4 minutes so the masala coats everything evenly and loses any raw edge.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Add water or other liquid as needed, cover, and simmer on medium heat until the main ingredient is cooked through and the gravy thickens.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 4, 'Finish with herbs or dairy as needed and simmer very gently so the chicken stays tender. Simmer for 2 more minutes, then rest the dish for 5 minutes before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 147/215: Egg Curry
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
  'Egg Curry', 'Egg Curry features boiled eggs in onion-tomato masala. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'north_indian', NULL, 'home-style',
  '{"breakfast","lunch","dinner"}', 4, 15, 25,
  'medium', '{"protein-rich","quick","budget-friendly"}', '{"one-pot"}', '{}',
  'https://myfoodstory.com/wp-content/uploads/2015/08/egg-curry-my-nanas-recipe.1024x1024.jpg', 'https://myfoodstory.com/egg-curry-my-nanas-recipe/', 'egg curry in a serving bowl, appetizing plated food photography',
  false, false, true, false,
  true, 1, 'egg',
  'main', false, 'north', '{"staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('eggs') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'eggs', _ingredient_id,
  6, 'piece', NULL,
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('garam masala') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'garam masala', _ingredient_id,
  1, 'teaspoon', NULL,
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

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat oil in a heavy pan over medium heat. Add the aromatics and cook for 6 to 8 minutes until they soften and smell sweet.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Stir in the ground spices, then add the eggs. Cook for 3 to 4 minutes so the masala coats everything evenly and loses any raw edge.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Add water or other liquid as needed, cover, and simmer on medium heat until the main ingredient is cooked through and the gravy thickens.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 4, 'Cut or fold the eggs in gently at the end so they stay intact and well coated. Simmer for 2 more minutes, then rest the dish for 5 minutes before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 148/215: Egg Biryani
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
  'Egg Biryani', 'Egg Biryani is a fragrant rice dish with spiced eggs layered with fragrant rice. It cooks into a complete meal that feels festive without being fussy.', 'hyderabadi', NULL, 'dum-style',
  '{"lunch","dinner"}', 4, 25, 40,
  'hard', '{"one-pot","crowd-pleaser","meal-prep"}', '{"one-pot"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2019/05/egg-biryani.jpg', 'https://www.indianhealthyrecipes.com/egg-biryani-recipe-how-to-make-easy-egg-biryani/', 'egg biryani in a handi bowl garnished with herbs, overhead food photography',
  false, false, true, false,
  true, 2, 'egg',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('eggs') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'eggs', _ingredient_id,
  6, 'piece', NULL,
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
  _recipe_id, 4, 'Fluff the rice gently and finish with herbs before serving. Rest the rice off the heat for 10 minutes before fluffing gently.'
);

-- -----------------------------------------------------------------------
-- Recipe 149/215: Egg Bhurji
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
  'Egg Bhurji', 'Egg Bhurji features soft scrambled eggs with masala. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'street_food', NULL, 'quick skillet',
  '{"breakfast","lunch","dinner"}', 4, 10, 12,
  'easy', '{"protein-rich","quick","budget-friendly"}', '{"quick","stir-fry"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2023/01/egg-bhurji-recipe.jpg', 'https://www.indianhealthyrecipes.com/egg-bhurji-andhra-egg-porutu/', 'egg bhurji in a serving bowl, appetizing plated food photography',
  false, false, true, false,
  true, 1, 'egg',
  'complete', true, 'street', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('eggs') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'eggs', _ingredient_id,
  6, 'piece', NULL,
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('garam masala') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'garam masala', _ingredient_id,
  1, 'teaspoon', NULL,
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

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Whisk the eggs lightly with salt so they stay soft when cooked.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Saute onion, tomato, green chili, and spices until the base turns slightly jammy.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Pour in the eggs and stir gently on low heat until softly set, then finish with coriander leaves.'
);

-- -----------------------------------------------------------------------
-- Recipe 150/215: Anda Ghotala
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
  'Anda Ghotala', 'Anda Ghotala features scrambled and boiled eggs in spicy masala. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'street_food', NULL, 'mumbai-style',
  '{"breakfast","snack","dinner"}', 4, 15, 20,
  'medium', '{"protein-rich","quick","budget-friendly"}', '{"one-pot"}', '{}',
  '/images/recipes/anda-ghotala.png', 'https://www.archanaskitchen.com/cuisine/mughlai', 'anda ghotala in a serving bowl, appetizing plated food photography',
  false, false, true, false,
  true, 1, 'egg',
  'complete', true, 'street', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('eggs') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'eggs', _ingredient_id,
  6, 'piece', NULL,
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('garam masala') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'garam masala', _ingredient_id,
  1, 'teaspoon', NULL,
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('butter') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'butter', _ingredient_id,
  25, 'g', NULL,
  false, 'cooking fat', 9
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
  _recipe_id, 1, 'Cook a rich onion-tomato masala with butter and spices until the oil begins to separate.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Scramble some of the eggs directly into the masala, keeping them soft and moist.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Grate or chop boiled eggs over the top, fold once, and finish with coriander before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 151/215: Egg Bhurji Sandwich
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
  'Egg Bhurji Sandwich', 'Egg Bhurji Sandwich is a crowd-pleasing snack with crisp edges and punchy seasoning. It has the kind of bold flavor and texture that works well for sharing.', 'street_food', NULL, 'breakfast-style',
  '{"breakfast","snack","lunch"}', 4, 10, 10,
  'easy', '{"tea-time","crowd-pleaser","weekend-treat"}', '{"quick"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2022/09/egg-sandwich-recipe.jpg', 'https://www.indianhealthyrecipes.com/egg-sandwich-recipe/', 'egg bhurji sandwich in a serving bowl, appetizing plated food photography',
  false, false, true, false,
  false, 1, 'egg',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('eggs') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'eggs', _ingredient_id,
  6, 'piece', NULL,
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('butter') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'butter', _ingredient_id,
  25, 'g', NULL,
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('black pepper') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'black pepper', _ingredient_id,
  1, 'teaspoon', 'coarsely crushed',
  false, 'spice mix', 7
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Cook the egg bhurji quickly with onion, tomato, green chili, salt, and black pepper until softly set.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Butter the bread lightly and spread the hot bhurji evenly between two slices.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Toast lightly if desired, then cut and serve while still warm.'
);

-- -----------------------------------------------------------------------
-- Recipe 152/215: Egg Fried Rice
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
  'Egg Fried Rice', 'Egg Fried Rice is a fragrant rice dish with scrambled egg and smoky rice. It cooks into a complete meal that feels festive without being fussy.', 'indo_chinese', NULL, 'wok-style',
  '{"lunch","dinner"}', 4, 15, 12,
  'easy', '{"one-pot","crowd-pleaser","meal-prep"}', '{"quick","stir-fry"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2021/07/egg-fried-rice-recipe.jpg', 'https://www.indianhealthyrecipes.com/egg-fried-rice/', 'egg fried rice in a handi bowl garnished with herbs, overhead food photography',
  false, false, true, false,
  true, 2, 'egg',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('eggs') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'eggs', _ingredient_id,
  6, 'piece', NULL,
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
  _recipe_id, 2, 'Saute the aromatics in fat, add the eggs, vegetables, and sauces, and cook for 3 to 4 minutes so the mixture becomes fragrant and lightly glossy.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Stir in the rice and measured water, bring the pot to a boil, then cover and cook on low heat until the grains are tender.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 4, 'Toss over high heat until the eggs break into soft ribbons through the rice. Rest the rice off the heat for 10 minutes before fluffing gently.'
);

-- -----------------------------------------------------------------------
-- Recipe 153/215: Egg Roast
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
  'Egg Roast', 'Egg Roast features boiled eggs in dark onion masala. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'kerala', NULL, 'home-style',
  '{"breakfast","lunch","dinner"}', 4, 15, 25,
  'medium', '{"protein-rich","quick","budget-friendly"}', '{"one-pot"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2022/05/egg-roast-recipe.jpg', 'https://www.indianhealthyrecipes.com/egg-roast-recipe/', 'egg roast in a serving bowl, appetizing plated food photography',
  false, false, true, false,
  true, 1, 'egg',
  'main', false, 'south', '{"staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('eggs') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'eggs', _ingredient_id,
  6, 'piece', NULL,
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('garam masala') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'garam masala', _ingredient_id,
  1, 'teaspoon', NULL,
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('curry leaves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'curry leaves', _ingredient_id,
  10, 'g', NULL,
  false, 'tempering', 9
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

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat oil in a heavy pan over medium heat. Add the aromatics and cook for 6 to 8 minutes until they soften and smell sweet.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Stir in the ground spices, then add the eggs. Cook for 3 to 4 minutes so the masala coats everything evenly and loses any raw edge.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Add water or other liquid as needed, cover, and simmer on medium heat until the main ingredient is cooked through and the gravy thickens.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 4, 'Cut or fold the eggs in gently at the end so they stay intact and well coated. Simmer for 2 more minutes, then rest the dish for 5 minutes before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 154/215: Egg Pepper Fry
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
  'Egg Pepper Fry', 'Egg Pepper Fry features boiled eggs with cracked pepper and curry leaves. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'south_indian', NULL, 'quick skillet',
  '{"breakfast","lunch","dinner"}', 4, 10, 15,
  'easy', '{"protein-rich","quick","budget-friendly"}', '{"quick","stir-fry"}', '{}',
  '/images/recipes/egg-pepper-fry.png', 'https://www.archanaskitchen.com/cuisine/mughlai', 'egg pepper fry in a serving bowl, appetizing plated food photography',
  false, false, true, false,
  true, 1, 'egg',
  'main', false, 'south', '{"staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('eggs') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'eggs', _ingredient_id,
  6, 'piece', NULL,
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('garam masala') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'garam masala', _ingredient_id,
  1, 'teaspoon', NULL,
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('black pepper') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'black pepper', _ingredient_id,
  1, 'teaspoon', 'coarsely crushed',
  false, 'spice mix', 9
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('curry leaves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'curry leaves', _ingredient_id,
  10, 'g', NULL,
  false, 'tempering', 10
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat oil in a heavy pan over medium heat. Add the aromatics and cook for 6 to 8 minutes until they soften and smell sweet.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Stir in the ground spices, then add the eggs. Cook for 3 to 4 minutes so the masala coats everything evenly and loses any raw edge.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Add water or other liquid as needed, cover, and simmer on medium heat until the main ingredient is cooked through and the gravy thickens.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 4, 'Cut or fold the eggs in gently at the end so they stay intact and well coated. Simmer for 2 more minutes, then rest the dish for 5 minutes before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 155/215: Masala Omelette
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
  'Masala Omelette', 'Masala Omelette features soft omelette with onion, chili, and herbs. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'street_food', NULL, 'breakfast-stall',
  '{"breakfast","snack"}', 4, 10, 10,
  'easy', '{"protein-rich","quick","budget-friendly"}', '{"quick"}', '{}',
  '/images/recipes/masala-omelette.png', 'https://www.archanaskitchen.com/cuisine/mughlai', 'masala omelette in a serving bowl, appetizing plated food photography',
  false, false, true, false,
  true, 1, 'egg',
  'complete', true, 'street', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('eggs') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'eggs', _ingredient_id,
  6, 'piece', NULL,
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('black pepper') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'black pepper', _ingredient_id,
  1, 'teaspoon', 'coarsely crushed',
  false, 'spice mix', 6
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Whisk the eggs with salt and black pepper until frothy, then stir in onion, green chili, and coriander leaves.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Pour into a lightly oiled hot pan and cook on medium-low heat until the underside sets and the top looks almost dry.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Fold the omelette and cook for 30 seconds more before serving immediately.'
);

-- -----------------------------------------------------------------------
-- Recipe 156/215: Egg Masala Fry
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
  'Egg Masala Fry', 'Egg Masala Fry features boiled eggs finished in dry masala. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'south_indian', NULL, 'spice-coated',
  '{"breakfast","lunch","dinner"}', 4, 10, 18,
  'easy', '{"protein-rich","quick","budget-friendly"}', '{"stir-fry"}', '{}',
  '/images/recipes/egg-masala-fry.png', 'https://www.archanaskitchen.com/cuisine/mughlai', 'egg masala fry in a serving bowl, appetizing plated food photography',
  false, false, true, false,
  true, 1, 'egg',
  'main', false, 'south', '{"staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('eggs') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'eggs', _ingredient_id,
  6, 'piece', NULL,
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('garam masala') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'garam masala', _ingredient_id,
  1, 'teaspoon', NULL,
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('curry leaves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'curry leaves', _ingredient_id,
  10, 'g', NULL,
  false, 'tempering', 9
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

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat oil in a heavy pan over medium heat. Add the aromatics and cook for 6 to 8 minutes until they soften and smell sweet.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Stir in the ground spices, then add the eggs. Cook for 3 to 4 minutes so the masala coats everything evenly and loses any raw edge.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Add water or other liquid as needed, cover, and simmer on medium heat until the main ingredient is cooked through and the gravy thickens.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 4, 'Cut or fold the eggs in gently at the end so they stay intact and well coated. Simmer for 2 more minutes, then rest the dish for 5 minutes before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 157/215: Egg Pulao
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
  'Egg Pulao', 'Egg Pulao is a fragrant rice dish with soft boiled eggs and warm whole spices. It cooks into a complete meal that feels festive without being fussy.', 'north_indian', NULL, 'home-style',
  '{"lunch","dinner"}', 4, 15, 25,
  'medium', '{"one-pot","crowd-pleaser","meal-prep"}', '{"one-pot"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2022/07/egg-pulao-recipe.jpg', 'https://www.indianhealthyrecipes.com/egg-pulao-recipe-how-to-make-easy-egg-pulao-in-pressure-cooker/', 'egg pulao in a handi bowl garnished with herbs, overhead food photography',
  false, false, true, false,
  true, 2, 'egg',
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('eggs') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'eggs', _ingredient_id,
  6, 'piece', NULL,
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
-- Recipe 158/215: Andhra Egg Curry
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
  'Andhra Egg Curry', 'Andhra Egg Curry features boiled eggs in fiery red gravy. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'andhra', NULL, 'spicy home-style',
  '{"breakfast","lunch","dinner"}', 4, 15, 25,
  'medium', '{"protein-rich","quick","budget-friendly"}', '{"one-pot"}', '{}',
  '/images/recipes/andhra-egg-curry.png', 'https://www.archanaskitchen.com/cuisine/mughlai', 'andhra egg curry in a serving bowl, appetizing plated food photography',
  false, false, true, false,
  true, 1, 'egg',
  'main', false, 'south', '{"staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('eggs') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'eggs', _ingredient_id,
  6, 'piece', NULL,
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('garam masala') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'garam masala', _ingredient_id,
  1, 'teaspoon', NULL,
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('kashmiri chili powder') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'kashmiri chili powder', _ingredient_id,
  1, 'teaspoon', NULL,
  false, 'spice mix', 9
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('curry leaves') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'curry leaves', _ingredient_id,
  10, 'g', NULL,
  false, 'tempering', 10
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat oil in a heavy pan over medium heat. Add the aromatics and cook for 6 to 8 minutes until they soften and smell sweet.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Stir in the ground spices, then add the eggs. Cook for 3 to 4 minutes so the masala coats everything evenly and loses any raw edge.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Add water or other liquid as needed, cover, and simmer on medium heat until the main ingredient is cooked through and the gravy thickens.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 4, 'Cut or fold the eggs in gently at the end so they stay intact and well coated. Simmer for 2 more minutes, then rest the dish for 5 minutes before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 159/215: Egg Drop Soup
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
  'Egg Drop Soup', 'Egg Drop Soup is a light, savory broth with silky ribbons of egg and a clean peppery finish. It is quick, warming, and easy to pair with other dishes.', 'indo_chinese', NULL, 'quick bowl',
  '{"breakfast","lunch","dinner"}', 4, 10, 10,
  'easy', '{"light-meal","comfort-food","quick"}', '{"quick"}', '{}',
  'https://myfoodstory.com/wp-content/uploads/2024/12/Egg-Drop-Soup-Only-15-Mins-2.jpg', 'https://myfoodstory.com/egg-drop-soup/', 'egg drop soup in a serving bowl, appetizing plated food photography',
  false, true, true, false,
  true, 2, 'egg',
  'complete', true, 'indo_chinese', '{}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('egg white') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'egg white', _ingredient_id,
  4, 'piece', NULL,
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('ginger garlic paste') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'ginger garlic paste', _ingredient_id,
  1, 'tablespoon', NULL,
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('spring onion') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'spring onion', _ingredient_id,
  220, 'g', 'chopped',
  false, 'main', 6
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Bring the seasoned broth to a gentle simmer with spring onion and black pepper.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Whisk the egg whites lightly, then pour them in a thin stream while stirring the soup in one direction.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Cook for 30 seconds more until delicate ribbons form, then serve right away.'
);

-- -----------------------------------------------------------------------
-- Recipe 160/215: Egg Korma
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
  'Egg Korma', 'Egg Korma features eggs in creamy cashew-curd sauce. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'mughlai', NULL, 'rich gravy',
  '{"breakfast","lunch","dinner"}', 4, 15, 25,
  'medium', '{"protein-rich","quick","budget-friendly"}', '{"one-pot"}', '{}',
  '/images/recipes/egg-korma.png', 'https://www.archanaskitchen.com/cuisine/mughlai', 'egg korma in a serving bowl, appetizing plated food photography',
  false, false, true, false,
  true, 1, 'egg',
  'main', false, 'north', '{"staple"}'
) RETURNING id INTO _recipe_id;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('eggs') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'eggs', _ingredient_id,
  6, 'piece', NULL,
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('garam masala') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'garam masala', _ingredient_id,
  1, 'teaspoon', NULL,
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('curd') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'curd', _ingredient_id,
  120, 'g', 'whisked',
  false, 'main', 9
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cream') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cream', _ingredient_id,
  80, 'ml', NULL,
  false, 'finish', 10
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('cashews') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'cashews', _ingredient_id,
  40, 'g', NULL,
  false, 'finish', 11
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

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat oil in a heavy pan over medium heat. Add the aromatics and cook for 6 to 8 minutes until they soften and smell sweet.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Stir in the ground spices, then add the eggs. Cook for 3 to 4 minutes so the masala coats everything evenly and loses any raw edge.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Add water or other liquid as needed, cover, and simmer on medium heat until the main ingredient is cooked through and the gravy thickens.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 4, 'Cut or fold the eggs in gently at the end so they stay intact and well coated. Simmer for 2 more minutes, then rest the dish for 5 minutes before serving.'
);

-- -----------------------------------------------------------------------
-- Recipe 161/215: Mughlai Paratha
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
  'Mughlai Paratha', 'Mughlai Paratha is a crowd-pleasing snack with crisp edges and punchy seasoning. It has the kind of bold flavor and texture that works well for sharing.', 'street_food', NULL, 'kolkata-style',
  '{"breakfast","snack","dinner"}', 4, 25, 40,
  'hard', '{"tea-time","crowd-pleaser","weekend-treat"}', '{"deep-fry","weekend-project"}', '{}',
  '/images/recipes/mughlai-paratha.png', 'https://www.archanaskitchen.com/cuisine/mughlai', 'mughlai paratha in a serving bowl, appetizing plated food photography',
  false, false, true, false,
  false, 1, 'egg',
  'complete', true, 'street', '{}'
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('eggs') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'eggs', _ingredient_id,
  6, 'piece', NULL,
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
  _recipe_id, 1, 'Knead maida with water, salt, and a little oil into a smooth dough. Rest it for 20 minutes so it stretches easily.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Roll the dough thin, pour over the whisked egg mixture with onion, green chili, salt, and black pepper, then fold it into a square parcel.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Shallow-fry on medium heat until both sides turn crisp and deeply golden while the egg filling cooks through.'
);

-- -----------------------------------------------------------------------
-- Recipe 162/215: Fish Fry
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
  'Fish Fry', 'Fish Fry features quick fish with a crisp masala crust. The finished dish tastes deeply spiced, balanced, and especially satisfying with rice or flatbread.', 'street_food', NULL, 'spice-crusted',
  '{"lunch","dinner"}', 4, 15, 15,
  'easy', '{"seafood","family-favorite","meal-prep"}', '{"stir-fry"}', '{}',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2015/03/fish-fry-1.jpg', 'https://www.indianhealthyrecipes.com/fish-fry-recipe/', 'fish fry in a serving bowl, appetizing plated food photography',
  false, false, false, false,
  true, 1, 'fish',
  'main', false, 'street', '{"staple"}'
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

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('lemon juice') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'lemon juice', _ingredient_id,
  1, 'tablespoon', NULL,
  false, 'finish', 10
);
_ingredient_id := NULL;

SELECT id INTO _ingredient_id FROM global_ingredients WHERE LOWER(name) = LOWER('rice flour') LIMIT 1;
INSERT INTO global_recipe_ingredients (
  global_recipe_id, ingredient_name, global_ingredient_id,
  quantity, unit, preparation, is_optional, group_name, sort_order
) VALUES (
  _recipe_id, 'rice flour', _ingredient_id,
  320, 'g', NULL,
  false, 'main', 11
);
_ingredient_id := NULL;

INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 1, 'Heat oil in a wide skillet and bloom the tempering ingredients for 30 seconds. Add the base ingredients and cook for 4 to 5 minutes until lightly softened.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 2, 'Add the fish fillet with the spice powders and salt. Toss well, then cook uncovered on medium heat until the vegetables or protein are just tender.'
);
INSERT INTO global_recipe_steps (global_recipe_id, step_number, instruction) VALUES (
  _recipe_id, 3, 'Squeeze over citrus if using and serve immediately while the outside stays crisp. Cook for 2 more minutes so the masala clings to the ingredients instead of pooling in the pan.'
);

-- -----------------------------------------------------------------------
END $$;
