# Safely Extract Structured Data

## Use this when

Use this pattern when a string contains structured data you want to extract, but some inputs may not contain that data.

Examples:

- Process IDs in log lines
- Order IDs in messages
- Numbers inside brackets
- Dates in filenames
- Status codes in server output

## Goal: Extract a PID

Example log line:

```py
log = "July 31 07:51:48 mycomputer bad_process: ERROR Performing package upgrade"
```

Desired value:

```text
12345
```

## The Regex

```py
r"\[(\d+)\]"
```

Read it left to right:

| Pattern part | Meaning |
|---|---|
| `\[` | Match a literal opening square bracket |
| `(` | Start capture group 1 |
| `\d+` | Match one or more digits |
| `)` | End capture group 1 |
| `\]` | Match a literal closing square bracket |

The whole match is:

```text

```

Capture group 1 is:

```text
12345
```

The transcript walks through this exact construction: square brackets are escaped because they are regex metacharacters, and `(\d+)` captures the one-or-more-digit PID value. [page:69]

## Basic Extraction

```py
import re

log = "July 31 07:51:48 mycomputer bad_process: ERROR Performing package upgrade"

match = re.search(r"\[(\d+)\]", log)

if match:
    print(match.group(1))
```

Output:

```text
12345
```

Use `match.group(1)` instead of `match[1]` in your own code because it makes the capture-group intent obvious.

## The Failure Case

This input has brackets but no numeric PID:

```py
log = "99 elephants in a [cage]"
```

```py
import re

match = re.search(r"\[(\d+)\]", log)

print(match.group(1))  # Fails: match is None
```

`re.search()` returns `None` when the pattern is absent. Accessing a capture group before checking for `None` causes an `AttributeError`. The video specifically demonstrates this failure, then turns the logic into a safe function. [page:69]

## Best-Practice Function

```py
import re

PID_PATTERN = re.compile(r"\[(\d+)\]")

def extract_pid(log_line: str) -> int | None:
    """Return the first bracketed numeric PID, or None if none exists."""
    match = PID_PATTERN.search(log_line)

    if match is None:
        return None

    return int(match.group(1))
```

```py
assert extract_pid("bad_process: ERROR") == 12345
assert extract_pid("worker: running") == 7
assert extract_pid("99 elephants in a [cage]") is None
assert extract_pid("No PID here") is None
```

## Course Version vs Recommended Version

| Choice | Course version | Recommended default |
|---|---|---|
| No match | Return `""` | Return `None` |
| PID type | String | `int` |
| Regex creation | Inside function | Compile once if reused |
| Capture access | `result[1]` | `match.group(1)` |
| Match check | Check `result is None` | Same |

The course deliberately returns an empty string when no PID is found because what to do on failure depends on the surrounding program. [page:69]

### When an Empty String Is Right

Return `""` if the result is going directly into display text or a CSV field where blank means “unavailable.”

```py
def extract_pid_text(log_line: str) -> str:
    match = PID_PATTERN.search(log_line)
    return match.group(1) if match else ""
```

### When `None` Is Better

Return `None` if callers need to distinguish “not found” from a real string or make a decision based on absence.

```py
pid = extract_pid(log_line)

if pid is None:
    print("No numeric process ID in this log line")
else:
    print(f"Process ID: {pid}")
```

## Make Patterns Specific

The simple pattern finds any bracketed number anywhere in the line:

```py
r"\[(\d+)\]"
```

That is ideal when the only requirement is “extract the first bracketed number.”

If you need to ensure it is attached to a process name, use named groups:

```py
PROCESS_PATTERN = re.compile(r"(?P<process>[\w-]+)\[(?P<pid>\d+)\]")
```

```py
def extract_process_and_pid(log_line: str) -> tuple[str, int] | None:
    match = PROCESS_PATTERN.search(log_line)

    if not match:
        return None

    return match.group("process"), int(match.group("pid"))
```

```py
assert extract_process_and_pid("bad-process: ERROR") == (
    "bad-process",
    12345,
)
```

## General Extraction Template

```py
import re

PATTERN = re.compile(r"YOUR_PATTERN_WITH_(CAPTURES)")

def extract_value(text: str) -> str | None:
    match = PATTERN.search(text)

    if not match:
        return None

    return match.group(1)
```

Use this sequence every time:

1. Define the smallest pattern that matches valid structure.
2. Capture only the value you need with parentheses.
3. Search the text.
4. Check whether a match exists.
5. Return a useful type (`int`, `str`, `dict`, tuple, or `None`).
6. Test both valid and invalid input.

## Regex vs Non-Regex

Do not use regex merely because brackets exist.

For a guaranteed simple format such as exactly `process[12345]`, string methods can be enough:

```py
text = "process"

start = text.find("[")
end = text.find("]", start)

pid = text[start + 1:end] if start != -1 and end != -1 else None
```

But regex is better when:

- The PID can be anywhere in a larger line
- The ID length varies
- You require digits only
- Inputs may contain unrelated text
- You need captures from several structured fields

## Complexity

For this straightforward pattern, scanning a log line of length \(n\) is generally \(O(n)\) time. Compiling the regex once is useful when processing many log lines, because it avoids rebuilding the same pattern repeatedly.

<!-- Improvement idea: Add a small `parse-log-lines.py` practice script that reads a log file, extracts all valid PIDs with `finditer()`, skips malformed lines, and reports the number of valid versus invalid entries. -->
