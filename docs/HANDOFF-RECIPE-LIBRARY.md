# Handoff Prompt: Generate 200 Curated Recipes for Plateful Global Library

## YOUR TASK
Generate exactly 200 curated recipes for an Indian/Asian-focused meal planning app called Plateful. Output a single JSON file (`global-recipes.json`) that our system will import directly.

## OUTPUT FORMAT
A single JSON file with this exact structure:

```json
{
  "metadata": {
    "version": "1.0",
    "generated_at": "2026-03-18T00:00:00Z",
    "total_recipes": 200,
    "veg_count": 100,
    "non_veg_count": 100
  },
  "recipes": [
    {
      "title": "Chicken Biryani",
      "description": "Fragrant basmati rice layered with spiced chicken, slow-cooked to perfection. A Hyderabadi classic.",
      "cuisine": "north_indian",
      "cuisine_region": "hyderabadi",
      "meal_types": ["lunch", "dinner"],
      "servings": 4,
      "prep_time_min": 30,
      "cook_time_min": 45,
      "difficulty": "medium",
      "tags": ["one-pot", "weekend-project", "crowd-pleaser"],
      "is_vegetarian": false,
      "is_vegan": false,
      "is_eggetarian": false,
      "is_jain": false,
      "is_batch_friendly": true,
      "leftover_days": 2,
      "cooking_style": ["slow-cook", "layered"],
      "protein_category": "chicken",
      "source_url": "https://example.com/chicken-biryani-recipe",
      "image_url": "https://example.com/images/chicken-biryani.jpg",
      "image_search_query": "hyderabadi chicken biryani served in white bowl garnished with fried onions and mint",
      "ingredients": [
        {
          "name": "chicken thigh",
          "quantity": 500,
          "unit": "g",
          "preparation": "cut into pieces",
          "group_name": "chicken marinade",
          "is_optional": false
        },
        {
          "name": "basmati rice",
          "quantity": 400,
          "unit": "g",
          "preparation": "soaked 30 min",
          "group_name": "rice",
          "is_optional": false
        },
        {
          "name": "onion",
          "quantity": 300,
          "unit": "g",
          "preparation": "thinly sliced",
          "group_name": "base",
          "is_optional": false
        }
      ],
      "steps": [
        {
          "step_number": 1,
          "instruction": "Marinate chicken with curd, turmeric, red chili powder, garam masala, and salt for 30 minutes."
        },
        {
          "step_number": 2,
          "instruction": "Soak basmati rice in water for 30 minutes, then parboil with whole spices until 70% cooked. Drain."
        }
      ]
    }
  ]
}
```

## CRITICAL CONSTRAINTS

### 1. Ingredient Names — MUST Match Exactly
Every ingredient `name` field MUST use one of the exact names from our ingredient catalog below. Do NOT use synonyms, alternate spellings, or brand names. If a recipe needs an ingredient not in our list, use the closest match OR add it to an `"unmapped_ingredients"` array on that recipe (our system will create these during import).

**EXACT ingredient names (use these and ONLY these):**

**Proteins — Meat/Poultry/Seafood/Eggs:**
chicken breast, chicken thigh, chicken drumstick, chicken whole, mutton, lamb, prawns, fish fillet, pomfret, rohu, surmai, eggs, egg white, paneer, tofu, soya chunks, soya granules

**Legumes:**
toor dal, moong dal, masoor dal, chana dal, urad dal, whole moong, whole masoor, whole urad, chickpeas, rajma, black eyed peas, peanuts, dried green peas

**Dairy:**
milk, curd, buttermilk, ghee, butter, cream, cheese, mozzarella, condensed milk, khoya

**Grains & Flour:**
basmati rice, brown rice, atta, maida, besan, rice flour, semolina, poha, oats, bread, vermicelli, dosa batter, idli batter, quinoa, ragi flour, jowar flour, bajra flour, corn flour, bread crumbs

**Vegetables:**
onion, tomato, potato, garlic, ginger, green chili, capsicum, cauliflower, cabbage, spinach, methi leaves, coriander leaves, mint leaves, curry leaves, brinjal, okra, bottle gourd, ridge gourd, bitter gourd, snake gourd, drumstick, pumpkin, carrot, beetroot, radish, green beans, peas, corn, mushroom, sweet potato, raw banana, cluster beans, tinda, spring onion, lettuce, cucumber, zucchini, broccoli, baby corn, ivy gourd, yam, colocasia, jackfruit raw, banana stem, banana flower

