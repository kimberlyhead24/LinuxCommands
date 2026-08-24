# Regular Expressions

## Core Idea

A **regular expression**, often called a **regex**, is a pattern used to search, match, extract, validate, or replace text.

Regular expressions are useful when normal string methods are not flexible enough.

## Common Uses

- Find email addresses in text
- Validate input formats
- Search log files for errors
- Extract phone numbers, dates, IDs, or URLs
- Replace repeated or inconsistent text
- Filter lines that match a pattern

## Examples

| Goal | Example text | Regex pattern |
|---|---|---|
| Find a word | `The server is down` | `server` |
| Find digits | `Order 4821` | `\d+` |
| Find a four-digit year | `Created in 2026` | `\d{4}` |
| Find an email-like pattern | `kim@example.com` | `\S+@\S+` |
| Find lines beginning with `ERROR` | `ERROR: Disk full` | `^ERROR` |

## Python Quick Start

Python uses the built-in `re` module:

```py
import re
```

Search for a match:

```py
import re

text = "Order number: 4821"

result = re.search(r"\d+", text)

if result:
    print(result.group())
```

Output:

```text
4821
```

## Why the `r` Prefix Matters

Use a raw string for regex patterns:

```py
r"\d+"
```

The `r` tells Python not to interpret backslashes as normal string escape characters before the regular-expression engine reads them.

For example:

```py
"\n"
```

is a newline character, while:

```py
r"\n"
```

contains a backslash followed by `n`.

## Main Regex Building Blocks

| Pattern | Meaning | Example match |
|---|---|---|
| `.` | Any one character except newline | `c.t` matches `cat` |
| `\d` | One digit | `7` |
| `\w` | One word character: letter, digit, or `_` | `A`, `7`, `_` |
| `\s` | One whitespace character | A space or tab |
| `+` | One or more of the previous pattern | `\d+` matches `4821` |
| `*` | Zero or more of the previous pattern | `ab*` matches `a`, `ab`, `abb` |
| `?` | Zero or one of the previous pattern | `colou?r` matches `color` and `colour` |
| `^` | Start of a string or line | `^ERROR` |
| `$` | End of a string or line | `\.txt$` |
| `[]` | One character from a set or range | `[A-Z]` |
| `()` | Group a pattern | `(cat|dog)` |
| `\` | Escape a special regex character | `\.` matches a literal period |

## What to Remember

- Regex is a text-pattern language.
- Use Python's built-in `re` module.
- Write regex patterns as raw strings, such as `r"\d+"`.
- Regex can search, extract, validate, and replace text.
- Start with small patterns and test them with sample text.

<!-- Improvement idea: Add one note per lesson for wildcards, character classes, repetition qualifiers, anchors, groups, `re.search()`, `re.findall()`, `re.sub()`, and practical log-file examples. Add a safe regex-testing link or local test script after learning the core syntax. -->
