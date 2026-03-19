import { createClient } from "@/lib/supabase/server";
import type { Household, HouseholdMember, MealRule, FestivalCalendarEntry, ThaliTemplateWithDishes } from "@/lib/types/database";
import Header from "@/components/header";
import SettingsPanel from "@/components/settings-panel";
import RulesManager from "@/components/rules-manager";
import ThaliTemplateManager from "@/components/thali-template-manager";

export default async function SettingsPage() {
  let household: Household | null = null;
  let members: HouseholdMember[] = [];
  let mealRules: MealRule[] = [];
  let festivals: FestivalCalendarEntry[] = [];
  let thaliTemplates: ThaliTemplateWithDishes[] = [];
  let error: string | null = null;

  try {
    const supabase = await createClient();

    const {
      data: { user },
    } = await supabase.auth.getUser();

    if (!user) {
      error = "Not authenticated";
    } else {
      // Get household
      const { data: hhData, error: hhError } = await supabase
        .from("households")
        .select("*")
        .eq("created_by", user.id)
        .eq("is_archived", false)
        .single();

      if (hhError || !hhData) {
        error = "Household not found";
      } else {
        household = hhData as Household;

        // Get members
        const { data: memData } = await supabase
          .from("household_members")
          .select("*")
          .eq("household_id", household.id)
          .eq("is_archived", false)
          .order("created_at");

        members = (memData ?? []) as HouseholdMember[];

        // Fetch meal rules for this household
        const { data: rulesData } = await supabase
          .from("meal_rules")
          .select("*")
          .eq("household_id", household.id)
          .order("priority", { ascending: true });

        mealRules = (rulesData ?? []) as MealRule[];

        // Fetch festival calendar
        const currentYear = new Date().getFullYear();
        const { data: festData } = await supabase
          .from("festival_calendar")
          .select("*")
          .gte("year", currentYear)
          .order("start_date");

        festivals = (festData ?? []) as FestivalCalendarEntry[];

        // Fetch thali templates (global + household)
        const { data: thaliData } = await supabase
          .from("thali_templates")
          .select("*, thali_template_dishes(*)")
          .or(`household_id.is.null,household_id.eq.${household.id}`)
          .eq("is_archived", false)
          .order("name");

        thaliTemplates = (thaliData ?? []) as ThaliTemplateWithDishes[];
      }
    }
  } catch {
    error = "Failed to load settings";
  }

  return (
    <div className="min-h-screen bg-cream">
      <Header />
      <main className="max-w-3xl mx-auto px-4 py-6">
        <h1 className="text-2xl font-bold text-ink mb-1">Settings</h1>
        <p className="text-sm text-ink-muted mb-6">
          Manage your household and member profiles
        </p>

        {error || !household ? (
          <div className="text-center py-16">
            <span className="text-5xl">😕</span>
            <h3 className="text-lg font-semibold text-ink mt-4">
              {error || "Settings not available"}
            </h3>
          </div>
        ) : (
          <>
            <SettingsPanel household={household} members={members} />
            <div className="mt-6">
              <RulesManager rules={mealRules} festivals={festivals} members={members} />
            </div>
            <div className="mt-6">
              <ThaliTemplateManager templates={thaliTemplates} />
            </div>
          </>
        )}
      </main>
    </div>
  );
}
