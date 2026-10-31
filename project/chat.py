"""Interactive local chat, with one command for casual testing."""
from project.app import run_assistant


def main():
    mode = "baseline"
    doc = "policies"
    print("CampusAid Agent v2 — LOCAL DEMO. :mode baseline|hardened, :doc policies|poisoned|tool_output, :quit")
    print("Each question is a fresh simulated agent run; all actions are mock events.")
    while True:
        try:
            message = input(f"[{mode}/{doc}] You> ").strip()
        except (KeyboardInterrupt, EOFError):
            print()
            return
        if message in (":quit", ":exit"):
            return
        if message.startswith(":mode "):
            new_mode = message.split(" ", 1)[1].strip()
            if new_mode in ("baseline", "hardened"):
                mode = new_mode
            else:
                print("Choose baseline or hardened")
            continue
        if message.startswith(":doc "):
            new_doc = message.split(" ", 1)[1].strip()
            if new_doc in ("policies", "poisoned", "tool_output"):
                doc = new_doc
            else:
                print("Choose policies, poisoned or tool_output")
            continue
        if not message:
            continue
        try:
            result = run_assistant(message, mode=mode, doc_id=doc)
        except RuntimeError as exc:
            print(f"Local model error: {exc}")
            continue
        print("CampusAid>", result["answer"])
        for event in result["events"]:
            print("  TOOL:", event["tool"], "ALLOWED" if event["allowed"] else "DENIED",
                  "|", event["observation"])


if __name__ == "__main__":
    main()
