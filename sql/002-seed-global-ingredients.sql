-- =============================================================================
-- Plateful — Seed Data: Global Ingredients Catalog
-- =============================================================================
-- ~250 common Indian/Asian cooking ingredients with:
--   name, aliases (Hindi/regional names), category, default_unit,
--   nutrition per 100g (approximate values from IFCT/USDA)
--
-- Run AFTER 001-foundation-schema.sql
-- =============================================================================

-- ---------------------------------------------------------------------------
-- PROTEINS — Meat, Poultry, Seafood, Eggs
-- ---------------------------------------------------------------------------
INSERT INTO global_ingredients (name, aliases, category, default_unit, calories_per_100g, protein_per_100g, carbs_per_100g, fat_per_100g, fiber_per_100g) VALUES
('chicken breast',      ARRAY['murgh breast','chicken tikka cut'], 'protein', 'g', 165, 31, 0, 3.6, 0),
('chicken thigh',       ARRAY['murgh thigh'], 'protein', 'g', 209, 26, 0, 10.9, 0),
('chicken drumstick',   ARRAY['tangdi','chicken leg'], 'protein', 'g', 172, 28, 0, 5.7, 0),
('chicken whole',       ARRAY['murgh','whole chicken'], 'protein', 'g', 215, 18, 0, 15, 0),
('mutton',              ARRAY['goat meat','bakra'], 'protein', 'g', 143, 27, 0, 3.0, 0),
('lamb',                ARRAY['lamb meat','memna'], 'protein', 'g', 282, 25, 0, 20, 0),
('prawns',              ARRAY['shrimp','jhinga','jheenga'], 'protein', 'g', 85, 20, 0, 0.5, 0),
('fish fillet',         ARRAY['machli','fish'], 'protein', 'g', 96, 20, 0, 1.7, 0),
('pomfret',             ARRAY['paplet'], 'protein', 'g', 96, 18, 0, 2.5, 0),
('rohu',                ARRAY['rohu fish','rui'], 'protein', 'g', 97, 17, 0, 3.0, 0),
('surmai',              ARRAY['king mackerel','seer fish'], 'protein', 'g', 134, 20, 0, 5.5, 0),
('eggs',                ARRAY['anda','egg','muttai'], 'protein', 'piece', 155, 13, 1.1, 11, 0),
('egg white',           ARRAY['anda safed'], 'protein', 'g', 52, 11, 0.7, 0.2, 0),
('paneer',              ARRAY['cottage cheese','Indian cheese'], 'protein', 'g', 265, 18, 1.2, 21, 0),
('tofu',                ARRAY['soy paneer','bean curd'], 'protein', 'g', 76, 8, 1.9, 4.8, 0),
('soya chunks',         ARRAY['meal maker','soy nuggets','nutrela'], 'protein', 'g', 345, 52, 33, 0.5, 13),
('soya granules',       ARRAY['soy mince','keema soya'], 'protein', 'g', 345, 52, 33, 0.5, 13);

-- ---------------------------------------------------------------------------
-- PROTEINS — Lentils & Legumes
-- ---------------------------------------------------------------------------
INSERT INTO global_ingredients (name, aliases, category, default_unit, calories_per_100g, protein_per_100g, carbs_per_100g, fat_per_100g, fiber_per_100g) VALUES
('toor dal',            ARRAY['arhar dal','pigeon pea','tur dal'], 'legume', 'g', 343, 22, 63, 1.5, 15),
('moong dal',           ARRAY['green gram split','mung dal'], 'legume', 'g', 347, 24, 60, 1.2, 16),
('masoor dal',          ARRAY['red lentil','lal masoor'], 'legume', 'g', 352, 25, 60, 1.1, 11),
('chana dal',           ARRAY['split chickpea','Bengal gram dal'], 'legume', 'g', 360, 22, 58, 5.3, 18),
('urad dal',            ARRAY['black gram split','dhuli urad'], 'legume', 'g', 341, 25, 59, 1.4, 18),
('whole moong',         ARRAY['green gram whole','sabut moong'], 'legume', 'g', 347, 24, 60, 1.2, 16),
('whole masoor',        ARRAY['sabut masoor','brown lentil'], 'legume', 'g', 352, 25, 60, 1.1, 11),
('whole urad',          ARRAY['sabut urad','black gram whole'], 'legume', 'g', 341, 25, 59, 1.4, 18),
('chickpeas',           ARRAY['chole','kabuli chana','garbanzo'], 'legume', 'g', 364, 19, 61, 6, 17),
('rajma',               ARRAY['kidney beans','red beans'], 'legume', 'g', 333, 24, 60, 0.8, 25),
('black eyed peas',     ARRAY['lobia','lobhia','cowpea'], 'legume', 'g', 336, 24, 60, 1.3, 11),
('peanuts',             ARRAY['moongphali','groundnut'], 'nut', 'g', 567, 26, 16, 49, 9),
('dried green peas',    ARRAY['sukhi matar','vatana'], 'legume', 'g', 341, 24, 60, 1.2, 25);

