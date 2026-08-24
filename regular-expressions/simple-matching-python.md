# Simple Matching in Python

## Goal

Use Python's built-in `re` module to search text with regular expressions.

```py
import re
```

The main function in this lesson is:

```py
re.search(pattern, text)
```

It looks for the **first** place the pattern appears anywhere in the text.

- Returns a `Match` object when it finds a match
- Returns `None` when no match exists

## Basic Literal Search

```py
import re

result = re.search(r"aza", "plaza")
print(result)
```

Output:

```text
<re.Match object; span=(2, 5), match='aza'>
```

The pattern `r"aza"` matches the substring `aza` inside `plaza`.

```py
result = re.search(r"aza", "bazaar")
print(result)
```

Output:

```text
<re.Match object; span=(1, 4), match='aza'>
```

The same substring matches, but at a different location.

## Raw Strings: Always Prefer `r"..."`

Write regex patterns as raw strings:

```py
r"\d+"
```

Instead of:

```py
"\d+"
```

A raw string tells Python to pass backslashes through unchanged to the regex engine.

This matters when patterns use regex escapes such as:

```py
r"\d"   # digit
r"\s"   # whitespace
r"\b"   # word boundary
r"\."   # literal period
```

For simple text like `r"aza"`, a raw string and normal string behave the same. Still, use raw strings consistently so your code stays correct as patterns become more complex.

## No Match Returns `None`

```py
import re

result = re.search(r"aza", "maze")
print(result)
```

Output:

```text
None
```

Never call `.group()` or `.span()` without first ensuring a match exists.

Bad:

```py
result = re.search(r"aza", "maze")
print(result.group())  # AttributeError: 'NoneType' object has no attribute 'group'
```

Good:

```py
result = re.search(r"aza", "maze")

if result is not None:
    print(result.group())
else:
    print("No match found")
```

## Match Objects

A `Match` object stores details about the first match.

```py
import re

result = re.search(r"aza", "plaza")

print(result.group())
print(result.span())
print(result.start())
print(result.end())
```

Output:

```text
aza
(2, 5)
2
5
```

| Method | Meaning |
|---|---|
| `match.group()` | The text that matched |
| `match.span()` | A tuple with the start and end indexes |
| `match.start()` | Starting index of the match |
| `match.end()` | Index immediately after the match |
| `match.group(1)` | Text captured by the first parenthesized group |

The end index is exclusive, matching normal Python slicing behavior:

```py
text = "plaza"
print(text[2:5])  # aza
```

## Start Anchor: `^`

The caret `^` requires a pattern to appear at the start of the string.

```py
import re

print(re.search(r"^x", "xenon"))
```

Output:

```text
<re.Match object; span=(0, 1), match='x'>
```

This does not match because `x` is not the first character:

```py
print(re.search(r"^x", "oxygen"))
```

Output:

```text
None
```

## Wildcard: `.`

A dot matches exactly one character, except a newline by default.

```py
import re

result = re.search(r"p.ng", "penguin")
print(result.group())
```

Output:

```text
peng
```

Pattern breakdown:

| Pattern piece | Meaning |
|---|---|
| `p` | Literal `p` |
| `.` | Any one character |
| `n` | Literal `n` |
| `g` | Literal `g` |
| `p.ng` | `p`, one character, `n`, then `g` |

These strings also match `p.ng`:

```py
re.search(r"p.ng", "ping")
re.search(r"p.ng", "pong")
re.search(r"p.ng", "Pang")
```

If you need a literal period, escape it:

```py
re.search(r"v1\.2", "Release v1.2")
```

## Case-Insensitive Search

By default, regex matching is case-sensitive.

```py
import re

print(re.search(r"p.ng", "Pangaea"))
```

Output:

```text
None
```

Pass `re.IGNORECASE` to ignore letter case:

```py
import re

result = re.search(r"p.ng", "Pangaea", re.IGNORECASE)
print(result.group())
```

Output:

```text
Pang
```

A common shorter alias is `re.I`:

```py
re.search(r"error", "ERROR: Disk full", re.I)
```

## Course Examples

```py
import re

print(re.search(r"aza", "plaza"))
print(re.search(r"aza", "bazaar"))
print(re.search(r"aza", "maze"))

print(re.search(r"^x", "xenon"))

print(re.search(r"p.ng", "penguin"))
print(re.search(r"p.ng", "Pangaea", re.IGNORECASE))
```

Expected behavior:

```text
Match
Match
None
Match
Match
Match
```

## Better Coding Style

Do not print a raw `Match` object in normal application code. Use the result based on your goal.

### Check whether text matches

```py
import re

def contains_pattern(text: str, pattern: str) -> bool:
    return re.search(pattern, text) is not None
```

```py
contains_pattern("plaza", r"aza")  # True
contains_pattern("maze", r"aza")   # False
```

### Extract the first match

```py
import re

def first_match(text: str, pattern: str) -> str | None:
    match = re.search(pattern, text)
    return match.group() if match else None
```

```py
first_match("penguin", r"p.ng")  # "peng"
first_match("cat", r"p.ng")      # None
```

### Get match positions

```py
import re

def match_span(text: str, pattern: str) -> tuple[int, int] | None:
    match = re.search(pattern, text)
    return match.span() if match else None
```

```py
match_span("plaza", r"aza")  # (2, 5)
match_span("maze", r"aza")   # None
```

## LeetCode Style: Regex vs Strings

For fixed, simple checks, prefer normal string methods.

```py
line = "ERROR Disk full"

line.startswith("ERROR")   # Clearer than re.search(r"^ERROR", line)
"Disk" in line             # Clearer than re.search(r"Disk", line)
```

Use regex when the rule needs variable-format pattern matching.

```py
import re

def extract_pid(log: str) -> int | None:
    match = re.search(r"\[(\d+)\]", log)
    return int(match.group(1)) if match else None
```

This handles IDs of any length:

```py
extract_pid("process: running")       # 7
extract_pid("process: running")  # 123456
extract_pid("no process ID")              # None
```

## Complexity

For a simple search through text of length \(n\), `re.search()` is generally \(O(n)\). The exact cost depends on the pattern; poorly designed patterns can become much slower, so prefer straightforward patterns and avoid unnecessary regex when `in`, `.startswith()`, or `.endswith()` is sufficient.

## Practice

```py
import re

def starts_with_letter_x(text: str) -> bool:
    return re.search(r"^x", text, re.I) is not None

def contains_dot_pattern(text: str) -> str | None:
    match = re.search(r"c.t", text)
    return match.group() if match else None

assert starts_with_letter_x("xenon") is True
assert starts_with_letter_x("Xylophone") is True
assert starts_with_letter_x("oxygen") is False

assert contains_dot_pattern("The cat slept") == "cat"
assert contains_dot_pattern("The cot slept") == "cot"
assert contains_dot_pattern("The dog slept") is None
```

<!-- Improvement idea: Add `re.match()`, `re.fullmatch()`, `re.findall()`, and compiled patterns after their respective lessons. Include a decision table that shows when string methods are clearer than regex. -->
