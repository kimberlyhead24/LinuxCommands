# Basic Matching with `grep`

## Core Idea

`grep` searches text and prints the **entire line** for every line that matches a pattern.

It is useful for:

- Searching log files
- Filtering command output
- Finding text in source code
- Checking file contents quickly
- Experimenting with regular expressions from the terminal

## Basic Syntax

```bash
grep "PATTERN" FILE
```

Example:

```bash
grep "ERROR" system.log
```

This prints every line in `system.log` that contains the exact text `ERROR`.

```text
July 31 07:51:48 mycomputer bad_process: ERROR Performing package upgrade
August 01 09:20:11 mycomputer app: ERROR Connection failed
```

## Literal Matching

A normal string is already a basic regular-expression pattern.

```bash
grep "thon" /usr/share/dict/words
```

This finds every line containing `thon` anywhere in the line.

Possible matches include:

```text
athon
marathon
python
```

`grep` does not require a full-word match by default. It finds the pattern even when it appears inside a larger word.

## Case Sensitivity

By default, `grep` is case-sensitive.

```bash
grep "error" system.log
```

This does **not** match:

```text
ERROR Disk full
```

Use `-i` for a case-insensitive search:

```bash
grep -i "error" system.log
```

Now these all match:

```text
error: disk full
ERROR: disk full
Error: disk full
```

## Wildcard: `.`

In regex, a dot `.` matches **any single character**.

```bash
grep "l.RTS" /usr/share/dict/words
```

The dot can represent a different character in each result:

```text
alerts
blurts
flirts
```

Pattern breakdown:

| Pattern | Meaning |
|---|---|
| `l` | Match a literal lowercase `l` |
| `.` | Match exactly one character |
| `RTS` | Match the literal letters `RTS` |
| `l.RTS` | Match `l`, any one character, then `RTS` |

## Anchors: Beginning and End of a Line

`^` and `$` match locations, not visible characters.

| Pattern | Meaning |
|---|---|
| `^` | Start of a line |
| `$` | End of a line |

### Starts with: `^`

```bash
grep "^fruit" /usr/share/dict/words
```

This matches lines beginning with `fruit`:

```text
fruit
fruitcake
fruitful
```

It does **not** match:

```text
grapefruit
passionfruit
```

### Ends with: `$`

```bash
grep "cat$" /usr/share/dict/words
```

This matches lines ending with `cat`:

```text
cat
copycat
wildcat
```

It does **not** match:

```text
catalog
catfish
```

## Practical Log Examples

Given `system.log`:

```text
INFO Server started
WARNING Disk space low
ERROR Database connection failed
INFO Backup completed
```

Find all error lines:

```bash
grep "ERROR" system.log
```

Find errors regardless of capitalization:

```bash
grep -i "error" system.log
```

Find lines that begin with `ERROR`:

```bash
grep "^ERROR" system.log
```

Find lines that end with `completed`:

```bash
grep "completed$" system.log
```

## LeetCode / Production Thinking

Do not use regex when a direct string operation is clearer and sufficient.

```py
line = "ERROR Database connection failed"

if "ERROR" in line:
    print("Found an error")
```

For an exact substring check, `in` is simpler and usually preferable in Python.

Use regex when you need **pattern flexibility**:

```py
import re

line = "ERROR Database connection failed"

if re.search(r"^ERROR\b", line):
    print("The line starts with the ERROR severity")
```

Use `^ERROR\b` rather than `^ERROR` when you mean the standalone word `ERROR`; `\b` prevents matching words such as `ERRORCODE`.

## Common Mistakes

### Forgetting that `grep` prints whole lines

```bash
grep "ERROR" system.log
```

`grep` normally prints the entire matching line, not only the matching word.

Use `-o` to print only the matched portion:

```bash
grep -o "ERROR" system.log
```

### Forgetting that `.` is special

```bash
grep "v1.2" versions.txt
```

This treats `.` as “any one character,” so it could match `v1x2`.

Escape a literal dot:

```bash
grep "v1\.2" versions.txt
```

### Forgetting anchor behavior

```bash
grep "^ERROR" system.log
```

This matches only when `ERROR` is at the **start of the line**, not merely somewhere in the line.

## Useful Command Options

| Command | Purpose |
|---|---|
| `grep "text" file` | Find matching lines |
| `grep -i "text" file` | Ignore letter case |
| `grep -n "text" file` | Include line numbers |
| `grep -o "pattern" file` | Print only matching text |
| `grep -v "text" file` | Print lines that do not match |
| `grep -E "pattern" file` | Use extended regex syntax |
| `grep -r "text" directory/` | Search files recursively |

## Practice

Given:

```text
INFO Application started
ERROR Connection timed out
WARNING CPU usage high
ERROR Invalid API key
INFO Application stopped
```

Write commands to:

1. Print all lines containing `ERROR`
2. Print all lines beginning with `INFO`
3. Print all lines ending in `high`
4. Print all lines that do **not** contain `ERROR`
5. Print matching lines with their line numbers

Answers:

```bash
grep "ERROR" app.log
grep "^INFO" app.log
grep "high$" app.log
grep -v "ERROR" app.log
grep -n "ERROR" app.log
```

<!-- Improvement idea: Add exercises after each new regex operator. Include expected output, edge cases, and a Python equivalent using `re.search()` so terminal regex skills directly transfer into coding problems. -->
