"use server";

import { createClient } from "@/lib/supabase/server";

export type AnalyticsSummary = {
  totalRecipes: number;
  activeRecipes: number;
  favoriteRecipes: number;
  libraryImports: number;
  mealsPlanned: number;
  groceryListsGenerated: number;
  autoFillCount: number;
  topRecipes: { title: string; count: number }[];
  favoriteCuisines: { cuisine: string; count: number }[];
  cookingStreak: number;
  totalMembers: number;
};

/**
 * Fetch a summary of analytics for the current household.
 * Uses parallel aggregate queries for speed.
 */
export async function fetchAnalyticsSummary(): Promise<AnalyticsSummary> {
  const supabase = await createClient();
  const { data: householdId } = await supabase.rpc("get_my_household_id");

  if (!householdId) {
    return emptyStats();
  }

  // Run all queries in parallel
  const [
    recipesResult,
    activeResult,
    favoriteResult,
    libraryResult,
    membersResult,
    slotsResult,
    groceryResult,
    autoFillResult,
    topRecipesResult,
    cuisinesResult,
    weekPlansResult,
  ] = await Promise.all([
    // Total recipes
    supabase
      .from("recipes")
      .select("id", { count: "exact", head: true })
      .eq("household_id", householdId)
      .eq("is_archived", false),

    // Active recipes
    supabase
      .from("recipes")
      .select("id", { count: "exact", head: true })
      .eq("household_id", householdId)
      .eq("status", "active")
      .eq("is_archived", false),

    // Favorite recipes
    supabase
      .from("recipes")
      .select("id", { count: "exact", head: true })
      .eq("household_id", householdId)
      .eq("is_favorite", true)
      .eq("is_archived", false),

    // Library imports
    supabase
      .from("recipes")
      .select("id", { count: "exact", head: true })
      .eq("household_id", householdId)
      .eq("source_type", "library_import"),

    // Total members
    supabase
      .from("household_members")
      .select("id", { count: "exact", head: true })
      .eq("household_id", householdId)
      .eq("is_archived", false),

    // Meals planned (meal_slots with a recipe assigned, last 4 weeks)
    supabase
      .from("meal_slots")
      .select("id, week_plans!inner(household_id)", { count: "exact", head: true })
      .eq("week_plans.household_id", householdId)
      .not("recipe_id", "is", null),

    // Grocery lists generated
    supabase
      .from("grocery_lists")
      .select("id", { count: "exact", head: true })
      .eq("household_id", householdId),

    // Auto-fill events
    supabase
      .from("analytics_events")
      .select("id", { count: "exact", head: true })
      .eq("household_id", householdId)
      .eq("event_type", "auto_fill_week"),

    // Top 5 most-assigned recipes
    supabase
      .from("meal_slots")
      .select("recipe_id, recipes!inner(title, household_id)")
      .eq("recipes.household_id", householdId)
      .not("recipe_id", "is", null)
      .limit(500),

    // Cuisine distribution
    supabase
      .from("recipes")
      .select("cuisine")
      .eq("household_id", householdId)
      .eq("is_archived", false)
      .not("cuisine", "is", null),

    // Week plans for streak
    supabase
      .from("week_plans")
      .select("start_date")
      .eq("household_id", householdId)
      .eq("is_archived", false)
      .order("start_date", { ascending: false })
      .limit(52),
  ]);

  // Compute top recipes
  const recipeCount = new Map<string, number>();
  if (topRecipesResult.data) {
    for (const slot of topRecipesResult.data as unknown as Array<{ recipe_id: string; recipes: { title: string } }>) {
      const title = slot.recipes?.title ?? "Unknown";
      recipeCount.set(title, (recipeCount.get(title) ?? 0) + 1);
    }
  }
  const topRecipes = Array.from(recipeCount.entries())
    .map(([title, count]) => ({ title, count }))
    .sort((a, b) => b.count - a.count)
    .slice(0, 5);

  // Compute cuisine breakdown
  const cuisineCount = new Map<string, number>();
  if (cuisinesResult.data) {
    for (const r of cuisinesResult.data as Array<{ cuisine: string | null }>) {
      if (r.cuisine) {
        cuisineCount.set(r.cuisine, (cuisineCount.get(r.cuisine) ?? 0) + 1);
      }
    }
  }
  const favoriteCuisines = Array.from(cuisineCount.entries())
    .map(([cuisine, count]) => ({ cuisine, count }))
    .sort((a, b) => b.count - a.count)
    .slice(0, 5);

  // Compute cooking streak (consecutive weeks with plans)
  let cookingStreak = 0;
  if (weekPlansResult.data && weekPlansResult.data.length > 0) {
    const dates = weekPlansResult.data.map((wp) => new Date(wp.start_date).getTime());
    const oneWeek = 7 * 24 * 60 * 60 * 1000;
    // Find latest Monday
    const now = new Date();
    const dayOfWeek = now.getDay(); // 0=Sun
    const mondayOffset = dayOfWeek === 0 ? 6 : dayOfWeek - 1;
    const latestMonday = new Date(now.getFullYear(), now.getMonth(), now.getDate() - mondayOffset);
    let expectedWeek = latestMonday.getTime();

    for (const d of dates) {
      // Check if this plan's start_date matches the expected week (within 1 day tolerance)
      if (Math.abs(d - expectedWeek) < 2 * 24 * 60 * 60 * 1000) {
        cookingStreak++;
        expectedWeek -= oneWeek;
      } else if (d < expectedWeek) {
        break;
      }
    }
  }

  return {
    totalRecipes: recipesResult.count ?? 0,
    activeRecipes: activeResult.count ?? 0,
    favoriteRecipes: favoriteResult.count ?? 0,
    libraryImports: libraryResult.count ?? 0,
    mealsPlanned: slotsResult.count ?? 0,
    groceryListsGenerated: groceryResult.count ?? 0,
    autoFillCount: autoFillResult.count ?? 0,
    topRecipes,
    favoriteCuisines,
    cookingStreak,
    totalMembers: membersResult.count ?? 0,
  };
}

function emptyStats(): AnalyticsSummary {
  return {
    totalRecipes: 0,
    activeRecipes: 0,
    favoriteRecipes: 0,
    libraryImports: 0,
    mealsPlanned: 0,
    groceryListsGenerated: 0,
    autoFillCount: 0,
    topRecipes: [],
    favoriteCuisines: [],
    cookingStreak: 0,
    totalMembers: 0,
  };
}
