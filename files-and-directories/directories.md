# Working With Directories Using `os`

## Core Idea

A directory is another name for a folder. Python's `os` module can create directories, change the current working directory, list directory contents, and identify whether a path is a file or subdirectory.

## Import the Module

```py
import os
```

## Current Working Directory: `os.getcwd()`

### Course Example

```py
print(os.getcwd())
```

### What It Does

Returns and prints the **current working directory (CWD)**.

The CWD is the folder Python uses as the starting point for relative paths.

```py
import os

current_directory = os.getcwd()
print(current_directory)
```

In a Unix-like terminal, the comparable command is:

```bash
pwd
```

## Create a Directory: `os.mkdir()`

### Course Example

```py
os.mkdir("new_dir")
```

### What It Does

Creates a new directory named `new_dir` inside the current working directory.

```py
import os

os.mkdir("new_dir")
```

If the directory already exists, Python raises `FileExistsError`.

## Change Directory: `os.chdir()`

### Course Example

```py
os.chdir("new_dir")
os.getcwd()
```

### What It Does

```py
os.chdir("new_dir")
```

Changes Python's current working directory to `new_dir`.

```py
os.getcwd()
```

Returns the updated current working directory.

Example:

```py
import os

print(os.getcwd())

os.chdir("new_dir")

print(os.getcwd())
```

> `os.chdir()` affects relative paths used by the rest of the running script. Use it carefully because it can make a script harder to follow.

## Remove an Empty Directory: `os.rmdir()`

### Course Example

```py
os.mkdir("newer_dir")
os.rmdir("newer_dir")
```

### What It Does

- `os.mkdir("newer_dir")` creates an empty directory.
- `os.rmdir("newer_dir")` removes that empty directory.

> **Important:** `os.rmdir()` works only when the directory is empty. If it contains files or subdirectories, Python raises an error.

## List Directory Contents: `os.listdir()`

### Course Example

```py
import os

os.listdir("website")
```

### What It Does

Returns a list containing the names of files and subdirectories inside `website`.

Example result:

```py
["index.html", "images", "styles.css"]
```

The result contains names only. It does not tell you whether an item is a file or directory.

## Check Files and Subdirectories

### Course Example

```py
dir = "website"

for name in os.listdir(dir):
    fullname = os.path.join(dir, name)

    if os.path.isdir(fullname):
        print("{} is a directory".format(fullname))
    else:
        print("{} is a file".format(fullname))
```

## Line-by-Line Explanation

```py
dir = "website"
```

Stores the directory to inspect in a variable.

> `directory` is a clearer variable name than `dir`. Avoid `dir` in your own code because Python already has a built-in function named `dir()`.

```py
for name in os.listdir(dir):
```

- Gets every name inside `website`.
- Loops through each file or subdirectory name one at a time.

```py
fullname = os.path.join(dir, name)
```

Combines the parent folder and current item name into a usable path.

Example:

```py
os.path.join("website", "images")
```

Possible result on Windows:

```text
website\images
```

Possible result on macOS or Linux:

```text
website/images
```

Use `os.path.join()` instead of manually adding `/` or `\`. It chooses the correct path separator for the operating system.

```py
if os.path.isdir(fullname):
```

Checks whether the complete path points to a directory.

```py
print("{} is a directory".format(fullname))
```

Prints a message if the item is a subdirectory.

```py
else:
    print("{} is a file".format(fullname))
```

Prints a message if the item is not a directory.

## Cleaner Modern Version

```py
import os

directory = "website"

for name in os.listdir(directory):
    full_path = os.path.join(directory, name)

    if os.path.isdir(full_path):
        print(f"{full_path} is a directory")
    else:
        print(f"{full_path} is a file")
```

## Common Functions

| Function | Purpose |
|---|---|
| `os.getcwd()` | Returns the current working directory |
| `os.mkdir("folder")` | Creates one new directory |
| `os.chdir("folder")` | Changes the current working directory |
| `os.rmdir("folder")` | Removes an empty directory |
| `os.listdir("folder")` | Returns names inside a directory |
| `os.path.join(parent, child)` | Builds a cross-platform path |
| `os.path.isdir(path)` | Returns `True` if a path is a directory |
| `os.path.isfile(path)` | Returns `True` if a path is a regular file |

## Safety Checklist

- Check the current working directory before using relative paths.
- Check that a folder does not exist before creating it.
- Check that a directory is empty before calling `os.rmdir()`.
- Use `os.path.join()` rather than manually adding path separators.
- Test directory-changing or deletion code in a sample folder first.

## What to Remember

- `os.getcwd()` shows where the script is currently running.
- `os.mkdir()` creates a directory.
- `os.chdir()` changes the current working directory.
- `os.rmdir()` deletes only an empty directory.
- `os.listdir()` returns names inside a directory.
- `os.path.join()` creates paths that work across Windows, macOS, and Linux.
- `os.path.isdir()` distinguishes directories from files.

<!-- Improvement idea: Add `os.makedirs(..., exist_ok=True)` for nested directories, `shutil.rmtree()` only in a clearly marked high-risk section, and a modern pathlib comparison using `Path.mkdir()`, `Path.iterdir()`, and `Path.is_dir()`. -->

## Course Source

- [Coursera: Directories](https://www.coursera.org/learn/python-operating-system/lecture/9wIkJ/directories)
