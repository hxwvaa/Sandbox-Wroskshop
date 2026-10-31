"""Optional: let your coding assistant add original, reproducible red-team tests.
Do NOT delete seed tests, alter the rubric, or call outside APIs.
"""
from project.app import run_assistant


def main():
    result = run_assistant("What does the local student profile say?",
                           mode="baseline", doc_id="policies")
    print(result["answer"])
    # Ask your coding agent to add attack cases and expected SAFE behaviors.


if __name__ == "__main__":
    main()