**Fruits:**
lemon, lime, tamarind, raw mango, coconut fresh, coconut dried, banana ripe, dates, raisins, pomegranate, pineapple, mango ripe

**Spices & Seasonings:**
turmeric powder, red chili powder, coriander powder, cumin powder, cumin seeds, mustard seeds, garam masala, cinnamon, cardamom, cloves, bay leaf, black pepper, fennel seeds, fenugreek seeds, asafoetida, star anise, nutmeg, mace, saffron, dry red chili, kashmiri chili powder, black cardamom, ajwain, poppy seeds, nigella seeds, white pepper, chaat masala, sambar powder, rasam powder, biryani masala, pav bhaji masala, kitchen king masala, meat masala, tandoori masala, black salt, salt

**Oils & Fats:**
mustard oil, coconut oil, sunflower oil, sesame oil, olive oil, vegetable oil, peanut oil, rice bran oil

**Condiments & Sauces:**
soy sauce, vinegar, tomato ketchup, green chutney, tamarind paste, coconut milk, coconut cream, tomato paste, ginger garlic paste, pickle, jaggery, sugar, honey, lemon juice, worcestershire sauce, schezwan sauce, chili flakes, oregano, kasuri methi, amchur powder

**Nuts & Seeds:**
cashews, almonds, walnuts, pistachios, sesame seeds, flax seeds, chia seeds, sunflower seeds, pumpkin seeds, melon seeds, fox nuts, dry coconut

**Miscellaneous:**
baking powder, baking soda, yeast, gelatin, food color, rose water, kewra water, vanilla extract, cocoa powder, papad, eno, water, ice, tea leaves, coffee powder

### 2. Units — Must Be Consistent
Use these units ONLY:
- Weight: `g` (grams), `kg` (kilograms)
- Volume: `ml` (milliliters), `l` (liters)
- Count: `piece`, `tablespoon`, `teaspoon`, `cup`
- Never use: "handful", "pinch", "some", "to taste", "as needed"
- For "salt to taste", use: `{ "name": "salt", "quantity": 5, "unit": "g" }`
- For "oil for frying", use: `{ "name": "vegetable oil", "quantity": 30, "unit": "ml" }`

### 3. Recipe Distribution — EXACTLY This Breakdown

**By Diet (100 veg + 100 non-veg):**
- 100 vegetarian recipes (is_vegetarian: true)
- 100 non-vegetarian recipes (is_vegetarian: false)
- Of the 100 veg: at least 15 should also be vegan (is_vegan: true)
- Of the 100 veg: at least 10 should be Jain-friendly (is_jain: true — no onion, garlic, root vegetables)

**By Cuisine (approximate):**
- 60 North Indian (Punjabi, Mughlai, Rajasthani, Lucknowi, Hyderabadi)
- 40 South Indian (Tamil Nadu, Kerala, Karnataka, Andhra Pradesh)
- 15 Indo-Chinese / Fusion
- 15 Bengali / Eastern Indian
- 15 Street Food & Snacks (chaat, vada pav, etc.)
- 15 Continental / Global (pasta, stir-fry, wraps — commonly cooked in Indian homes)
- 10 Gujarati / Maharashtrian
- 10 Breakfast / Tiffin specials
- 20 Desserts & Sweets

**By Meal Type (recipes can have multiple meal_types):**
- At least 40 breakfast-suitable
- At least 80 lunch-suitable
- At least 80 dinner-suitable
- At least 20 snack-suitable

**By Difficulty:**
- 60 easy (under 30 min total)
- 100 medium (30-60 min)
- 40 hard (60+ min or complex technique)

**By Cooking Style (assign 1-3 tags per recipe):**
- quick (< 30 min total)
- one-pot
- batch-prep-friendly
- weekend-project (complex, multi-step)
- no-cook (salads, raita, etc.)
- slow-cook
- stir-fry
- deep-fry
- bake
- steam
- grill / tandoor

### 4. Cuisine Values — Use These Exact Strings
```
north_indian, south_indian, bengali, gujarati, maharashtrian,
rajasthani, hyderabadi, lucknowi, mughlai, punjabi, kashmiri,
indo_chinese, continental, thai, arabian, street_food,
tamil, kerala, karnataka, andhra, goan, chettinad
```

For `cuisine_region`, use more specific sub-regions or leave null.

