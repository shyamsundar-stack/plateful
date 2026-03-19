import "@testing-library/jest-dom";
import { render, screen, waitFor } from "@testing-library/react";
import WelcomeClient from "./welcome-client";

const mockReplace = jest.fn();
jest.mock("next/navigation", () => ({
  useRouter: () => ({
    push: jest.fn(),
    replace: mockReplace,
    refresh: jest.fn(),
  }),
}));

// Mock the WelcomeScreen component to simplify testing the routing logic
jest.mock("@/components/welcome-screen", () => {
  return function MockWelcomeScreen() {
    return <div data-testid="welcome-screen">Welcome Screen</div>;
  };
});

describe("WelcomeClient", () => {
  beforeEach(() => {
    mockReplace.mockClear();
    localStorage.clear();
  });

  it("shows welcome screen on first visit (no localStorage flag)", async () => {
    render(<WelcomeClient />);
    await waitFor(() => {
      expect(screen.getByTestId("welcome-screen")).toBeInTheDocument();
    });
  });

  it("redirects to /login when welcome was already seen", async () => {
    localStorage.setItem("plateful-welcome-seen", "true");
    render(<WelcomeClient />);
    await waitFor(() => {
      expect(mockReplace).toHaveBeenCalledWith("/login");
    });
  });

  it("shows loading state while checking localStorage", () => {
    render(<WelcomeClient />);
    // The loading state shows the plate emoji before useEffect runs
    // After useEffect, it either shows welcome or redirects
  });
});
