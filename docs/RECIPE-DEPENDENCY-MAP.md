# Plateful — Recipe Dependency Map

## Concept
Indian meals are multi-dish. Dal Tadka alone isn't a meal — it needs rice or roti.
This document maps every recipe's **dish role**, whether it's **standalone**, and what it **pairs with**.

## Dish Roles (matches Phase 6 meal_slot_dishes.dish_role)
| Role | Description | Example |
|------|-------------|---------|
| `main` | Protein/gravy dish. The star of the plate. | Dal Tadka, Butter Chicken, Palak Paneer |
| `staple` | Carb base that carries the main. | Jeera Rice, Veg Pulao, Lemon Rice |
| `side` | Vegetable accompaniment. Adds variety. | Cabbage Poriyal, Aloo Gobi, Bhindi Masala |
| `accompaniment` | Extras: raita, chutney, papad. | (Not in current 200, future additions) |
| `complete` | Self-contained meal. Rice+protein already together. | Chicken Biryani, Rajma Chawal, Fried Rice |

## Cuisine Pairing Groups
Mains pair with staples/sides from compatible cuisines:

| Group | Cuisines | Typical Staples | Typical Sides |
|-------|----------|-----------------|---------------|
| `north` | north_indian, punjabi, mughlai, kashmiri, lucknowi | Jeera Rice, Veg Pulao | Aloo Gobi, Bhindi Masala, Baingan Bharta |
| `south` | tamil, kerala, karnataka, south_indian, chettinad, andhra | Lemon Rice, Coconut Rice, Tomato Rice, Tamarind Rice | Cabbage Poriyal, Beetroot Poriyal, Beans Thoran, Avial |
| `bengali` | bengali | Steamed Rice (Jeera Rice as proxy) | (limited sides in current 200) |
| `maharashtrian` | maharashtrian | (Jeera Rice as proxy) | Bharli Vangi |
| `indo_chinese` | indo_chinese | Egg/Chicken Fried Rice | — |
| `continental` | continental | Bread-based | Zucchini Stir Fry |
| `gujarati` | gujarati | (self-complete items mostly) | Undhiyu |
| `street` | street_food | Built into the dish | — |

## Complete Recipe Mapping (all 200)

### COMPLETE MEALS (is_standalone = true, dish_role = complete)
These need nothing else — the carb/protein is built in.

