import { createClient } from "@/lib/supabase/server";
import { getCategoryLabel, getCategoryOrder, formatQuantity } from "@/lib/grocery";
import SharedGroceryClient from "./shared-grocery-client";

// This page is PUBLIC — no auth required. Uses RPC functions that bypass RLS.

export default async function SharedGroceryPage({
  params,
}: {
  params: Promise<{ token: string }>;
}) {
  const { token } = await params;
  const supabase = await createClient();

  // Fetch grocery list via SECURITY DEFINER function (no RLS)
  const { data: listData, error: listError } = await supabase.rpc(
    "get_grocery_list_by_token",
    { p_token: token }
  );

  const groceryList = listData?.[0];

  if (listError || !groceryList) {
    return (
      <div className="min-h-screen bg-cream flex items-center justify-center">
        <div className="text-center">
          <p className="text-5xl mb-4">🔗</p>
          <h1 className="text-lg font-semibold text-ink mb-2">
            List not found
          </h1>
          <p className="text-sm text-ink-muted">
            This grocery list link may have expired or been removed.
          </p>
        </div>
      </div>
    );
  }

  // Fetch items via SECURITY DEFINER function
  const { data: itemsData } = await supabase.rpc(
    "get_grocery_items_by_token",
    { p_token: token }
  );

  const items = (itemsData ?? []).filter(
    (i: { is_already_have: boolean }) => !i.is_already_have
  );

  // Group by category
  const categories = getCategoryOrder();
  const groupedItems = new Map<
    string,
    Array<{
      id: string;
      name: string;
      quantity: number | null;
      unit: string | null;
      is_checked: boolean;
      recipe_sources: string[] | null;
      category: string;
    }>
  >();
  for (const item of items) {
    const existing = groupedItems.get(item.category) ?? [];
    existing.push(item);
    groupedItems.set(item.category, existing);
  }

  // Serialize for client component
  const categoryGroups = categories
    .filter((cat) => (groupedItems.get(cat) ?? []).length > 0)
    .map((cat) => ({
      category: cat,
      label: getCategoryLabel(cat),
      items: (groupedItems.get(cat) ?? []).map((item) => ({
        id: item.id,
        name: item.name,
        quantity: item.quantity,
        unit: item.unit,
        serverChecked: item.is_checked,
        recipe_sources: item.recipe_sources,
        formattedQuantity:
          item.quantity != null ? formatQuantity(item.quantity, item.unit) : null,
      })),
    }));

  const totalItems = items.length;
  const serverCheckedCount = items.filter(
    (i: { is_checked: boolean }) => i.is_checked
  ).length;

  return (
    <SharedGroceryClient
      token={token}
      categoryGroups={categoryGroups}
      totalItems={totalItems}
      serverCheckedCount={serverCheckedCount}
    />
  );
}
