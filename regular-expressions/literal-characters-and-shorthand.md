# Literal Characters and Regex Shorthand

## Use this when

Use a backslash in regex for either of these reasons:

1. Match a regex special character literally, such as a period or square bracket
2. Use a predefined character set, such as digits or whitespace

```py
import re
```

## Escape Special Characters

Regex characters such as `.`, `*`, `+`, `?`, `^`, `$`, `(`, `)`, `[`, `]`, `{`, `}`, `|`, and `\` have special meanings.

Add `\` before one when you want to match the actual character.

| Want to match | Regex pattern |
|---|---|
| Literal period `.` | `r"\."` |
| Literal plus `+` | `r"\+"` |
| Literal question mark `?` | `r"\?"` |
| Literal opening bracket `[` | `r"\["` |
| Literal closing bracket `]` | `r"\]"` |
| Literal parentheses `()` | `r"\("` and `r"\)"` |
| Literal dollar sign `$` | `r"\$"` |
| Literal backslash `\` | `r"\\"` |

## Example: Literal Period

```py
import re

print(re.search(r".com", "welcome"))
print(re.search(r"\.com", "welcome"))
print(re.search(r"\.com", "mydomain.com"))
```

Expected behavior:

```text
<Match: ecom>
None
<Match: .com>
```

### Why

```py
r".com"
```

means:

```text
Any one character, followed by "com"
```

So it finds `ecom` in `welcome`.

```py
r"\.com"
```

means:

```text
A literal period, followed by "com"
```

So it correctly matches `.com` only in `mydomain.com`. The video uses this example to show why special regex characters must be escaped when you want their literal meaning. [page:60]

## Use Raw Strings

Prefer raw strings for regex patterns:

```py
r"\d+"
r"\.com"
r"\bword\b"
```

A normal Python string processes escape sequences before regex sees them.

```py
"\n"   # A real newline character
"\t"   # A real tab character
```

A raw string leaves the backslash intact:

```py
r"\n"  # Backslash + n, available for regex to interpret
r"\t"  # Backslash + t, available for regex to interpret
```

### Rule

Use `r"..."` for almost every regex pattern.

```py
re.search(r"\d+", text)
```

This makes regex code easier to read and prevents accidental double-escaping.

## Regex Shorthand Classes

Python regex provides short patterns for common character sets.

| Pattern | Matches | Equivalent idea |
|---|---|---|
| `\d` | A digit | `[0-9]` |
| `\D` | A non-digit | `[^0-9]` |
| `\w` | A word character: letter, digit, or underscore | Similar to `[A-Za-z0-9_]` |
| `\W` | A non-word character | Anything except `\w` |
| `\s` | Whitespace: space, tab, newline, and more | Whitespace characters |
| `\S` | A non-whitespace character | Anything except whitespace |
| `\b` | A word boundary | Position at word edge |
| `\B` | Not a word boundary | Position not at word edge |

The video specifically introduces `\w`, `\d`, `\s`, and `\b` as predefined regex sequences. [page:60]

## `\w`: Word Characters

```py
import re

print(re.search(r"\w*", "This is an example"))
print(re.search(r"\w*", "And_this_is_another"))
```

Expected matches:

```text
This
And_this_is_another
```

`\w` matches:

- Letters
- Digits
- Underscores

It does not match spaces or punctuation.

```py
re.search(r"\w+", "user_name-42").group()
# "user_name"
```

## Prefer `+` for Required Text

Be careful with `*`.

```py
re.search(r"\w*", "!!!")
```

This succeeds with an empty match because `*` means zero or more.

If you require at least one word character, use `+`:

```py
re.search(r"\w+", "!!!")  # None
```

| Pattern | Meaning | Can match an empty string? |
|---|---|---|
| `\w*` | Zero or more word characters | Yes |
| `\w+` | One or more word characters | No |

## Practical Patterns

### Extract a number

```py
import re

text = "Order ID: 4821"
match = re.search(r"\d+", text)

order_id = int(match.group()) if match else None
print(order_id)
```

### Split around whitespace

```py
import re

text = "first\tsecond   third"
parts = re.split(r"\s+", text)

print(parts)
```

Output:

```py
["first", "second", "third"]
```

### Find standalone words

```py
import re

text = "A cat scattered catfish food."

print(re.findall(r"\bcat\b", text))
```

Output:

```py
["cat"]
```

`\bcat\b` matches `cat` as a complete word, but not `scattered` or `catfish`.

### Validate a simple filename extension

```py
import re

def is_text_file(filename: str) -> bool:
    return re.fullmatch(r".+\.txt", filename) is not None
```

```py
assert is_text_file("notes.txt") is True
assert is_text_file("notes.csv") is False
assert is_text_file("notesxtxt") is False
```

The dot is escaped because the goal is to match an actual period before `txt`.

## Best-Practice Rule

Use the narrowest pattern that expresses the requirement.

| Goal | Avoid | Prefer |
|---|---|---|
| A digit | `.` | `\d` |
| One or more digits | `.*` | `\d+` |
| Literal period | `.` | `\.` |
| A whole word | `"cat"` anywhere | `\bcat\b` |
| One or more spaces/tabs/newlines | `" "` | `\s+` |
| An identifier-like word | `.*` | `\w+` |

## Regex vs Normal Strings

Use normal string methods when the rule is simple and fixed:

```py
filename.endswith(".txt")
"." in filename
text.split()
```

Use regex when the input may vary or needs structure:

```py
re.fullmatch(r".+\.txt", filename)
re.split(r"\s+", text)
re.findall(r"\b[A-Z][a-z]+\b", text)
```

## Quick Debugging

Use [regex101](https://regex101.com/) to test a pattern and see an explanation of each part.

When debugging:

1. Start with the smallest sample string
2. Use `re.search()` to confirm one match
3. Print `match.group()` and `match.span()`
4. Make the pattern stricter, not broader
5. Add tests for valid and invalid inputs

```py
import re

pattern = r"\[(\d+)\]"
text = "worker: running"

match = re.search(pattern, text)

if match:
    print(match.group())   # 
    print(match.group(1))  # 12345
    print(match.span())    # (6, 13)
```

<!-- Improvement idea: Add a one-page regex cheat sheet after this module finishes. Group syntax by matching, repetition, boundaries, captures, and Python `re` functions, with one safe production-style example for each. -->
