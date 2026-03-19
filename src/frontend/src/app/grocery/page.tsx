import { createClient } from "@/lib/supabase/server";
import Header from "@/components/header";
import WeekNavigator from "@/components/week-navigator";
import GroceryListView from "@/components/grocery-list-view";
import GenerateGroceryButton from "@/components/generate-grocery-button";
import type {
  GroceryList,
  GroceryItem,
} from "@/lib/types/database";

function getMonday(date: Date = new Date()): string {
  const d = new Date(date);
  const day = d.getDay();
  const diff = day === 0 ? -6 : 1 - day;
  d.setDate(d.getDate() + diff);
  return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, "0")}-${String(d.getDate()).padStart(2, "0")}`;
}

export default async function GroceryPage({
  searchParams,
}: {
  searchParams: Promise<{ week?: string }>;
}) {
  const params = await searchParams;
  const monday = params.week || getMonday();

  const supabase = await createClient();

  // Fetch week plan
  const { data: weekPlan } = await supabase
    .from("week_plans")
    .select("*")
    .eq("start_date", monday)
    .eq("is_archived", false)
    .maybeSingle();

  if (!weekPlan) {
    return (
      <div className="min-h-screen bg-cream">
        <Header />
        <main className="max-w-2xl mx-auto px-4 py-6">
          <WeekNavigator currentMonday={monday} basePath="/grocery" />
          <EmptyState message="No meal plan for this week" sub="Plan your week first, then generate a grocery list." />
        </main>
      </div>
    );
  }

  // Check for existing grocery list
  const { data: groceryList } = await supabase
    .from("grocery_lists")
    .select("*")
    .eq("week_plan_id", weekPlan.id)
    .eq("status", "active")
    .maybeSingle();

  // Fetch items if list exists
  let items: GroceryItem[] = [];
  if (groceryList) {
    const { data: itemData } = await supabase
      .from("grocery_items")
      .select("*")
      .eq("grocery_list_id", groceryList.id)
      .order("category")
      .order("sort_order")
      .order("name");

    items = (itemData ?? []) as GroceryItem[];
  }

  return (
    <div className="min-h-screen bg-cream">
      <Header />
      <main className="max-w-2xl mx-auto px-4 py-6">
        <WeekNavigator currentMonday={monday} basePath="/grocery" />

        {groceryList ? (
          <GroceryListView
            groceryList={groceryList as GroceryList}
            items={items}
            weekPlanId={weekPlan.id}
          />
        ) : (
          <div className="mt-8 text-center">
            <p className="text-5xl mb-4">🛒</p>
            <h2 className="text-lg font-semibold text-ink mb-2">
              Ready to generate your grocery list
            </h2>
            <p className="text-sm text-ink-muted mb-6">
              We&apos;ll aggregate all ingredients from this week&apos;s recipes,
              merge duplicates, and group by store section.
            </p>
            <GenerateGroceryButton weekPlanId={weekPlan.id} />
          </div>
        )}
      </main>
    </div>
  );
}

function EmptyState({ message, sub }: { message: string; sub: string }) {
  return (
    <div className="mt-12 text-center">
      <p className="text-5xl mb-4">🛒</p>
      <h2 className="text-lg font-semibold text-ink mb-2">{message}</h2>
      <p className="text-sm text-ink-muted">{sub}</p>
    </div>
  );
}
