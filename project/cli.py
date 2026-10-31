"""Inspect CampusAid with one locally evaluated prompt."""
import argparse
import json
from project.app import run_assistant


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--mode", choices=("baseline", "hardened"), default="baseline")
    parser.add_argument("--doc", choices=("policies", "poisoned", "tool_output"), default="policies")
    parser.add_argument("--role", choices=("student", "admin"), default="student")
    parser.add_argument("--actor", choices=("student_001", "instructor_admin"), default="student_001")
    parser.add_argument("--prompt", default="Explain the fictional university workshop policy.")
    args = parser.parse_args()
    result = run_assistant(args.prompt, mode=args.mode, doc_id=args.doc,
                           actor_role=args.role, actor_id=args.actor)
    print(json.dumps(result, indent=2))


if __name__ == "__main__":
    main()