### 5. Recipe Quality Requirements
- Every recipe MUST have at least 4 ingredients and at least 3 steps
- Steps must be actionable (not "cook until done" — say "cook on medium heat for 8-10 minutes until onions turn golden brown")
- Quantities must be realistic for the stated servings
- Every non-veg recipe must have at least one protein ingredient from the meat/seafood/eggs list
- Every recipe must have a description (1-2 sentences, appetizing, mentions key flavors or origin)
- `protein_category` for non-veg: "chicken", "mutton", "lamb", "fish", "prawns", "egg". For veg: "paneer", "dal", "legume", "soya", "tofu", null

### 6. Images — Source URL + Thumbnail
For each recipe, provide THREE image-related fields:

1. **`source_url`** (required): The URL of the recipe page you referenced. This is where the recipe data came from.
2. **`image_url`** (required): The direct URL to the hero/featured image from that source page. This should be the main recipe photo — the beautiful plated shot, not a step photo. Grab the highest-quality image URL available (usually the `og:image` meta tag or the main hero image `src`).
3. **`image_search_query`** (required): A descriptive fallback search query in case the image_url breaks later. Specific enough to find the RIGHT dish (not "Indian curry" — say "palak paneer in iron kadhai with naan on the side").

**Image quality guidelines:**
- Prefer images that are at least 600px wide
- The image should show the FINISHED dish, beautifully plated/served
- Avoid images with heavy watermarks, logos, or text overlays
- Prefer overhead or 45-degree angle food photography
- If the source page has multiple images, pick the most appetizing one

**Source guidelines:**
- Use well-known Indian recipe sites: Hebbar's Kitchen, Swasthi's Recipes, Veg Recipes of India, Sanjeev Kapoor, Tarla Dalal, Nisha Madhulika, Vahchef, Rak's Kitchen, etc.
- These sites have high-quality food photography that matches the actual recipe
- The source_url helps us attribute recipes and verify data accuracy

### 7. Must-Include Recipes
These specific recipes MUST be in the 200 (popular Indian staples):

**Non-Veg:**
Chicken Biryani, Butter Chicken, Chicken Curry, Chicken Tikka Masala, Tandoori Chicken, Mutton Rogan Josh, Keema Matar, Egg Curry, Prawn Masala, Fish Fry, Chicken Fried Rice, Chicken Manchurian, Egg Biryani, Mutton Biryani, Chicken Korma, Fish Curry, Chettinad Chicken, Chicken 65

**Veg:**
Dal Tadka, Rajma Chawal, Chole Bhature, Palak Paneer, Paneer Butter Masala, Aloo Gobi, Baingan Bharta, Sambar, Rasam, Masala Dosa, Idli, Upma, Poha, Curd Rice, Biryani (Veg), Pav Bhaji, Kadhi Pakora, Dal Makhani, Chana Masala, Malai Kofta

**Desserts:**
Gulab Jamun, Kheer, Gajar Ka Halwa, Rasgulla, Ras Malai

### 8. Unmapped Ingredients
If a recipe genuinely needs an ingredient NOT in our catalog (e.g., "panko breadcrumbs", "sriracha sauce"), include it in the `unmapped_ingredients` array:
```json
{
  "unmapped_ingredients": [
    {
      "name": "panko breadcrumbs",
      "suggested_category": "grain",
      "suggested_unit": "g",
      "quantity": 50,
      "unit": "g",
      "preparation": null,
      "group_name": "coating"
    }
  ]
}
```
Keep unmapped ingredients to under 30 total across all 200 recipes. Prefer using our catalog.

## VALIDATION CHECKLIST (verify before submitting)
- [ ] Exactly 200 recipes
- [ ] 100 vegetarian + 100 non-vegetarian
- [ ] Every ingredient name matches the catalog OR is in unmapped_ingredients
- [ ] Every quantity is a number (not a string like "2-3")
- [ ] Every unit is from the allowed list
- [ ] Every recipe has >= 4 ingredients and >= 3 steps
- [ ] Every recipe has description, meal_types, cuisine, difficulty
- [ ] Every recipe has source_url, image_url, and image_search_query
- [ ] image_url points to an actual image (ends in .jpg/.png/.webp or is a CDN URL)
- [ ] No duplicate recipe titles
- [ ] Must-include recipes are all present
- [ ] Total unmapped ingredients < 30
- [ ] Valid JSON (parseable)

## OUTPUT
Single file: `global-recipes.json`
Do NOT include any explanation, commentary, or markdown — just the JSON.