-- ---------------------------------------------------------------------------
-- DAIRY
-- ---------------------------------------------------------------------------
INSERT INTO global_ingredients (name, aliases, category, default_unit, calories_per_100g, protein_per_100g, carbs_per_100g, fat_per_100g, fiber_per_100g) VALUES
('milk',                ARRAY['doodh','full cream milk'], 'dairy', 'ml', 61, 3.2, 4.8, 3.3, 0),
('curd',                ARRAY['yogurt','dahi','thayir'], 'dairy', 'g', 60, 3.5, 4.7, 3.1, 0),
('buttermilk',          ARRAY['chaas','mattha','majjige'], 'dairy', 'ml', 40, 3.3, 4.8, 0.9, 0),
('ghee',                ARRAY['clarified butter','desi ghee'], 'dairy', 'g', 900, 0, 0, 100, 0),
('butter',              ARRAY['makhan','white butter'], 'dairy', 'g', 717, 0.9, 0.1, 81, 0),
('cream',               ARRAY['malai','fresh cream'], 'dairy', 'ml', 340, 2.1, 2.8, 36, 0),
('cheese',              ARRAY['cheddar','processed cheese'], 'dairy', 'g', 402, 25, 1.3, 33, 0),
('mozzarella',          ARRAY['pizza cheese'], 'dairy', 'g', 280, 28, 3.1, 17, 0),
('condensed milk',      ARRAY['milkmaid'], 'dairy', 'g', 321, 8, 55, 8.7, 0),
('khoya',               ARRAY['mawa','khoa'], 'dairy', 'g', 321, 15, 18, 25, 0);

