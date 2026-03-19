import "@testing-library/jest-dom";
import { render, screen, fireEvent, act } from "@testing-library/react";
import WelcomeScreen from "./welcome-screen";

// Mock next/navigation
const mockPush = jest.fn();
jest.mock("next/navigation", () => ({
  useRouter: () => ({
    push: mockPush,
    replace: jest.fn(),
    refresh: jest.fn(),
  }),
}));

// Mock localStorage
const localStorageMock = (() => {
  let store: Record<string, string> = {};
  return {
    getItem: jest.fn((key: string) => store[key] ?? null),
    setItem: jest.fn((key: string, value: string) => {
      store[key] = value;
    }),
    clear: () => {
      store = {};
    },
  };
})();
Object.defineProperty(window, "localStorage", { value: localStorageMock });

describe("WelcomeScreen", () => {
  beforeEach(() => {
    mockPush.mockClear();
    localStorageMock.clear();
    localStorageMock.getItem.mockClear();
    localStorageMock.setItem.mockClear();
  });

  // Test 1: First visit shows welcome screen with slide 1
  it("shows the first slide on initial render", () => {
    render(<WelcomeScreen />);
    expect(
      screen.getByText("Plan meals your family actually wants to eat")
    ).toBeInTheDocument();
  });

  // Test 2: Dot tap navigates to corresponding slide
  it("navigates to slide 2 when second dot is clicked", () => {
    render(<WelcomeScreen />);
    const dots = screen.getAllByRole("tab");
    fireEvent.click(dots[1]);
    expect(
      screen.getByText("One tap to your grocery list")
    ).toBeInTheDocument();
  });

  // Test 3: Next button advances to next slide
  it("advances to next slide when Next button is clicked", () => {
    render(<WelcomeScreen />);
    fireEvent.click(screen.getByText("Next"));
    expect(
      screen.getByText("One tap to your grocery list")
    ).toBeInTheDocument();
  });

  // Test 4: Get Started sets localStorage and navigates to /login?mode=signup
  it("navigates to /login?mode=signup on Get Started", () => {
    render(<WelcomeScreen />);
    // Go to last slide
    const dots = screen.getAllByRole("tab");
    fireEvent.click(dots[2]);
    // Click Get Started
    fireEvent.click(screen.getByText("Get Started"));
    expect(localStorageMock.setItem).toHaveBeenCalledWith(
      "plateful-welcome-seen",
      "true"
    );
    expect(mockPush).toHaveBeenCalledWith("/login?mode=signup");
  });

  // Test 5: "I already have an account" navigates to /login?mode=signin
  it("navigates to /login?mode=signin on Already Have Account", () => {
    render(<WelcomeScreen />);
    // Go to last slide
    const dots = screen.getAllByRole("tab");
    fireEvent.click(dots[2]);
    // Click already have account
    fireEvent.click(screen.getByText("I already have an account"));
    expect(mockPush).toHaveBeenCalledWith("/login?mode=signin");
  });

  // Test 6: Skip button sets localStorage and navigates to /login?mode=signin
  it("navigates to /login?mode=signin on Skip", () => {
    render(<WelcomeScreen />);
    fireEvent.click(screen.getByText("Skip"));
    expect(localStorageMock.setItem).toHaveBeenCalledWith(
      "plateful-welcome-seen",
      "true"
    );
    expect(mockPush).toHaveBeenCalledWith("/login?mode=signin");
  });

  // Test 7: Swipe left advances to next slide
  it("advances slide on swipe left", () => {
    render(<WelcomeScreen />);
    const slidesArea = screen
      .getByText("Plan meals your family actually wants to eat")
      .closest("[class*='flex-1']")!;

    fireEvent.touchStart(slidesArea, {
      touches: [{ clientX: 300 }],
    });
    fireEvent.touchMove(slidesArea, {
      touches: [{ clientX: 200 }],
    });
    fireEvent.touchEnd(slidesArea);

    expect(
      screen.getByText("One tap to your grocery list")
    ).toBeInTheDocument();
  });

  // Test 8: Swipe right goes to previous slide
  it("goes to previous slide on swipe right", () => {
    render(<WelcomeScreen />);
    // First go to slide 2
    const dots = screen.getAllByRole("tab");
    fireEvent.click(dots[1]);
    expect(
      screen.getByText("One tap to your grocery list")
    ).toBeInTheDocument();

    const slidesArea = screen
      .getByText("One tap to your grocery list")
      .closest("[class*='flex-1']")!;

    // Swipe right
    fireEvent.touchStart(slidesArea, {
      touches: [{ clientX: 100 }],
    });
    fireEvent.touchMove(slidesArea, {
      touches: [{ clientX: 250 }],
    });
    fireEvent.touchEnd(slidesArea);

    expect(
      screen.getByText("Plan meals your family actually wants to eat")
    ).toBeInTheDocument();
  });

  // Test 9: Cannot swipe past last slide
  it("stays on last slide when swiping left at the end", () => {
    render(<WelcomeScreen />);
    // Go to last slide
    const dots = screen.getAllByRole("tab");
    fireEvent.click(dots[2]);

    const slidesArea = screen
      .getByText("Weekend prep, weekday freedom")
      .closest("[class*='flex-1']")!;

    // Try to swipe left past end
    fireEvent.touchStart(slidesArea, {
      touches: [{ clientX: 300 }],
    });
    fireEvent.touchMove(slidesArea, {
      touches: [{ clientX: 200 }],
    });
    fireEvent.touchEnd(slidesArea);

    // Still on last slide
    expect(
      screen.getByText("Weekend prep, weekday freedom")
    ).toBeInTheDocument();
  });

  // Test 10: Keyboard arrow right advances slide
  it("advances slide on ArrowRight keypress", () => {
    render(<WelcomeScreen />);

    act(() => {
      fireEvent.keyDown(window, { key: "ArrowRight" });
    });

    expect(
      screen.getByText("One tap to your grocery list")
    ).toBeInTheDocument();
  });
});
