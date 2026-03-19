type StatusBadgeProps = {
  status: "draft" | "active" | "archived";
};

export default function StatusBadge({ status }: StatusBadgeProps) {
  const styles = {
    draft: "bg-draft/15 text-draft border-draft/30",
    active: "bg-active/15 text-active border-active/30",
    archived: "bg-ink-light/15 text-ink-muted border-ink-light/30",
  };

  const labels = {
    draft: "Draft",
    active: "Active",
    archived: "Archived",
  };

  return (
    <span
      className={`inline-flex items-center px-2 py-0.5 rounded-full text-xs font-semibold border ${styles[status]}`}
    >
      {labels[status]}
    </span>
  );
}