-- ---------------------------------------------------------------------------
-- GRAINS & FLOUR
-- ---------------------------------------------------------------------------
INSERT INTO global_ingredients (name, aliases, category, default_unit, calories_per_100g, protein_per_100g, carbs_per_100g, fat_per_100g, fiber_per_100g) VALUES
('basmati rice',        ARRAY['chawal','rice','arisi'], 'grain', 'g', 350, 7, 78, 0.6, 0.4),
('brown rice',          ARRAY['brown chawal','unpolished rice'], 'grain', 'g', 362, 8, 76, 2.7, 3.5),
('atta',                ARRAY['whole wheat flour','gehu ka atta','chapati flour'], 'grain', 'g', 340, 12, 72, 1.7, 11),
('maida',               ARRAY['all purpose flour','refined flour'], 'grain', 'g', 364, 10, 76, 1.0, 2.7),
('besan',               ARRAY['gram flour','chickpea flour'], 'grain', 'g', 387, 22, 58, 7, 10),
('rice flour',          ARRAY['chawal ka atta','rice powder'], 'grain', 'g', 366, 6, 80, 1.4, 2.4),
('semolina',            ARRAY['sooji','rava','suji'], 'grain', 'g', 360, 13, 73, 1.1, 3.9),
('poha',                ARRAY['flattened rice','chivda','aval'], 'grain', 'g', 346, 6.6, 77, 1.2, 1.3),
('oats',                ARRAY['jaee','rolled oats'], 'grain', 'g', 389, 17, 66, 7, 11),
('bread',               ARRAY['roti','sliced bread'], 'grain', 'piece', 265, 9, 49, 3.2, 2.7),
('vermicelli',          ARRAY['sevai','semiya','seviyan'], 'grain', 'g', 359, 12, 74, 1.5, 3.2),
('dosa batter',         ARRAY['dosa maavu'], 'grain', 'ml', 160, 5, 30, 1.5, 2),
('idli batter',         ARRAY['idli maavu'], 'grain', 'ml', 155, 5, 29, 1.2, 1.8),
('quinoa',              ARRAY['kinwa'], 'grain', 'g', 368, 14, 64, 6, 7),
('ragi flour',          ARRAY['finger millet flour','nachni'], 'grain', 'g', 328, 7, 72, 1.3, 12),
('jowar flour',         ARRAY['sorghum flour'], 'grain', 'g', 349, 10, 73, 1.9, 10),
('bajra flour',         ARRAY['pearl millet flour'], 'grain', 'g', 363, 12, 67, 5, 11),
('corn flour',          ARRAY['makka atta','cornstarch'], 'grain', 'g', 381, 3.2, 91, 0.6, 0.9),
('bread crumbs',        ARRAY['rusk powder'], 'grain', 'g', 395, 13, 72, 5.5, 4.5);

