import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import WelcomeClient from "./welcome-client";

export default async function Home() {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();

  // Logged-in users go straight to recipes
  if (user) {
    redirect("/recipes");
  }

  // Not logged in — show welcome screen (client decides if first-time or redirect to login)
  return <WelcomeClient />;
}
