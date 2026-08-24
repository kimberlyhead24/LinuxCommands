# File Paths

## Core Idea

A file path tells the operating system where a file or folder is located.

Programs use file paths to open, read, write, move, rename, and delete files.

## Path Parts

Example path:

```text
/home/user/projects/python-notes/data/report.txt
```

| Part | Meaning |
|---|---|
| `/` | Path separator on Linux and macOS |
| `home` | Top-level directory in this example |
| `user` | User's home folder |
| `projects` | A folder inside the home folder |
| `python-notes` | Project folder |
| `data` | Folder inside the project |
| `report.txt` | File name |

## Absolute Paths

An absolute path gives the complete location of a file, starting from the root of the file system.

### Linux and macOS

```text
/home/user/projects/python-notes/data/report.txt
```

### Windows

```text
C:\Users\YourName\Documents\python-notes\data\report.txt
```

Use an absolute path when the program needs to locate a file regardless of the current working directory.

## Relative Paths

A relative path starts from the current working directory.

```text
data/report.txt
```

This means:

> Look for `report.txt` inside the `data` folder in the current directory.

Example Python code:

```py
with open("data/report.txt", "r", encoding="utf-8") as file:
    print(file.read())
```

Relative paths are often preferred for project files because the project can be moved to another computer without changing hard-coded user-specific paths.

## Current Working Directory

The current working directory is the folder a program treats as its starting location.

Check it in Python:

```py
import os

print(os.getcwd())
```

Check it in a macOS/Linux terminal:

```bash
pwd
```

Check it in Windows PowerShell:

```powershell
pwd
```

## Special Path Symbols

| Symbol | Meaning | Example |
|---|---|---|
| `.` | Current directory | `./report.txt` |
| `..` | Parent directory | `../data/report.txt` |
| `~` | Current user's home directory in many shells | `~/Documents/report.txt` |
| `/` | Directory separator on Linux/macOS | `data/report.txt` |
| `\` | Directory separator on Windows | `data\report.txt` |

## Python and Windows Paths

A Windows path uses backslashes:

```py
"C:\Users\YourName\Documents\report.txt"
```

But backslashes can have special meaning in Python strings. For example, `\n` represents a new line.

Use a raw string:

```py
r"C:\Users\YourName\Documents\report.txt"
```

Or use forward slashes, which Python accepts on Windows:

```py
"C:/Users/YourName/Documents/report.txt"
```

## Use `pathlib` for New Python Code

`pathlib` is the recommended modern way to work with paths in Python because it handles Windows, macOS, and Linux path differences more cleanly.

```py
from pathlib import Path

project_folder = Path("python-notes")
file_path = project_folder / "data" / "report.txt"

with file_path.open("r", encoding="utf-8") as file:
    print(file.read())
```

The `/` operator joins paths when using `Path` objects. It does not mean division in this context.

## Common Problems

| Problem | Likely cause | Fix |
|---|---|---|
| `FileNotFoundError` | Incorrect filename, relative path, or working directory | Check the path and print the current working directory |
| Invalid Windows path | Backslashes are interpreted as escape characters | Use `r"..."`, double backslashes, forward slashes, or `pathlib` |
| Code works on one computer but not another | Hard-coded absolute path | Use relative paths or `pathlib` |
| Permission error | Program cannot access the folder or file | Choose a permitted location or update permissions |
| Spaces in a path | Path was not correctly quoted in a terminal | Wrap the path in quotes |

## What to Remember

- A file path tells the operating system where a file or folder is located.
- Absolute paths start from the root or drive and give a complete location.
- Relative paths start from the current working directory.
- `.` means current directory and `..` means parent directory.
- Use `pathlib.Path` for portable, modern Python path handling.
- Avoid hard-coded absolute paths in projects when possible.

<!-- Improvement idea: Add course-specific examples once the review/transcript page reveals the exact Linux, Windows, and macOS path examples used in the lesson. Add a small path-practice exercise with `Path.cwd()`, parent folders, and file existence checks. -->

## Course Source

- [Coursera: File paths](https://www.coursera.org/learn/python-operating-system/lecture/pOcv7/file-paths)
