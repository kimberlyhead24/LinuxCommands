# More File Information

## Core Idea

Python's `os.path` module can retrieve information about files, including:

- File size
- Last-modified time
- Absolute file path

These functions use information provided by the operating system, so the same Python code can work across Windows, macOS, and Linux.

## Import Modules

```py
import os
import datetime
```

- `os` provides file-system functions.
- `datetime` converts timestamps into a human-readable date and time.

## File Size: `os.path.getsize()`

### Course Example

```py
os.path.getsize("spider.txt")
```

### What It Does

Returns the size of `spider.txt` in **bytes**.

```py
file_size = os.path.getsize("spider.txt")

print(file_size)
```

Example output:

```text
342
```

This means the file is 342 bytes.

## Last Modified Time: `os.path.getmtime()`

### Course Example

```py
os.path.getmtime("spider.txt")
```

### What It Does

Returns the time when `spider.txt` was last modified as a Unix timestamp.

A Unix timestamp is the number of seconds since:

```text
January 1, 1970, 00:00:00 UTC
```

Example:

```py
timestamp = os.path.getmtime("spider.txt")

print(timestamp)
```

Example output:

```text
1724421627.923
```

The long number is useful to computers but difficult for people to read directly.

## Convert a Timestamp to a Readable Date

### Course Example

```py
import datetime

timestamp = os.path.getmtime("spider.txt")
datetime.datetime.fromtimestamp(timestamp)
```

### Clearer Version

```py
import os
import datetime

timestamp = os.path.getmtime("spider.txt")
modified_time = datetime.datetime.fromtimestamp(timestamp)

print(modified_time)
```

Example output:

```text
2026-08-23 20:18:45.923000
```

`datetime.datetime.fromtimestamp()` converts a Unix timestamp into a `datetime` object using the computer's local time zone.

## Absolute Path: `os.path.abspath()`

### Course Example

```py
os.path.abspath("spider.txt")
```

### What It Does

Takes a relative file path and returns the complete absolute path.

If the current working directory is:

```text
C:\Users\Kimberly\Documents\python-notes
```

then:

```py
os.path.abspath("spider.txt")
```

might return:

```text
C:\Users\Kimberly\Documents\python-notes\spider.txt
```

The exact result depends on the current working directory.

## Relative vs. Absolute Paths

| Path type | Example | Meaning |
|---|---|---|
| Relative path | `"spider.txt"` | Find the file from the current working directory |
| Relative path | `"data/spider.txt"` | Find the file inside `data` from the current directory |
| Absolute path | `"C:/Users/YourName/Documents/spider.txt"` | Gives the file's full location |
| Absolute path | `"/home/user/documents/spider.txt"` | Full Linux/macOS-style location |

## Complete Example

```py
import os
import datetime

filename = "spider.txt"

if os.path.exists(filename):
    file_size = os.path.getsize(filename)
    timestamp = os.path.getmtime(filename)
    modified_time = datetime.datetime.fromtimestamp(timestamp)
    absolute_path = os.path.abspath(filename)

    print(f"Path: {absolute_path}")
    print(f"Size: {file_size} bytes")
    print(f"Last modified: {modified_time}")
else:
    print(f"File not found: {filename}")
```

## Common Errors

| Problem | Likely cause | Fix |
|---|---|---|
| `FileNotFoundError` | File name or path is wrong | Use `os.path.exists()` first and check the current working directory |
| Timestamp is confusing | Unix timestamps are numeric seconds | Convert it with `datetime.datetime.fromtimestamp()` |
| Unexpected absolute path | Script runs from another working directory | Print `os.getcwd()` to verify the current directory |
| Permission error | Program cannot access the file | Check permissions or use a permitted folder |

## What to Remember

- `os.path.getsize(path)` returns file size in bytes.
- `os.path.getmtime(path)` returns last-modified time as a Unix timestamp.
- A Unix timestamp counts seconds from January 1, 1970.
- `datetime.datetime.fromtimestamp(timestamp)` makes a timestamp readable.
- `os.path.abspath(path)` converts a relative path into an absolute path.
- Use `os.path.exists(path)` before accessing a file when it may be missing.

<!-- Improvement idea: Add a pathlib version later using `Path.stat()`, `Path.resolve()`, and `datetime.fromtimestamp(path.stat().st_mtime)`. Also add a small practice script that displays the size and modification time of a user-supplied file. -->

## Course Source

- [Coursera: More File Information](https://www.coursera.org/learn/python-operating-system/lecture/lg6bg/more-file-information)
