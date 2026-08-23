# Iterating Through Files

## Core Idea

A file object can be iterated over like a list or string.

Iterating through a file processes one line at a time, which is useful when working with large files because the entire file does not need to be stored in memory at once.

## Course Example: Process Each Line

```py
with open("spider.txt") as file:
    for line in file:
        print(line.upper())
```

## What the Code Does

```py
with open("spider.txt") as file:
```

- Opens `spider.txt`.
- Stores the file object in `file`.
- Automatically closes the file after the indented block finishes.

```py
for line in file:
```

- Loops through the file one line at a time.
- Stores the current line as a string in the `line` variable.
- The line string usually includes a newline character (`\n`) at its end.

```py
print(line.upper())
```

- Converts the current line to uppercase.
- Prints it.

## Why Empty Lines Appear

This code can create blank lines between output lines:

```py
with open("spider.txt") as file:
    for line in file:
        print(line.upper())
```

Each line from the file already ends with a newline character:

```text
Itsy bitsy spider\n
```

Then `print()` adds another newline character.

```text
newline from file + newline from print = blank line
```

## Remove Extra Whitespace with `.strip()`

Use `.strip()` to remove whitespace from the beginning and end of a string, including spaces, tabs, and newline characters.

```py
with open("spider.txt") as file:
    for line in file:
        print(line.strip().upper())
```

This outputs each line in uppercase without blank lines between them.

## Useful String Methods

| Method | Purpose | Example |
|---|---|---|
| `.strip()` | Removes whitespace from both ends of a string | `line.strip()` |
| `.upper()` | Converts letters to uppercase | `line.upper()` |
| `.lower()` | Converts letters to lowercase | `line.lower()` |
| `.startswith()` | Checks whether text begins with a value | `line.startswith("Error")` |
| `.split()` | Splits a string into a list | `line.split(",")` |

## Read All Lines into a List

Use `.readlines()` to read every line from a file into a list.

```py
file = open("spider.txt")
lines = file.readlines()
file.close()
```

After this runs, `lines` contains a list of strings:

```py
[
    "Itsy bitsy spider\n",
    "Climbed up the water spout\n",
    "Down came the rain\n"
]
```

The file is closed, but the list remains available in memory.

## Sort Lines

```py
lines.sort()

print(lines)
```

`.sort()` sorts the list alphabetically.

When Python displays the list, newline characters appear as `\n`:

```py
["Climbed up the water spout\n", "Down came the rain\n"]
```

`\n` is an escape sequence representing a newline character.

## Common Escape Sequences

| Escape sequence | Meaning |
|---|---|
| `\n` | New line |
| `\t` | Tab |
| `\\` | Backslash |
| `\"` | Double quote inside a double-quoted string |
| `\'` | Single quote inside a single-quoted string |

## Line-by-Line vs. Whole-File Reading

| Approach | Example | Best use | Memory use |
|---|---|---|---|
| Iterate line by line | `for line in file:` | Large files, logs, streaming processing | Low |
| Read one line | `file.readline()` | When the next individual line is needed | Low |
| Read all content | `file.read()` | Small files needing full contents as one string | High for large files |
| Read all lines | `file.readlines()` | Small files needing a list of lines | High for large files |

## Large File Example

For a large log file, process one line at a time:

```py
with open("system.log") as file:
    for line in file:
        if "ERROR" in line:
            print(line.strip())
```

This checks each line without loading the entire log file into memory.

## What to Remember

- A file object can be used directly in a `for` loop.
- `for line in file:` reads and processes one line at a time.
- Lines normally include a trailing `\n`.
- Use `.strip()` before `print()` to avoid extra blank lines.
- `.readlines()` returns a list containing every line in the file.
- Use line-by-line iteration for large files to reduce memory use.
- `\n` and `\t` are escape sequences for non-printable characters.

<!-- Improvement idea: Add a later example using `enumerate(file, start=1)` to print line numbers and an example that filters/exports matching log entries to another file. -->

## Course Source

- [Coursera: Iterating through Files](https://www.coursera.org/learn/python-operating-system/lecture/BpXbw/iterating-through-files)