| # | Recipe | Cuisine | Notes |
|---|--------|---------|-------|
| 2 | Rajma Chawal | punjabi | Rajma + rice in one dish |
| 3 | Chole Bhature | punjabi | Chole + fried bread |
| 10 | Masala Dosa | karnataka | Dosa + potato filling |
| 11 | Idli | tamil | Complete tiffin (serve with chutney/sambar) |
| 12 | Upma | south_indian | Complete breakfast |
| 13 | Poha | maharashtrian | Complete breakfast |
| 14 | Curd Rice | tamil | Complete comfort meal |
| 15 | Veg Biryani | hyderabadi | Rice + vegetables layered |
| 16 | Pav Bhaji | street_food | Bhaji + bread |
| 28 | Quinoa Upma | south_indian | Complete breakfast |
| 29 | Oats Idli | south_indian | Complete breakfast |
| 30 | Ragi Dosa | karnataka | Complete tiffin |
| 31 | Pongal | tamil | Rice + dal cooked together |
| 32 | Appam | kerala | Complete tiffin |
| 33 | Uttapam | tamil | Complete tiffin |
| 34 | Medu Vada | south_indian | Complete snack/tiffin |
| 40 | Methi Thepla | gujarati | Stuffed flatbread = complete |
| 41 | Dhokla | gujarati | Complete snack |
| 42 | Khandvi | gujarati | Complete snack |
| 43 | Misal Pav | maharashtrian | Misal + bread |
| 56 | Baby Corn Manchurian | indo_chinese | Complete snack/starter |
| 57 | Veg Manchurian | indo_chinese | Complete snack/starter |
| 58 | Chilli Paneer | indo_chinese | Complete snack/starter |
| 60 | Vegetable Sandwich | continental | Bread + filling |
| 61 | Corn Cheese Sandwich | continental | Bread + filling |
| 62 | Broccoli Soup | continental | Complete light meal |
| 63 | Tomato Soup | continental | Complete light meal |
| 64 | Spinach Soup | continental | Complete light meal |
| 65 | Chickpea Salad | continental | Complete light meal |
| 66 | Bread Upma | street_food | Complete breakfast |
| 67 | Semiya Upma | south_indian | Complete breakfast |
| 69 | Rava Dosa | karnataka | Complete tiffin |
| 80 | Paneer Tikka | punjabi | Complete snack/starter |
| 101 | Chicken Biryani | hyderabadi | Rice + chicken layered |
| 106 | Chicken Fried Rice | indo_chinese | Rice + chicken in wok |
| 107 | Chicken Manchurian | indo_chinese | Complete snack/starter |
| 110 | Chicken 65 | andhra | Complete snack/starter |
| 111 | Chicken Pulao | north_indian | Rice + chicken one-pot |
| 112 | Chicken Tikka | punjabi | Complete snack/starter |
| 122 | Chicken Lollipop | indo_chinese | Complete snack |
| 123 | Chilli Chicken | indo_chinese | Complete snack/starter |
| 124 | Chicken Schezwan Fried Rice | indo_chinese | Rice + chicken in wok |
| 125 | Chicken Soup | continental | Complete light meal |
| 126 | Chicken Wrap | continental | Bread + chicken |
| 127 | Chicken Sandwich | continental | Bread + chicken |
| 128 | Chicken Cutlet | continental | Complete snack |
| 130 | Chicken Yakhni Pulao | lucknowi | Rice + chicken one-pot |
| 138 | Chicken Malai Tikka | mughlai | Complete snack/starter |
| 139 | Tandoori Chicken Drumsticks | punjabi | Complete snack/starter |
| 140 | Chicken Shawarma Wrap | arabian | Bread + chicken |
| 141 | Chicken Clear Soup | continental | Complete light meal |
| 142 | Chicken Salad | continental | Complete light meal |
| 143 | Chicken Seekh Kebab | mughlai | Complete snack/starter |
| 144 | Chicken Pakora | street_food | Complete snack |
| 148 | Egg Biryani | hyderabadi | Rice + egg layered |
| 149 | Egg Bhurji | street_food | Complete (often eaten with bread, but fine alone) |
| 150 | Anda Ghotala | street_food | Complete street food |
| 151 | Egg Bhurji Sandwich | street_food | Bread + egg |
| 152 | Egg Fried Rice | indo_chinese | Rice + egg in wok |
| 155 | Masala Omelette | street_food | Complete breakfast |
| 157 | Egg Pulao | north_indian | Rice + egg one-pot |
| 159 | Egg Drop Soup | indo_chinese | Complete light meal |
| 161 | Mughlai Paratha | street_food | Stuffed bread = complete |
| 169 | Fish Biryani | hyderabadi | Rice + fish layered |
| 176 | Fish Cutlet | bengali | Complete snack |
| 180 | Prawn Biryani | hyderabadi | Rice + prawn layered |
| 184 | Prawn Fried Rice | indo_chinese | Rice + prawn in wok |
| 185 | Prawn Manchurian | indo_chinese | Complete snack/starter |
| 189 | Mutton Biryani | hyderabadi | Rice + mutton layered |
| 194 | Mutton Seekh Kebab | mughlai | Complete snack/starter |
| 198 | Lamb Kebabs | mughlai | Complete snack/starter |
| 199 | Lamb Pulao | lucknowi | Rice + lamb one-pot |

**Total complete: 73 recipes**

### MAIN DISHES (is_standalone = false, dish_role = main)
These NEED a staple (rice/roti). Optionally benefit from a side.