-- ---------------------------------------------------------------------------
-- VEGETABLES
-- ---------------------------------------------------------------------------
INSERT INTO global_ingredients (name, aliases, category, default_unit, calories_per_100g, protein_per_100g, carbs_per_100g, fat_per_100g, fiber_per_100g) VALUES
('onion',               ARRAY['pyaz','vengayam','ulli','kanda'], 'vegetable', 'g', 40, 1.1, 9.3, 0.1, 1.7),
('tomato',              ARRAY['tamatar','thakkali'], 'vegetable', 'g', 18, 0.9, 3.9, 0.2, 1.2),
('potato',              ARRAY['aloo','urulaikizhangu','batata'], 'vegetable', 'g', 77, 2, 17, 0.1, 2.2),
('garlic',              ARRAY['lahsun','poondu','vellulli'], 'vegetable', 'g', 149, 6.4, 33, 0.5, 2.1),
('ginger',              ARRAY['adrak','inji','allam'], 'vegetable', 'g', 80, 1.8, 18, 0.8, 2),
('green chili',         ARRAY['hari mirch','pachai milagai'], 'vegetable', 'g', 40, 1.9, 8.8, 0.4, 1.5),
('capsicum',            ARRAY['bell pepper','shimla mirch'], 'vegetable', 'g', 31, 1, 6, 0.3, 2.1),
('cauliflower',         ARRAY['gobi','phool gobi'], 'vegetable', 'g', 25, 1.9, 5, 0.3, 2),
('cabbage',             ARRAY['patta gobi','band gobi'], 'vegetable', 'g', 25, 1.3, 5.8, 0.1, 2.5),
('spinach',             ARRAY['palak','keerai'], 'vegetable', 'g', 23, 2.9, 3.6, 0.4, 2.2),
('methi leaves',        ARRAY['fenugreek leaves','venthayam keerai'], 'vegetable', 'g', 49, 4.4, 6, 0.9, 4.9),
('coriander leaves',    ARRAY['dhania patta','kothamalli'], 'vegetable', 'g', 23, 2.1, 3.7, 0.5, 2.8),
('mint leaves',         ARRAY['pudina','pudina patta'], 'vegetable', 'g', 44, 3.3, 8, 0.7, 6.8),
('curry leaves',        ARRAY['kadi patta','kariveppilai','kadhi patta'], 'vegetable', 'g', 108, 6.1, 18, 1, 6.4),
('brinjal',             ARRAY['baingan','eggplant','kathirikai'], 'vegetable', 'g', 25, 1, 6, 0.2, 3),
('okra',                ARRAY['bhindi','ladyfinger','vendakkai'], 'vegetable', 'g', 33, 1.9, 7, 0.2, 3.2),
('bottle gourd',        ARRAY['lauki','doodhi','sorakkai'], 'vegetable', 'g', 14, 0.6, 3.4, 0, 0.5),
('ridge gourd',         ARRAY['tori','peerkangai'], 'vegetable', 'g', 20, 1.2, 4, 0.1, 2),
('bitter gourd',        ARRAY['karela','pavakkai'], 'vegetable', 'g', 17, 1, 3.7, 0.2, 2.8),
('snake gourd',         ARRAY['chichinda','padwal','pudalangai'], 'vegetable', 'g', 18, 1.2, 3.5, 0.1, 0.5),
('drumstick',           ARRAY['moringa','sahjan','murungai'], 'vegetable', 'g', 37, 2.1, 8.5, 0.2, 3.2),
('pumpkin',             ARRAY['kaddu','poosanikai'], 'vegetable', 'g', 26, 1, 6.5, 0.1, 0.5),
('carrot',              ARRAY['gajar'], 'vegetable', 'g', 41, 0.9, 10, 0.2, 2.8),
('beetroot',            ARRAY['chukandar','beet'], 'vegetable', 'g', 43, 1.6, 10, 0.2, 2.8),
('radish',              ARRAY['mooli','mullangi'], 'vegetable', 'g', 16, 0.7, 3.4, 0.1, 1.6),
('green beans',         ARRAY['french beans','sem ki phali'], 'vegetable', 'g', 31, 1.8, 7, 0.1, 2.7),
('peas',                ARRAY['matar','green peas','pattani'], 'vegetable', 'g', 81, 5.4, 14, 0.4, 5.1),
('corn',                ARRAY['makka','sweet corn','bhutta'], 'vegetable', 'g', 86, 3.3, 19, 1.4, 2.7),
('mushroom',            ARRAY['khumbi','mushrooms','button mushroom'], 'vegetable', 'g', 22, 3.1, 3.3, 0.3, 1),
('sweet potato',        ARRAY['shakarkand','ratalu'], 'vegetable', 'g', 86, 1.6, 20, 0.1, 3),
('raw banana',          ARRAY['kachha kela','plantain','vazhakkai'], 'vegetable', 'g', 89, 1.1, 23, 0.3, 2.6),
('cluster beans',       ARRAY['gavar','guar phali'], 'vegetable', 'g', 31, 3.2, 5, 0.4, 3.2),
('tinda',               ARRAY['apple gourd','Indian round gourd'], 'vegetable', 'g', 21, 1.4, 3.4, 0.3, 1.6),
('spring onion',        ARRAY['hara pyaz','green onion','scallion'], 'vegetable', 'g', 32, 1.8, 7.3, 0.2, 2.6),
('lettuce',             ARRAY['salad patta'], 'vegetable', 'g', 15, 1.4, 2.9, 0.2, 1.3),
('cucumber',            ARRAY['kheera','kakdi'], 'vegetable', 'g', 15, 0.7, 3.6, 0.1, 0.5),
('zucchini',            ARRAY['tori','courgette'], 'vegetable', 'g', 17, 1.2, 3.1, 0.3, 1),
('broccoli',            ARRAY['hari gobi'], 'vegetable', 'g', 34, 2.8, 7, 0.4, 2.6),
('baby corn',           ARRAY['chhota makka'], 'vegetable', 'g', 26, 2.7, 4.7, 0.2, 2.5),
('ivy gourd',           ARRAY['tindora','kundru','kovakkai'], 'vegetable', 'g', 18, 1.2, 3, 0.1, 1.6),
('yam',                 ARRAY['suran','jimikand','senaikizhangu'], 'vegetable', 'g', 118, 1.5, 28, 0.2, 4.1),
('colocasia',           ARRAY['arbi','taro','chamadumpa'], 'vegetable', 'g', 112, 1.5, 26, 0.2, 4.1),
('jackfruit raw',       ARRAY['kathal','raw jackfruit','palakkai'], 'vegetable', 'g', 95, 1.7, 23, 0.6, 1.5),
('banana stem',         ARRAY['vazhaithandu','kele ka tana'], 'vegetable', 'g', 12, 0.4, 2.6, 0.1, 0.7),
('banana flower',       ARRAY['vazhaipoo','kele ka phool','mocha'], 'vegetable', 'g', 51, 1.6, 9.9, 0.6, 5.7);

