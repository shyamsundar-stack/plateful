"use client";

type Tab = {
  key: string;
  label: string;
};

type TabSwitcherProps = {
  tabs: Tab[];
  activeTab: string;
  onTabChange: (key: string) => void;
};

export default function TabSwitcher({
  tabs,
  activeTab,
  onTabChange,
}: TabSwitcherProps) {
  return (
    <div className="flex bg-cream rounded-lg p-1 border border-ink-light/20">
      {tabs.map((tab) => (
        <button
          key={tab.key}
          type="button"
          onClick={() => onTabChange(tab.key)}
          className={`flex-1 py-2 px-3 text-sm font-semibold rounded-md transition-all ${
            activeTab === tab.key
              ? "bg-surface text-ink shadow-sm"
              : "text-ink-muted hover:text-ink"
          }`}
        >
          {tab.label}
        </button>
      ))}
    </div>
  );
}
