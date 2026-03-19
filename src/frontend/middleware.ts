import { createServerClient } from "@supabase/ssr";
import { NextResponse, type NextRequest } from "next/server";

export async function middleware(request: NextRequest) {
  let supabaseResponse = NextResponse.next({
    request,
  });

  const supabase = createServerClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
    {
      cookies: {
        getAll() {
          return request.cookies.getAll();
        },
        setAll(cookiesToSet) {
          cookiesToSet.forEach(({ name, value }) =>
            request.cookies.set(name, value)
          );
          supabaseResponse = NextResponse.next({
            request,
          });
          cookiesToSet.forEach(({ name, value, options }) =>
            supabaseResponse.cookies.set(name, value, options)
          );
        },
      },
    }
  );

  // IMPORTANT: use getUser() not getSession() — getUser() validates with server
  const {
    data: { user },
  } = await supabase.auth.getUser();

  // Public routes that don't require auth
  const isPublicRoute =
    request.nextUrl.pathname === "/" ||
    request.nextUrl.pathname.startsWith("/login") ||
    request.nextUrl.pathname.startsWith("/grocery/share/") ||
    request.nextUrl.pathname === "/offline";

  // Not logged in and trying to access a protected route → redirect to login
  if (!user && !isPublicRoute) {
    const url = request.nextUrl.clone();
    url.pathname = "/login";
    return NextResponse.redirect(url);
  }

  // Logged in but visiting /login → redirect to recipes
  if (user && request.nextUrl.pathname === "/login") {
    const url = request.nextUrl.clone();
    url.pathname = "/recipes";
    return NextResponse.redirect(url);
  }

  // Onboarding redirect: check if new user needs onboarding
  // Skip if already on onboarding, login, public share, or API routes
  if (
    user &&
    !request.nextUrl.pathname.startsWith("/onboarding") &&
    !isPublicRoute &&
    !request.nextUrl.pathname.startsWith("/api/")
  ) {
    // Fast path: cookie set by completeOnboarding() — skip DB queries entirely
    const onboardedCookie = request.cookies.get("plateful-onboarded");
    if (!onboardedCookie) {
      // Lightweight check: household name is still default + zero recipes
      const { data: household } = await supabase
        .from("households")
        .select("name")
        .eq("created_by", user.id)
        .eq("is_archived", false)
        .maybeSingle();

      if (household && household.name === "Kitchen") {
        const { count } = await supabase
          .from("recipes")
          .select("*", { count: "exact", head: true })
          .eq("is_archived", false);

        if ((count ?? 0) === 0) {
          const url = request.nextUrl.clone();
          url.pathname = "/onboarding";
          return NextResponse.redirect(url);
        }
      }

      // User doesn't need onboarding — set cookie to skip DB queries next time
      supabaseResponse.cookies.set("plateful-onboarded", "true", {
        path: "/",
        maxAge: 60 * 60 * 24 * 365, // 1 year
        httpOnly: true,
        sameSite: "lax",
      });
    }
  }

  return supabaseResponse;
}

export const config = {
  matcher: [
    // Match all routes except static files and Next.js internals
    "/((?!_next/static|_next/image|favicon.ico|.*\\.(?:svg|png|jpg|jpeg|gif|webp)$).*)",
  ],
};
