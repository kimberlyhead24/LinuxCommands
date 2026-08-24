# Validate a Complete String

## Use this when

Use complete-string validation when the **entire input** must follow a format.

Examples:

- Variable or identifier names
- Dates
- User IDs
- Filenames
- Product codes
- Simple input validation

Do not use a loose search when one valid substring is not enough.

```py
import re
```

## Search vs Validation

`re.search()` asks:

> Does this pattern appear anywhere in the string?

`re.fullmatch()` asks:

> Does the entire string match this pattern?

```py
import re

text = "Azerbaijan"

print(re.search(r"A.*a", text))
```

This finds a match because `Azerbaija` starts with `A` and ends with a lowercase `a`.

But the full string does not end in `a`, so it should fail if the requirement is “starts and ends with `A`/`a`.”

```py
import re

print(re.fullmatch(r"A.*a", text))
```

Output:

```text
None
```

## Anchors: `^` and `$`

Anchors explicitly require a match to cover the start and end of the string.

```py
import re

pattern = r"^A.*a$"

print(re.search(pattern, "Australia"))
print(re.search(pattern, "Azerbaijan"))
```

Expected behavior:

```text
Match
None
```

| Piece | Meaning |
|---|---|
| `^` | Start of the string |
| `A` | Literal uppercase `A` |
| `.*` | Zero or more characters |
| `a` | Literal lowercase `a` |
| `$` | End of the string |

The course uses this example to show why `A.*a` alone is insufficient: it can match part of `Azerbaijan`, whereas `^A.*a$` requires the whole input to begin and end with the expected letters. [page:62]

## Preferred Python Style

For whole-string validation, prefer `re.fullmatch()` over adding `^` and `$`.

```py
import re

def starts_with_a_ends_with_a(country: str) -> bool:
    return re.fullmatch(r"A.*a", country) is not None
```

```py
assert starts_with_a_ends_with_a("Australia") is True
assert starts_with_a_ends_with_a("Argentina") is True
assert starts_with_a_ends_with_a("Azerbaijan") is False
```

This is easier to read than:

```py
re.search(r"^A.*a$", country)
```

## Example: Identifier Validation

A simple identifier-style name can:

- Start with a letter or underscore
- Continue with letters, digits, or underscores
- Not contain spaces, punctuation, or hyphens
- Not start with a digit

### Regex Pattern

```py
r"[a-zA-Z_][a-zA-Z0-9_]*"
```

Pattern breakdown:

| Piece | Meaning |
|---|---|
| `[a-zA-Z_]` | First character must be a letter or underscore |
| `[a-zA-Z0-9_]*` | Remaining characters can be letters, digits, or underscores |
| `*` | Zero or more remaining valid characters |

### Best Implementation

```py
import re

def is_identifier_like(value: str) -> bool:
    return re.fullmatch(r"[a-zA-Z_][a-zA-Z0-9_]*", value) is not None
```

```py
assert is_identifier_like("_this_is_a_valid_variable_name") is True
assert is_identifier_like("my_variable1") is True

assert is_identifier_like("this isn't a valid variable") is False
assert is_identifier_like("2my_variable1") is False
assert is_identifier_like("my-variable") is False
assert is_identifier_like("") is False
```

The course pattern is written with anchors as `^[a-zA-Z_][a-zA-Z0-9_]*$`; using that pattern with `re.search()` validates the full string, while the unanchored version with `re.search()` does not. [page:62]

## Python Identifier Check

If the actual question is:

> Is this a valid Python identifier?

Do not write regex at all. Use Python’s built-in method:

```py
def is_valid_python_identifier(value: str) -> bool:
    return value.isidentifier()
```

```py
assert "my_variable1".isidentifier() is True
assert "_private".isidentifier() is True
assert "2fast".isidentifier() is False
assert "my-variable".isidentifier() is False
assert "has space".isidentifier() is False
```

To also reject Python keywords:

```py
import keyword

def is_valid_python_variable_name(value: str) -> bool:
    return value.isidentifier() and not keyword.iskeyword(value)
```

```py
assert is_valid_python_variable_name("total") is True
assert is_valid_python_variable_name("class") is False
```

## Best Tool for the Job

| Goal | Best choice |
|---|---|
| Find a pattern somewhere in text | `re.search()` |
| Extract every occurrence | `re.findall()` or `re.finditer()` |
| Verify the string begins with text | `.startswith()` |
| Verify the string ends with text | `.endswith()` |
| Validate a whole custom format | `re.fullmatch()` |
| Check a Python identifier | `.isidentifier()` |
| Check a Python variable name | `.isidentifier()` plus `keyword.iskeyword()` |

## Avoid Broad Patterns

This is too broad for most validation:

```py
re.fullmatch(r".*", value)
```

This is better when only letters, digits, and underscores are valid:

```py
re.fullmatch(r"[A-Za-z_][A-Za-z0-9_]*", value)
```

A narrow pattern makes invalid input fail early and clearly.

## Complexity

For a straightforward pattern scanned over text of length \(n\), validation is generally \(O(n)\) time and \(O(1)\) extra space, excluding the regex engine’s internal work.

Avoid unbounded ambiguous patterns such as nested repetition:

```py
r"(a+)+$"
```

These can be slow on carefully crafted invalid input. Prefer specific character classes and simple repetition.

## Practice

```py
import keyword
import re

def is_valid_python_variable_name(value: str) -> bool:
    return value.isidentifier() and not keyword.iskeyword(value)

def is_hex_color(value: str) -> bool:
    return re.fullmatch(r"#[0-9A-Fa-f]{6}", value) is not None

assert is_valid_python_variable_name("user_id") is True
assert is_valid_python_variable_name("_total2") is True
assert is_valid_python_variable_name("2_total") is False
assert is_valid_python_variable_name("class") is False

assert is_hex_color("#1A2B3C") is True
assert is_hex_color("#fff") is False
assert is_hex_color("1A2B3C") is False
```

<!-- Improvement idea: Add a dedicated validation-patterns cheat sheet after learning `{m,n}`, optional groups, and named captures. Keep every validator paired with valid and invalid test cases. -->
