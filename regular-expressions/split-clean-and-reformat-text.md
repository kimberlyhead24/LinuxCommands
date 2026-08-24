# Split, Clean, and Reformat Text

## Use this when

Use regex transformations when you need to:

- Split text using multiple possible delimiters
- Keep or discard delimiters intentionally
- Redact sensitive-looking information from logs
- Normalize inconsistent text
- Rearrange structured text using capture groups

```py
import re
```

## `re.split()`: Split on a Pattern

Normal string splitting accepts one exact separator:

```py
"one,two,three".split(",")
```

Use `re.split()` when the separator can be one of several patterns.

```py
import re

text = "One sentence. Another one? And the last one!"

sentences = re.split(r"[.?!]", text)
print(sentences)
```

Output:

```py
["One sentence", " Another one", " And the last one", ""]
```

`[.?!]` means “match one literal period, question mark, or exclamation mark.”

### Character Classes Treat These as Literal

Inside a character class, these do not need escaping:

```py
[.?!]
```

The period means a literal `.` here—not the wildcard “any character.” The video highlights this distinction. [page:71]

## Remove Empty Results

A final punctuation mark creates an empty item after the split.

```py
import re

text = "One sentence. Another one? And the last one!"

sentences = [
    part.strip()
    for part in re.split(r"[.?!]", text)
    if part.strip()
]

print(sentences)
```

Output:

```py
["One sentence", "Another one", "And the last one"]
```

## Keep the Delimiters

Wrap the splitting pattern in a capture group to include delimiters in the returned list.

```py
import re

text = "One sentence. Another one? And the last one!"

parts = re.split(r"([.?!])", text)
print(parts)
```

Output:

```py
["One sentence", ".", " Another one", "?", " And the last one", "!", ""]
```

This is useful when punctuation is data you need to preserve, such as when tokenizing text or reconstructing it later.

## `re.sub()`: Replace Pattern Matches

```py
re.sub(pattern, replacement, text)
```

`re.sub()` returns a **new string**. It does not modify the original string.

Use it when `str.replace()` is too limited because the thing you want to replace has a variable format.

## Redact Email-Like Text

```py
import re

text = "Received an email for go_nuts95@my.example.com"

redacted = re.sub(
    r"[\w.%+-]+@[\w.-]+",
    "[REDACTED]",
    text,
)

print(redacted)
```

Output:

```text
Received an email for [REDACTED]
```

Pattern breakdown:

| Piece | Meaning |
|---|---|
| `[\w.%+-]+` | One or more allowed local-part characters before `@` |
| `@` | Literal at sign |
| `[\w.-]+` | One or more allowed domain characters after `@` |

This is a **redaction pattern**, not a complete email validator. It can match some invalid email-shaped strings, including domains with consecutive dots; that is acceptable when the goal is to remove anything that might be private rather than to prove an address is valid. [page:71]

## Redact Before Sharing Logs

```py
import re

EMAIL_LIKE_PATTERN = re.compile(r"[\w.%+-]+@[\w.-]+")

def redact_email_like_text(text: str) -> str:
    return EMAIL_LIKE_PATTERN.sub("[REDACTED]", text)
```

```py
log = "User kim@example.com failed login; notify admin@company.org"
safe_log = redact_email_like_text(log)

print(safe_log)
# User [REDACTED] failed login; notify [REDACTED]
```

Compile the pattern once when you will reuse it across many lines.

## Reformat with Capture Groups

`re.sub()` can insert captured text into the replacement with backreferences.

```py
import re

name = "Lovelace, Ada"

reformatted = re.sub(
    r"^([\w .'-]+),\s*([\w .'-]+)$",
    r"\2 \1",
    name,
)

print(reformatted)
```

Output:

```text
Ada Lovelace
```

### Replacement Backreferences

| Replacement part | Meaning |
|---|---|
| `\1` | Insert capture group 1 |
| `\2` | Insert capture group 2 |
| `r"\2 \1"` | Second group, space, first group |

The course uses `\2 \1` to transform `Last, First` into `First Last`; this backreference notation is shared by many regex tools, not only Python. [page:71]

## Cleaner Name Reformatter

Use a function if this transformation is reusable:

```py
import re

LAST_FIRST_PATTERN = re.compile(
    r"(?P<last>[A-Za-z][A-Za-z .'-]*)\s*,\s*"
    r"(?P<first>[A-Za-z][A-Za-z .'-]*)"
)

def rearrange_name(name: str) -> str:
    match = LAST_FIRST_PATTERN.fullmatch(name.strip())

    if not match:
        return name

    return f"{match.group('first')} {match.group('last')}"
```

```py
assert rearrange_name("Lovelace, Ada") == "Ada Lovelace"
assert rearrange_name("Hopper, Grace M.") == "Grace M. Hopper"
assert rearrange_name("Smith-Jones, Anna") == "Anna Smith-Jones"
assert rearrange_name("Ada Lovelace") == "Ada Lovelace"
```

Use `re.sub()` for a direct text transformation; use a helper function with named groups when you need clear logic, validation, or special handling of malformed input.

## Built-In Methods vs Regex

| Goal | Prefer |
|---|---|
| Split only on one known delimiter | `str.split()` |
| Replace one exact known string | `str.replace()` |
| Split on multiple separators or variable whitespace | `re.split()` |
| Replace structured, variable-format text | `re.sub()` |
| Redact many matching private values | Compiled regex with `.sub()` |

## LeetCode / Production Rule

Do not reach for regex automatically.

```py
text.split(",")                  # Better for one known separator
text.replace("old", "new")       # Better for one exact literal replacement
re.split(r"[,;|]\s*", text)      # Better for several delimiters
re.sub(r"\s+", " ", text).strip()  # Better for normalize-any-whitespace
```

## Tests

```py
def test_redact_email_like_text():
    assert redact_email_like_text("Email: a@b.com") == "Email: [REDACTED]"
    assert redact_email_like_text("No email here") == "No email here"
    assert (
        redact_email_like_text("a@b.com and c@d.org")
        == "[REDACTED] and [REDACTED]"
    )

def test_rearrange_name():
    assert rearrange_name("Lovelace, Ada") == "Ada Lovelace"
    assert rearrange_name("No comma") == "No comma"
```

<!-- Improvement idea: Add `re.subn()` later; it returns both the updated string and the number of replacements, which is useful in log-cleaning scripts and data-cleanup jobs. -->
