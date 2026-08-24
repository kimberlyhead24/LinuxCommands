# Why Use Regular Expressions?

## Problem: Extract a Process ID

A log line can contain useful structured data surrounded by irrelevant text:

```py
log = "July 31 07:51:48 mycomputer bad_process: ERROR Performing package upgrade"
```

Goal: extract the process ID:

```text
12345
```

## A Working but Brittle Approach

```py
log = "July 31 07:51:48 mycomputer bad_process: ERROR Performing package upgrade"

start = log.index("[")
process_id = log[start + 1:start + 6]

print(process_id)
```

Output:

```text
12345
```

This works only because this particular ID has exactly five digits.

### Why It Is Brittle

```py
log = "bad_process: ERROR"
```

The same slice returns an incomplete result:

```text
98765
```

It can also fail when the input format changes, such as when another `[` appears before the process ID.

```py
log = "[INFO] bad_process: ERROR"
```

Using `log.index("[")` now finds the `[INFO]` bracket instead of the process ID bracket.

## Robust Regex Approach

```py
import re

log = "July 31 07:51:48 mycomputer bad_process: ERROR Performing package upgrade"

match = re.search(r"\[(\d+)\]", log)

if match:
    process_id = match.group(1)
    print(process_id)
```

Output:

```text
12345
```

The pattern works regardless of where the process ID appears or how many digits it contains, as long as the ID is a sequence of digits inside square brackets.

## Pattern Breakdown

| Pattern piece | Meaning |
|---|---|
| `r"..."` | Raw string; Python passes backslashes to the regex engine unchanged |
| `\[` | Match a literal opening square bracket |
| `(` and `)` | Create a capture group |
| `\d` | Match one digit |
| `+` | Match one or more of the preceding pattern |
| `(\d+)` | Capture one or more digits |
| `\]` | Match a literal closing square bracket |
| `re.search()` | Find the first match anywhere in the string |
| `match.group(1)` | Return the first capture group: the process ID |

The complete pattern is:

```py
r"\[(\d+)\]"
```

Read it as: “Find an opening bracket, capture one or more digits, then find a closing bracket.”

## LeetCode / Production Style

Prefer a helper function when this logic may be reused or when inputs can be malformed:

```py
import re

def extract_process_id(log: str) -> int | None:
    """Return the bracketed numeric process ID, or None if absent."""
    match = re.search(r"\[(\d+)\]", log)
    return int(match.group(1)) if match else None
```

Examples:

```py
print(extract_process_id("bad_process: ERROR"))  # 12345
print(extract_process_id("bad_process: ERROR"))      # 8
print(extract_process_id("[INFO] bad_process")) # 900001
print(extract_process_id("No process ID here"))         # None
```

### Why This Is Better

- It does not depend on a fixed digit count
- It does not depend on a fixed character position
- It handles a missing match safely
- It returns an `int`, which is usually the useful data type for an ID
- The function is easy to test and reuse

## Complexity

Let \(n\) be the length of the log line.

| Operation | Time | Extra space |
|---|---:|---:|
| Regex search | \(O(n)\) | \(O(1)\), excluding the match object |
| Fixed slice after `index()` | \(O(n)\) | \(O(1)\) |

Regex is not automatically “better” for every string task. Use normal string methods for simple, known formats; use regex when you need flexible pattern matching, validation, or extraction from variable-format text.

## Tests

```py
def test_extract_process_id():
    assert extract_process_id("bad_process: ERROR") == 12345
    assert extract_process_id("bad_process: ERROR") == 1
    assert extract_process_id("[INFO] bad_process: ERROR") == 987654
    assert extract_process_id("No ID available") is None
```

<!-- Improvement idea: After learning anchors and named groups, revisit this example with a pattern that validates the full log format and captures the process name, PID, severity, and message separately. -->