| # | Recipe | Cuisine | Pairing Group | Best Staples |
|---|--------|---------|---------------|-------------|
| 1 | Dal Tadka | north_indian | north | Jeera Rice, Veg Pulao |
| 4 | Palak Paneer | punjabi | north | Jeera Rice, Veg Pulao |
| 5 | Paneer Butter Masala | punjabi | north | Jeera Rice, Veg Pulao |
| 8 | Sambar | tamil | south | Lemon Rice, Coconut Rice, Tomato Rice |
| 9 | Rasam | tamil | south | Any South Indian rice |
| 17 | Kadhi Pakora | north_indian | north | Jeera Rice |
| 18 | Dal Makhani | punjabi | north | Jeera Rice, Veg Pulao |
| 19 | Chana Masala | punjabi | north | Jeera Rice, Veg Pulao |
| 20 | Malai Kofta | mughlai | north | Jeera Rice, Veg Pulao |
| 39 | Vegetable Kurma | karnataka | south | Any rice |
| 47 | Lauki Chana Dal | north_indian | north | Jeera Rice |
| 49 | Methi Malai Paneer | punjabi | north | Jeera Rice, Veg Pulao |
| 50 | Kadai Paneer | north_indian | north | Jeera Rice, Veg Pulao |
| 51 | Paneer Bhurji | north_indian | north | Any bread or rice |
| 52 | Shahi Paneer | mughlai | north | Jeera Rice, Veg Pulao |
| 53 | Mattar Paneer | punjabi | north | Jeera Rice, Veg Pulao |
| 54 | Dum Aloo Kashmiri | kashmiri | north | Jeera Rice |
| 55 | Mushroom Masala | north_indian | north | Jeera Rice, Veg Pulao |
| 59 | Tofu Stir Fry | continental | continental | Bread |
| 71 | Pumpkin Curry | south_indian | south | Any South Indian rice |
| 72 | Jackfruit Masala | north_indian | north | Jeera Rice |
| 76 | Undhiyu | gujarati | gujarati | Puri (not in library) — can use Methi Thepla |
| 77 | Drumstick Curry | south_indian | south | Any South Indian rice |
| 102 | Butter Chicken | punjabi | north | Jeera Rice, Veg Pulao |
| 103 | Chicken Curry | north_indian | north | Jeera Rice, Veg Pulao |
| 104 | Chicken Tikka Masala | punjabi | north | Jeera Rice, Veg Pulao |
| 105 | Tandoori Chicken | punjabi | north | Jeera Rice |
| 108 | Chicken Korma | mughlai | north | Jeera Rice, Veg Pulao |
| 109 | Chettinad Chicken | chettinad | south | Any South Indian rice |
| 113 | Chicken Roast | kerala | south | Any rice |
| 114 | Chicken Sukka | karnataka | south | Any rice |
| 115 | Pepper Chicken | south_indian | south | Any rice |
| 116 | Kadai Chicken | north_indian | north | Jeera Rice |
| 117 | Chicken Jalfrezi | north_indian | north | Jeera Rice, Veg Pulao |
| 118 | Chicken Vindaloo | goan | north | Jeera Rice |
| 119 | Kerala Chicken Stew | kerala | south | Appam (but Appam is "complete") |
| 120 | Andhra Chicken Curry | andhra | south | Any rice |
| 121 | Chicken Ghee Roast | karnataka | south | Any rice |
| 129 | Chicken Kofta Curry | mughlai | north | Jeera Rice, Veg Pulao |
| 131 | Chicken Rezala | bengali | bengali | Jeera Rice |
| 132 | Mughlai Chicken | mughlai | north | Jeera Rice, Veg Pulao |
| 133 | Chicken Saagwala | north_indian | north | Jeera Rice |
| 134 | Chicken Bhuna | north_indian | north | Jeera Rice |
| 135 | Chicken Handi | punjabi | north | Jeera Rice, Veg Pulao |
| 136 | Chicken Kosha | bengali | bengali | Jeera Rice |
| 137 | Chicken Cafreal | goan | north | Jeera Rice |
| 145 | Chicken Coconut Curry | kerala | south | Any rice |
| 146 | Chicken Do Pyaza | north_indian | north | Jeera Rice |
| 147 | Egg Curry | north_indian | north | Jeera Rice |
| 153 | Egg Roast | kerala | south | Any rice |
| 154 | Egg Pepper Fry | south_indian | south | Any rice |
| 156 | Egg Masala Fry | south_indian | south | Any rice |
| 158 | Andhra Egg Curry | andhra | south | Any rice |
| 160 | Egg Korma | mughlai | north | Jeera Rice, Veg Pulao |
| 162 | Fish Fry | street_food | south | Any rice |
| 163 | Fish Curry | south_indian | south | Any South Indian rice |
| 164 | Fish Molee | kerala | south | Any rice |
| 165 | Fish Tikka | punjabi | north | Jeera Rice |
| 166 | Tandoori Fish | punjabi | north | Jeera Rice |
| 167 | Fish Amritsari | punjabi | north | Jeera Rice |
| 168 | Fish Koliwada | maharashtrian | maharashtrian | Jeera Rice |
| 170 | Fish Pepper Fry | south_indian | south | Any rice |
| 171 | Fish Masala | north_indian | north | Jeera Rice |
| 172 | Pomfret Fry | maharashtrian | maharashtrian | Jeera Rice |
| 173 | Surmai Curry | maharashtrian | maharashtrian | Jeera Rice |
| 174 | Rohu Kalia | bengali | bengali | Jeera Rice |
| 175 | Rohu Mustard Curry | bengali | bengali | Jeera Rice |
| 177 | Prawn Masala | south_indian | south | Any rice |
| 178 | Prawn Curry Kerala | kerala | south | Any rice |
| 179 | Prawn Fry | south_indian | south | Any rice |
| 181 | Prawn Coconut Curry | kerala | south | Any rice |
| 182 | Prawn Pepper Fry | south_indian | south | Any rice |
| 183 | Prawn Ghee Roast | karnataka | south | Any rice |
| 186 | Prawn Sukka | karnataka | south | Any rice |
| 187 | Mutton Rogan Josh | kashmiri | north | Jeera Rice |
| 188 | Keema Matar | north_indian | north | Any rice or bread |
| 190 | Mutton Curry | north_indian | north | Jeera Rice |
| 191 | Mutton Korma | mughlai | north | Jeera Rice, Veg Pulao |
| 192 | Mutton Fry | south_indian | south | Any rice |
| 193 | Mutton Stew | kerala | south | Appam (but Appam is "complete") |
| 195 | Mutton Sukka | maharashtrian | maharashtrian | Any rice |
| 196 | Lamb Curry | north_indian | north | Jeera Rice |
| 197 | Lamb Korma | mughlai | north | Jeera Rice, Veg Pulao |
| 200 | Lamb Bhuna | north_indian | north | Jeera Rice |

