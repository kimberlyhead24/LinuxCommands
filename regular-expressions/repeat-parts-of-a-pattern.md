# Repeat Parts of a Pattern

## Use this when

Use repetition qualifiers when a character or group can appear more than once.

Common use cases:

- Extract an ID with any number of digits
- Match a word or filename segment of unknown length
- Make part of a pattern optional
- Validate repeated characters or structured text

## Quick Reference

| Pattern | Meaning | Minimum occurrences | Example |
|---|---|---:|---|
| `*` | Zero or more | 0 | `\d*` |
| `+` | One or more | 1 | `\d+` |
| `?` | Zero or one | 0 | `colou?r` |

A qualifier applies to the pattern immediately before it.

```py
a+       # Repeat `a`
\d+      # Repeat a digit
[abc]+   # Repeat one of a, b, or c
(ab)+    # Repeat the whole group `ab`
```

## `*`: Zero or More

```py
import re

print(re.search(r"Py.*n", "Pygmalion"))
print(re.search(r"Py.*n", "Python Programming"))
```

`.*` means:

```text
.  = any one character
*  = zero or more occurrences
.* = any number of any characters, including zero
```

The first match is:

```text
Pygmalion
```

The second match is:

```text
Python Programmin
```

## Why `.*` Can Be Dangerous

The star qualifier is greedy by default: it takes as many characters as it can while still allowing the full pattern to match.

```py
import re

text = "Python Programming"

match = re.search(r"Py.*n", text)
print(match.group())
```

Output:

```text
Python Programmin
```

It could have stopped after `Python`, but it continues to the final `n` because greedy matching prefers the longest valid match. [page:58]

### Better: Restrict What May Repeat

If only lowercase letters are valid between `Py` and `n`, use a character class instead of `.`:

```py
import re

print(re.search(r"Py[a-z]*n", "Python Programming"))
print(re.search(r"Py[a-z]*n", "Pyn"))
```

Output:

```text
Python
Pyn
```

Pattern meaning:

```text
Py        Literal letters P and y
[a-z]     One lowercase letter
*         Zero or more lowercase letters
n         Literal letter n
```

Because `*` permits zero occurrences, `Pyn` matches.

## `+`: One or More

Use `+` when at least one occurrence is required.

```py
import re

print(re.search(r"o+l+", "goldfish"))
print(re.search(r"o+l+", "woolly"))
print(re.search(r"o+l+", "boil"))
```

Expected matches:

```text
ol
ooll
None
```

`o+l+` means:

```text
o+  One or more consecutive `o` characters
l+  Followed immediately by one or more consecutive `l` characters
```

`boil` does not match because `o` and `l` are separated by `i`.

## `?`: Optional

Use `?` when the preceding item may appear zero or one time.

```py
import re

print(re.search(r"p?each", "To each their own"))
print(re.search(r"p?each", "I like peaches"))
```

Expected matches:

```text
each
peach
```

Pattern meaning:

```text
p?     An optional lowercase `p`
each   Literal text `each`
```

This lets the same pattern match both `each` and `peach`.

## Best Practice: Choose the Tightest Pattern

Avoid broad patterns when you know what the valid data looks like.

Too broad:

```py
re.search(r"\[.*\]", log)
```

This can capture from the first `[` to the last `]` in a line.

Better for a numeric process ID:

```py
re.search(r"\[(\d+)\]", log)
```

Best when you need the actual ID value:

```py
import re

def extract_process_id(log: str) -> int | None:
    match = re.search(r"\[(\d+)\]", log)
    return int(match.group(1)) if match else None
```

## Greedy Matching

By default, `*` and `+` are greedy.

```py
import re

text = "<b>first</b> and <b>second</b>"

print(re.search(r"<b>.*</b>", text).group())
```

Output:

```text
<b>first</b> and <b>second</b>
```

The regex spans from the first opening tag to the last closing tag.

### Lazy Matching

Add `?` after `*` or `+` to make it lazy: match as little as possible.

```py
import re

text = "<b>first</b> and <b>second</b>"

print(re.search(r"<b>.*?</b>", text).group())
```

Output:

```text
<b>first</b>
```

Use lazy quantifiers carefully. In real HTML, use an HTML parser rather than regex.

| Greedy | Lazy | Meaning |
|---|---|---|
| `*` | `*?` | Zero or more, as many / as few as possible |
| `+` | `+?` | One or more, as many / as few as possible |
| `?` | `??` | Zero or one, prefer zero if possible |

## Python vs `grep`

Regex features can differ by implementation.

- Basic `grep` commonly uses `*` but needs extended mode or other syntax for some additional repetition operators.
- Python's `re` module supports `*`, `+`, and `?`.
- `grep -E` uses extended regular expressions and supports `+` and `?`.

For portable terminal searches that use `+` or `?`, prefer:

```bash
grep -E "o+l+" words.txt
```

The course notes that Python and `egrep`/`grep -E` support the extra `+` and `?` qualifiers, while basic `grep` differs in supported regex features. [page:58]

## LeetCode / Interview Habit

Use regex only when matching a variable text format is genuinely the problem.

For a basic repeated-character check, a loop is usually clearer:

```py
def has_consecutive_zeros(bits: str) -> bool:
    return "00" in bits
```

For a format rule, regex is concise:

```py
import re

def is_simple_identifier(value: str) -> bool:
    return re.fullmatch(r"[A-Za-z_][A-Za-z0-9_]*", value) is not None
```

This requires:

- One starting letter or underscore
- Zero or more letters, digits, or underscores after it
- The whole string to satisfy the pattern

## Practice

```py
import re

def has_one_or_more_digits(text: str) -> bool:
    return re.search(r"\d+", text) is not None

def extract_first_word_starting_with_a(text: str) -> str | None:
    match = re.search(r"\ba[a-z]*", text, re.IGNORECASE)
    return match.group() if match else None

def is_optional_http(url: str) -> bool:
    return re.fullmatch(r"https?://.+", url) is not None

assert has_one_or_more_digits("Room 204") is True
assert has_one_or_more_digits("No number") is False

assert extract_first_word_starting_with_a("An apple arrived") == "An"
assert extract_first_word_starting_with_a("No matching word") is None

assert is_optional_http("http://example.com") is True
assert is_optional_http("https://example.com") is True
assert is_optional_http("ftp://example.com") is False
```

<!-- Improvement idea: Later add `{m,n}` quantifiers, lazy matching, word boundaries, and `re.fullmatch()` examples to create a complete validation-pattern reference. -->
