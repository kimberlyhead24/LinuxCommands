# Working With Files Using `os`

## Core Idea

Python's `os` module provides functions for interacting with the operating system.

It can be used to delete, rename, move, inspect, and manage files through Python code. Because `os` provides an abstraction layer, many commands work across Windows, macOS, and Linux.

> Paths can still differ by operating system, especially absolute paths. Prefer relative paths or `pathlib` when writing portable code.

## Import the Module

```py
import os
```

Import `os` before using functions such as `os.remove()` and `os.rename()`.

## Delete a File: `os.remove()`

### Course Example

```py
import os

os.remove("novel.txt")
```

### What It Does

- Deletes the file named `novel.txt`.
- The file is permanently removed from its location.
- If the file does not exist, Python raises `FileNotFoundError`.

```py
os.remove("novel.txt")
```

Running this line a second time fails if the first call already deleted the file.

## Rename a File: `os.rename()`

### Course Example

```py
os.rename("first_draft.txt", "finished_masterpiece.txt")
```

### Parameters

| Parameter | Meaning |
|---|---|
| First argument | Current filename or path |
| Second argument | New filename or path |

This renames:

```text
first_draft.txt
```

to:

```text
finished_masterpiece.txt
```

If the source file does not exist, Python raises `FileNotFoundError`.

> `os.rename()` can also move a file when the new name includes a different destination directory.

## Check Whether a File Exists: `os.path.exists()`

### Course Examples

```py
os.path.exists("finished_masterpiece.txt")
```

Returns:

```py
True
```

when the file or directory exists.

```py
os.path.exists("userlist.txt")
```

Returns:

```py
False
```

when the path does not exist.

## Why Check Before Acting?

Check whether a file exists before reading, deleting, or overwriting it.

```py
import os

filename = "novel.txt"

if os.path.exists(filename):
    os.remove(filename)
    print(f"Deleted: {filename}")
else:
    print(f"File not found: {filename}")
```

This prevents a `FileNotFoundError` when the file does not exist.

## Safer Rename Example

```py
import os

old_name = "first_draft.txt"
new_name = "finished_masterpiece.txt"

if os.path.exists(old_name):
    if not os.path.exists(new_name):
        os.rename(old_name, new_name)
        print(f"Renamed: {old_name} -> {new_name}")
    else:
        print(f"Not renamed: {new_name} already exists.")
else:
    print(f"Not renamed: {old_name} was not found.")
```

Checking the destination first helps avoid unintentionally replacing or conflicting with an existing file.

## Common Errors

| Error | Cause | Fix |
|---|---|---|
| `FileNotFoundError` | The source file does not exist or the path is wrong | Check the path with `os.path.exists()` first |
| `PermissionError` | The program lacks permission or another program is using the file | Close other programs, check permissions, or choose a different location |
| Unexpected overwrite or conflict | The destination filename already exists | Check the destination before renaming |
| Wrong file deleted | The filename or working directory is wrong | Print the path, test in a sample folder, and use a dry run first |

## Safety Rules

- Always test delete and rename scripts in a sample folder first.
- Check file existence before deleting or renaming.
- Print planned changes before making real changes.
- Keep backups before automating file operations.
- Avoid hard-coded absolute paths when the script must work across operating systems.

## What to Remember

- `os.remove("file.txt")` deletes a file.
- `os.rename("old.txt", "new.txt")` renames a file.
- `os.path.exists("file.txt")` returns `True` or `False`.
- Calling `os.remove()` on a missing file raises `FileNotFoundError`.
- The `os` module helps Python interact with the operating system.

<!-- Improvement idea: Add `os.path.getsize()`, `os.path.getmtime()`, `os.path.isfile()`, and `os.path.isdir()` after the next lesson. Then add a pathlib comparison because `Path.unlink()`, `Path.rename()`, and `Path.exists()` are the more modern Python equivalents. -->

## Course Source

- [Coursera: Working with Files](https://www.coursera.org/learn/python-operating-system/lecture/z5WQc/working-with-files)