-- ---------------------------------------------------------------------------
-- FRUITS (commonly used in cooking)
-- ---------------------------------------------------------------------------
INSERT INTO global_ingredients (name, aliases, category, default_unit, calories_per_100g, protein_per_100g, carbs_per_100g, fat_per_100g, fiber_per_100g) VALUES
('lemon',               ARRAY['nimbu','elumichai'], 'fruit', 'piece', 29, 1.1, 9.3, 0.3, 2.8),
('lime',                ARRAY['nimbu','lime juice'], 'fruit', 'piece', 30, 0.7, 11, 0.2, 2.8),
('tamarind',            ARRAY['imli','puli','chintapandu'], 'fruit', 'g', 239, 2.8, 63, 0.6, 5.1),
('raw mango',           ARRAY['kairi','kacchi kairi','mangai'], 'fruit', 'g', 60, 0.4, 15, 0.3, 1.6),
('coconut fresh',       ARRAY['nariyal','thengai'], 'fruit', 'g', 354, 3.3, 15, 33, 9),
('coconut dried',       ARRAY['copra','sukha nariyal','desiccated coconut'], 'fruit', 'g', 660, 7, 24, 65, 16),
('banana ripe',         ARRAY['kela','pazham'], 'fruit', 'piece', 89, 1.1, 23, 0.3, 2.6),
('dates',               ARRAY['khajoor','khajur'], 'fruit', 'g', 277, 1.8, 75, 0.2, 7),
('raisins',             ARRAY['kishmish','dry grapes'], 'fruit', 'g', 299, 3.1, 79, 0.5, 3.7),
('pomegranate',         ARRAY['anaar','maathulai'], 'fruit', 'g', 83, 1.7, 19, 1.2, 4),
('pineapple',           ARRAY['ananas'], 'fruit', 'g', 50, 0.5, 13, 0.1, 1.4),
('mango ripe',          ARRAY['aam','maampazhham'], 'fruit', 'g', 60, 0.8, 15, 0.4, 1.6);