**Total mains: 82 recipes**

### STAPLE DISHES (is_standalone = false, dish_role = staple)
These carry a main dish. Need at least a main to form a meal.

| # | Recipe | Cuisine | Pairing Group |
|---|--------|---------|---------------|
| 21 | Jeera Rice | north_indian | north (universal — works with almost anything) |
| 22 | Veg Pulao | north_indian | north |
| 23 | Lemon Rice | tamil | south |
| 24 | Tamarind Rice | tamil | south |
| 25 | Coconut Rice | south_indian | south |
| 26 | Tomato Rice | south_indian | south |
| 27 | Mushroom Pulao | north_indian | north |

**Total staples: 7 recipes**

### SIDE DISHES (is_standalone = false, dish_role = side)
These accompany a main+staple combo. Add variety and nutrition.

| # | Recipe | Cuisine | Pairing Group |
|---|--------|---------|---------------|
| 6 | Aloo Gobi | punjabi | north |
| 7 | Baingan Bharta | north_indian | north |
| 35 | Cabbage Poriyal | tamil | south |
| 36 | Beetroot Poriyal | tamil | south |
| 37 | Beans Thoran | kerala | south |
| 38 | Avial | kerala | south |
| 44 | Bhindi Masala | north_indian | north |
| 45 | Bharli Vangi | maharashtrian | maharashtrian |
| 46 | Bharwa Bhindi | north_indian | north |
| 48 | Gobi Matar | north_indian | north |
| 68 | Zucchini Stir Fry | continental | continental |
| 70 | Baby Corn Pepper Fry | continental | continental |
| 73 | Raw Banana Fry | kerala | south |
| 74 | Yam Roast | south_indian | south |
| 75 | Ivy Gourd Stir Fry | south_indian | south |
| 78 | Banana Stem Poriyal | tamil | south |
| 79 | Banana Flower Stir Fry | tamil | south |

**Total sides: 17 recipes**

### DESSERTS (is_standalone = true, dish_role = complete)
Counted in the complete meals above. All 20 desserts are standalone.
Recipes 81-100: Kheer through Mango Shrikhand.

## Summary
| Role | Count | Standalone? |
|------|-------|-------------|
| complete | 73 | Yes |
| main | 82 | No — needs staple |
| staple | 7 | No — needs main |
| side | 17 | No — needs main + staple |
| accompaniment | 0 | (future: raita, chutney, papad) |
| **Total** | **200** | |

## Gap Analysis
1. **Only 7 staples** — This is the biggest gap. 82 main dishes share just 7 rice varieties. Roti/Chapati/Naan/Paratha (the most common North Indian staple) is NOT in the 200. Consider adding.
2. **No accompaniments** — Raita, chutney, pickle, papad are common Indian meal components. Consider adding 5-10.
3. **South Indian staples are flavored rice** — Lemon/Coconut/Tomato/Tamarind rice are "staples" but also have their own flavor. Plain steamed rice is missing.
4. **Stew + Appam pairing** — Kerala Chicken Stew and Mutton Stew traditionally pair with Appam. But Appam is marked "complete" (it's a tiffin item). Could support dual-role.

## Data Model (columns to add to global_recipes)

```sql
ALTER TABLE global_recipes ADD COLUMN IF NOT EXISTS dish_role TEXT NOT NULL DEFAULT 'complete'
  CHECK (dish_role IN ('main', 'staple', 'side', 'accompaniment', 'complete'));

ALTER TABLE global_recipes ADD COLUMN IF NOT EXISTS is_standalone BOOLEAN NOT NULL DEFAULT true;

ALTER TABLE global_recipes ADD COLUMN IF NOT EXISTS pairing_group TEXT
  CHECK (pairing_group IN ('north', 'south', 'bengali', 'maharashtrian', 'indo_chinese', 'continental', 'gujarati', 'street', 'arabian'));

-- What this recipe needs to form a complete meal (NULL if standalone)
ALTER TABLE global_recipes ADD COLUMN IF NOT EXISTS needs_roles TEXT[] DEFAULT '{}';
-- e.g., Dal Tadka → ['staple'], Cabbage Poriyal → ['main', 'staple']
```
