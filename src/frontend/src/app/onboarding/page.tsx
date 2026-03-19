import { redirect } from "next/navigation";
import { checkOnboardingStatus } from "@/lib/actions/onboarding-actions";
import { fetchGlobalRecipes } from "@/lib/actions/global-recipe-actions";
import OnboardingWizard from "@/components/onboarding-wizard";
import type { GlobalRecipe } from "@/lib/types/database";

export default async function OnboardingPage() {
  const { needsOnboarding, household, members } =
    await checkOnboardingStatus();

  // Already set up — go to planner
  if (!needsOnboarding || !household) {
    redirect("/planner");
  }

  // Fetch a selection of popular global recipes for the onboarding picker
  let globalRecipes: GlobalRecipe[] = [];
  try {
    globalRecipes = await fetchGlobalRecipes();
  } catch {
    // Non-critical — onboarding can still work with paste import
  }

  return (
    <div className="min-h-screen bg-cream flex flex-col items-center justify-center px-4 py-8">
      <OnboardingWizard
        household={household}
        members={members}
        globalRecipes={globalRecipes}
      />
    </div>
  );
}
