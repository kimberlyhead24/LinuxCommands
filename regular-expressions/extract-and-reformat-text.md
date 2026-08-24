# Extract and Reformat Text

## Use this when

Use capturing groups when you need to:

- Extract structured pieces from a string
- Reorder parts of text
- Pull an ID, date, hostname, or filename from a larger line
- Validate a format and use the values inside it
- Convert one text format into another

A capturing group is a regex portion wrapped in parentheses:

```py
(...)
```

## Core Pattern

```py
import re

match = re.search(r"^(\w+), (\w+)$", "Lovelace, Ada")
```

This pattern has two capturing groups:

```text
^        Start of string
(\w+)    Capture the last name
,        Match a literal comma
         Match one literal space
(\w+)    Capture the first name
$        End of string
```

## Read Captured Values

```py
import re

match = re.search(r"^(\w+), (\w+)$", "Lovelace, Ada")

if match:
    print(match.group(0))  # Lovelace, Ada
    print(match.group(1))  # Lovelace
    print(match.group(2))  # Ada
    print(match.groups())  # ('Lovelace', 'Ada')
```

| Expression | What it returns |
|---|---|
| `match.group(0)` | Entire matched text |
| `match.group()` | Entire matched text, same as group `0` |
| `match.group(1)` | First capturing group |
| `match.group(2)` | Second capturing group |
| `match.groups()` | Tuple of all captured groups |
| `match[0]` | Entire matched text |
| `match[1]` | First captured group |

## Prefer `.group(n)` for Clarity

Both options work:

```py
match
match.group(1)
```

Prefer:

```py
match.group(1)
```

It makes it clearer that you are retrieving a regex capture group instead of indexing a normal sequence.

## Reformat: `Last, First` to `First Last`

```py
import re

def rearrange_name(name: str) -> str:
    match = re.fullmatch(r"(\w+), (\w+)", name)

    if not match:
        return name

    last_name = match.group(1)
    first_name = match.group(2)

    return f"{first_name} {last_name}"
```

```py
assert rearrange_name("Lovelace, Ada") == "Ada Lovelace"
assert rearrange_name("Ritchie, Dennis") == "Dennis Ritchie"
assert rearrange_name("Ada Lovelace") == "Ada Lovelace"
```

## Why `fullmatch()` Is Better Here

The course uses:

```py
re.search(r"^(\w*), (\w*)$", name)
```

A clearer production-style version is:

```py
re.fullmatch(r"(\w+), (\w+)", name)
```

Why:

- `re.fullmatch()` directly communicates that the entire input must fit the format
- `+` requires at least one character; `*` permits an empty last or first name
- The pattern is easier to read without `^` and `$`

## Support More Realistic Names

`\w` is limited: it includes letters, digits, and underscores, but it does not include spaces, hyphens, or periods. The video expands the allowed characters so names with middle initials and hyphens can match. [page:65]

```py
import re

NAME_PATTERN = re.compile(
    r"(?P<last>[A-Za-z][A-Za-z .'-]*)\s*,\s*"
    r"(?P<first>[A-Za-z][A-Za-z .'-]*)"
)

def rearrange_name(name: str) -> str:
    match = NAME_PATTERN.fullmatch(name.strip())

    if not match:
        return name

    return f"{match.group('first')} {match.group('last')}"
```

```py
assert rearrange_name("Lovelace, Ada") == "Ada Lovelace"
assert rearrange_name("Hopper, Grace M.") == "Grace M. Hopper"
assert rearrange_name("Smith-Jones, Anna") == "Anna Smith-Jones"
assert rearrange_name("O'Connor, Maeve") == "Maeve O'Connor"
assert rearrange_name("Ada Lovelace") == "Ada Lovelace"
```

## Named Groups: Best for Readability

Numbered groups become difficult to maintain as patterns grow.

Avoid:

```py
return f"{match.group(2)} {match.group(1)}"
```

Prefer named groups:

```py
pattern = r"(?P<last>\w+), (?P<first>\w+)"
match = re.fullmatch(pattern, "Lovelace, Ada")

if match:
    print(match.group("first"))  # Ada
    print(match.group("last"))   # Lovelace
```

Named-group syntax:

```text
(?P<name>pattern)
```

This is especially useful for dates, log lines, URLs, and formats with three or more captured values.

## Practical Example: Extract Log Data

```py
import re

LOG_PATTERN = re.compile(
    r"(?P<process>[\w-]+)"
    r"\[(?P<pid>\d+)\]: "
    r"(?P<level>[A-Z]+) "
    r"(?P<message>.+)"
)

def parse_log_line(line: str) -> dict[str, str] | None:
    match = LOG_PATTERN.search(line)

    if not match:
        return None

    return match.groupdict()
```

```py
line = "July 31 07:51:48 mycomputer bad-process: ERROR Package upgrade failed"

print(parse_log_line(line))
```

Expected result:

```py
{
    "process": "bad-process",
    "pid": "12345",
    "level": "ERROR",
    "message": "Package upgrade failed",
}
```

## Choose the Right Match Function

| Goal | Use |
|---|---|
| Find the first matching structure anywhere | `re.search()` |
| Validate the complete input and extract parts | `re.fullmatch()` |
| Extract all matching occurrences | `re.findall()` or `re.finditer()` |
| Need named fields from one match | `match.groupdict()` |

## Reliable Pattern-Building Habits

1. Start with the smallest valid format.
2. Capture only values you actually need later.
3. Use `+` for required text, not `*`.
4. Use `re.fullmatch()` for validation/reformatting tasks.
5. Check `if not match:` before accessing groups.
6. Use named groups once a pattern has more than two or three important parts.
7. Expand allowed characters only when the real input requires them.
8. Add valid and invalid test cases before trusting a pattern.

## Common Mistakes

### Assuming `\w` means “a person’s name”

```py
r"(\w+), (\w+)"
```

`\w` also allows digits and underscores, but excludes spaces, periods, apostrophes, and hyphens. It is good for identifiers, not automatically good for human names.

### Using `*` for required name parts

```py
r"(\w*), (\w*)"
```

This permits invalid forms such as:

```text
, Ada
Lovelace,
,
```

Use `+` when both fields are required:

```py
r"(\w+), (\w+)"
```

### Reading groups before confirming a match

```py
match = re.fullmatch(pattern, value)
print(match.group(1))  # Fails if match is None
```

Use:

```py
if match:
    print(match.group(1))
```

## Complexity

For straightforward patterns that scan an input of length \(n\), capture-based matching is generally \(O(n)\) time. Use specific character classes instead of overlapping broad patterns to avoid avoidable backtracking.

<!-- Improvement idea: Add a follow-up note for `re.sub()` using backreferences, such as converting every valid `Last, First` name in a list or document. -->
