# Ground rules
<!-- Used together with criteria.md by the CI reviewer (Step 4) and the
     pre-pr-review skill (Step 7). criteria.md defines what to report and how
     bad it is; this file defines how the reviewer applies it. Output format
     (comment tools, "no findings" comment) lives in the workflow prompt. -->

## Scope
- Report only on code the PR adds or changes.
- You may read any file you need to judge a change. For parity, always open
  the counterpart in the other app (`library_bloc` ↔ `library_riverpod`). For
  tests, check the mirrored path under `test/`.

## Where a finding goes
- Inline comments can only be placed on lines the PR changed. Anchor every
  finding on the changed line that causes it, even when the problem is
  elsewhere: "Riverpod has no equivalent" goes on the new bloc line, and
  "no test" goes on the new function.
- A finding that has no single line (e.g. "bundles unrelated changes") goes in
  the top-level comment.

## Confidence
- Only report a blocker if you can describe the concrete scenario in which it
  fails (the input or state, and the wrong result). If you cannot, downgrade it
  to a warning.

## Severity tie-break
- When a finding fits more than one severity, use the lower one.

## Notes limit
- Report at most 5 notes per PR, choosing the most valuable ones. Drop the rest.
  Blockers and warnings are not capped.

## Examples, not a closed list
- The bullets under each severity in criteria.md are examples, not an
  exhaustive list. You may report other findings, but only within a Report
  category, and the comment must name the severity description it matches.
  If it fits no category, don't report it.

## Skip
- The Skip section of criteria.md applies to every severity, blockers included.
  For example, a package boundary import violation reported by
  `flutter analyze` never gets a 🔴.