-- ---------------------------------------------------------------------------
-- SPICES & SEASONINGS
-- ---------------------------------------------------------------------------
INSERT INTO global_ingredients (name, aliases, category, default_unit, calories_per_100g, protein_per_100g, carbs_per_100g, fat_per_100g, fiber_per_100g) VALUES
('turmeric powder',     ARRAY['haldi','manjal','pasupu'], 'spice', 'g', 312, 10, 65, 3.2, 21),
('red chili powder',    ARRAY['lal mirch','mirchi powder'], 'spice', 'g', 282, 13, 50, 6, 35),
('coriander powder',    ARRAY['dhania powder','kothamalli podi'], 'spice', 'g', 298, 12, 55, 5, 42),
('cumin powder',        ARRAY['jeera powder','jeeragam podi'], 'spice', 'g', 375, 18, 44, 22, 11),
('cumin seeds',         ARRAY['jeera','jeeragam','zeera'], 'spice', 'g', 375, 18, 44, 22, 11),
('mustard seeds',       ARRAY['rai','sarson','kadugu'], 'spice', 'g', 508, 26, 28, 36, 12),
('garam masala',        ARRAY['mixed spice','garam masala powder'], 'spice', 'g', 379, 13, 45, 15, 22),
('cinnamon',            ARRAY['dalchini','pattai'], 'spice', 'g', 247, 4, 81, 1.2, 53),
('cardamom',            ARRAY['elaichi','elakkai'], 'spice', 'g', 311, 11, 68, 7, 28),
('cloves',              ARRAY['laung','lavangam','grambu'], 'spice', 'g', 274, 6, 66, 13, 34),
('bay leaf',            ARRAY['tej patta','biryani leaf'], 'spice', 'piece', 313, 8, 75, 8.4, 26),
('black pepper',        ARRAY['kali mirch','milagu'], 'spice', 'g', 255, 10, 64, 3.3, 25),
('fennel seeds',        ARRAY['saunf','sombu','perunjeeragam'], 'spice', 'g', 345, 16, 52, 15, 40),
('fenugreek seeds',     ARRAY['methi dana','venthayam'], 'spice', 'g', 323, 23, 58, 6, 25),
('asafoetida',          ARRAY['hing','perungayam'], 'spice', 'g', 297, 4, 68, 1, 4),
('star anise',          ARRAY['chakri phool','biryani flower'], 'spice', 'piece', 337, 18, 50, 16, 15),
('nutmeg',              ARRAY['jaiphal','jathikkai'], 'spice', 'g', 525, 6, 49, 36, 21),
('mace',                ARRAY['javitri','jathipatri'], 'spice', 'g', 475, 7, 51, 32, 20),
('saffron',             ARRAY['kesar','kungumapoo'], 'spice', 'g', 310, 11, 65, 6, 4),
('dry red chili',       ARRAY['sukhi lal mirch','dried chili'], 'spice', 'piece', 282, 13, 50, 6, 35),
('kashmiri chili powder', ARRAY['kashmiri mirch','deghi mirch'], 'spice', 'g', 282, 13, 50, 6, 35),
('black cardamom',      ARRAY['badi elaichi','moti elaichi'], 'spice', 'piece', 311, 11, 68, 7, 28),
('ajwain',              ARRAY['carom seeds','bishop weed','omam'], 'spice', 'g', 305, 16, 43, 25, 22),
('poppy seeds',         ARRAY['khus khus','khashkhash'], 'spice', 'g', 525, 18, 28, 42, 20),
('nigella seeds',       ARRAY['kalonji','black seeds','karunjeegaram'], 'spice', 'g', 345, 16, 52, 15, 40),
('white pepper',        ARRAY['safed mirch'], 'spice', 'g', 296, 10, 69, 2.1, 26),
('chaat masala',        ARRAY['chaat powder'], 'spice', 'g', 250, 5, 50, 3, 10),
('sambar powder',       ARRAY['sambar masala','sambar podi'], 'spice', 'g', 310, 12, 50, 8, 18),
('rasam powder',        ARRAY['rasam podi','rasam masala'], 'spice', 'g', 300, 11, 48, 7, 16),
('biryani masala',      ARRAY['biryani spice mix'], 'spice', 'g', 350, 10, 45, 15, 20),
('pav bhaji masala',    ARRAY['pav bhaji spice'], 'spice', 'g', 320, 9, 50, 10, 15),
('kitchen king masala', ARRAY['kitchen king'], 'spice', 'g', 330, 10, 48, 12, 18),
('meat masala',         ARRAY['non-veg masala'], 'spice', 'g', 340, 11, 46, 14, 17),
('tandoori masala',     ARRAY['tandoori spice mix'], 'spice', 'g', 320, 10, 50, 10, 15),
('black salt',          ARRAY['kala namak','sanchal'], 'spice', 'g', 0, 0, 0, 0, 0),
('salt',                ARRAY['namak','uppu'], 'spice', 'g', 0, 0, 0, 0, 0);

