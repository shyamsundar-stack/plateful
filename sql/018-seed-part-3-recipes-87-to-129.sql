-- Plateful seed part 3: recipes 87-129
-- Run AFTER part 2

DO $$
DECLARE
  _recipe_id UUID;
  _ingredient_id UUID;
BEGIN

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

END $$;
