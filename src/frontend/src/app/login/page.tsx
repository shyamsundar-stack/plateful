import AuthForm from "@/components/auth-form";

export default async function LoginPage({
  searchParams,
}: {
  searchParams: Promise<{ mode?: string }>;
}) {
  const params = await searchParams;
  const initialMode = params.mode === "signup" ? "signup" : "signin";

  return (
    <main className="min-h-screen flex items-center justify-center bg-cream px-4">
      <AuthForm initialMode={initialMode} />
    </main>
  );
}