-- ---------------------------------------------------------------------------
-- OILS & FATS
-- ---------------------------------------------------------------------------
INSERT INTO global_ingredients (name, aliases, category, default_unit, calories_per_100g, protein_per_100g, carbs_per_100g, fat_per_100g, fiber_per_100g) VALUES
('mustard oil',         ARRAY['sarson ka tel','kadugu ennai'], 'oil', 'ml', 884, 0, 0, 100, 0),
('coconut oil',         ARRAY['nariyal tel','thengai ennai'], 'oil', 'ml', 862, 0, 0, 100, 0),
('sunflower oil',       ARRAY['surajmukhi tel','cooking oil'], 'oil', 'ml', 884, 0, 0, 100, 0),
('sesame oil',          ARRAY['til ka tel','nallennai','gingelly oil'], 'oil', 'ml', 884, 0, 0, 100, 0),
('olive oil',           ARRAY['jaitun ka tel'], 'oil', 'ml', 884, 0, 0, 100, 0),
('vegetable oil',       ARRAY['refined oil','tel'], 'oil', 'ml', 884, 0, 0, 100, 0),
('peanut oil',          ARRAY['groundnut oil','moongphali tel'], 'oil', 'ml', 884, 0, 0, 100, 0),
('rice bran oil',       ARRAY['chawal ki bhusi ka tel'], 'oil', 'ml', 884, 0, 0, 100, 0);

-- ---------------------------------------------------------------------------
-- CONDIMENTS & SAUCES
-- ---------------------------------------------------------------------------
INSERT INTO global_ingredients (name, aliases, category, default_unit, calories_per_100g, protein_per_100g, carbs_per_100g, fat_per_100g, fiber_per_100g) VALUES
('soy sauce',           ARRAY['soya sauce'], 'condiment', 'ml', 53, 8, 5, 0, 0.8),
('vinegar',             ARRAY['sirka'], 'condiment', 'ml', 21, 0, 0.9, 0, 0),
('tomato ketchup',      ARRAY['tomato sauce','ketchup'], 'condiment', 'ml', 112, 1.7, 28, 0.1, 0.3),
('green chutney',       ARRAY['hari chutney','mint chutney'], 'condiment', 'g', 45, 2, 5, 1, 3),
('tamarind paste',      ARRAY['imli paste','puli paste'], 'condiment', 'g', 239, 2.8, 63, 0.6, 5),
('coconut milk',        ARRAY['nariyal ka doodh','thengai paal'], 'condiment', 'ml', 197, 2.3, 2.8, 21, 0),
('coconut cream',       ARRAY['thick coconut milk'], 'condiment', 'ml', 330, 3.6, 6.6, 35, 0),
('tomato paste',        ARRAY['tomato puree thick'], 'condiment', 'g', 82, 4.3, 19, 0.5, 4.1),
('ginger garlic paste', ARRAY['adrak lahsun paste'], 'condiment', 'g', 100, 3, 18, 0.6, 2),
('pickle',              ARRAY['achar','avakkai'], 'condiment', 'g', 150, 1, 3, 15, 1),
('jaggery',             ARRAY['gur','gud','vellam','bellam'], 'condiment', 'g', 383, 0.4, 98, 0.1, 0),
('sugar',               ARRAY['cheeni','shakkar'], 'condiment', 'g', 387, 0, 100, 0, 0),
('honey',               ARRAY['shahad','theen','madhu'], 'condiment', 'ml', 304, 0.3, 82, 0, 0.2),
('lemon juice',         ARRAY['nimbu ras','elumichai saaru'], 'condiment', 'ml', 22, 0.4, 6.9, 0.2, 0.3),
('worcestershire sauce', ARRAY['HP sauce'], 'condiment', 'ml', 78, 0, 19, 0, 0),
('schezwan sauce',      ARRAY['schezwan chutney'], 'condiment', 'ml', 130, 1, 15, 7, 2),
('chili flakes',        ARRAY['mirch flakes','red pepper flakes'], 'condiment', 'g', 282, 13, 50, 6, 35),
('oregano',             ARRAY['ajwain patti','dried oregano'], 'condiment', 'g', 265, 9, 69, 4.3, 43),
('kasuri methi',        ARRAY['dried fenugreek leaves'], 'condiment', 'g', 323, 23, 58, 6, 25),
('amchur powder',       ARRAY['dry mango powder','amchoor'], 'condiment', 'g', 320, 2, 75, 1, 10);

-- ---------------------------------------------------------------------------
-- NUTS & SEEDS
-- ---------------------------------------------------------------------------
INSERT INTO global_ingredients (name, aliases, category, default_unit, calories_per_100g, protein_per_100g, carbs_per_100g, fat_per_100g, fiber_per_100g) VALUES
('cashews',             ARRAY['kaju','mundiri'], 'nut', 'g', 553, 18, 30, 44, 3.3),
('almonds',             ARRAY['badam','baadaam'], 'nut', 'g', 579, 21, 22, 50, 12),
('walnuts',             ARRAY['akhrot'], 'nut', 'g', 654, 15, 14, 65, 6.7),
('pistachios',          ARRAY['pista'], 'nut', 'g', 560, 20, 28, 45, 10),
('sesame seeds',        ARRAY['til','ellu'], 'nut', 'g', 573, 18, 23, 50, 12),
('flax seeds',          ARRAY['alsi','alasi'], 'nut', 'g', 534, 18, 29, 42, 27),
('chia seeds',          ARRAY['sabja','chia'], 'nut', 'g', 486, 17, 42, 31, 34),
('sunflower seeds',     ARRAY['surajmukhi beej'], 'nut', 'g', 584, 21, 20, 51, 8.6),
('pumpkin seeds',       ARRAY['kaddu ke beej'], 'nut', 'g', 559, 30, 11, 49, 6),
('melon seeds',         ARRAY['magaz','char magaz','tarbooz beej'], 'nut', 'g', 557, 28, 15, 47, 5),
('fox nuts',            ARRAY['makhana','lotus seeds','phool makhana'], 'nut', 'g', 347, 9.7, 77, 0.1, 7.6),
('dry coconut',         ARRAY['copra','sukha nariyal'], 'nut', 'g', 660, 7, 24, 65, 16);

-- ---------------------------------------------------------------------------
-- MISCELLANEOUS / PANTRY
-- ---------------------------------------------------------------------------
INSERT INTO global_ingredients (name, aliases, category, default_unit, calories_per_100g, protein_per_100g, carbs_per_100g, fat_per_100g, fiber_per_100g) VALUES
('baking powder',       ARRAY['baking soda supplement'], 'other', 'g', 53, 0, 28, 0, 0),
('baking soda',         ARRAY['meetha soda','cooking soda'], 'other', 'g', 0, 0, 0, 0, 0),
('yeast',               ARRAY['khameer','active dry yeast'], 'other', 'g', 325, 40, 41, 7.6, 27),
('gelatin',             ARRAY['gelatin sheets'], 'other', 'g', 335, 86, 0, 0, 0),
('food color',          ARRAY['rang','food colouring'], 'other', 'ml', 0, 0, 0, 0, 0),
('rose water',          ARRAY['gulab jal'], 'other', 'ml', 0, 0, 0, 0, 0),
('kewra water',         ARRAY['kevda jal','pandanus water'], 'other', 'ml', 0, 0, 0, 0, 0),
('vanilla extract',     ARRAY['vanilla essence'], 'other', 'ml', 288, 0.1, 13, 0.1, 0),
('cocoa powder',        ARRAY['cacao powder'], 'other', 'g', 228, 20, 58, 14, 33),
('papad',               ARRAY['papadum','appalam'], 'other', 'piece', 371, 25, 60, 1.5, 14),
('eno',                 ARRAY['fruit salt','eno salt'], 'other', 'g', 0, 0, 0, 0, 0),
('water',               ARRAY['paani','thanni'], 'other', 'ml', 0, 0, 0, 0, 0),
('ice',                 ARRAY['baraf','ice cubes'], 'other', 'g', 0, 0, 0, 0, 0),
('tea leaves',          ARRAY['chai patti','tea powder'], 'other', 'g', 0, 0, 0, 0, 0),
('coffee powder',       ARRAY['coffee','instant coffee'], 'other', 'g', 353, 12, 41, 0.5, 0);

-- ---------------------------------------------------------------------------
-- Verification: count seeded ingredients by category
-- ---------------------------------------------------------------------------
SELECT category, count(*) AS count
FROM global_ingredients
GROUP BY category
ORDER BY count DESC;

SELECT 'Total global ingredients' AS label, count(*) AS count FROM global_ingredients;
