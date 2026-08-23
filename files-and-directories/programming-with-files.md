# Programming with Files

## Core Idea

Programs often need to work with files instead of only showing output on the screen.

A file lets data be saved, reused later, shared with other programs, and organized inside directories.

## Why Files Matter

Files are useful for:

- Saving data permanently
- Reading existing data into a program
- Writing reports or logs
- Processing configuration files
- Working with text, CSV, JSON, images, and other stored information

## Common File Tasks

| Task | What it means |
|---|---|
| Open a file | Connect a program to a file so it can be read or written |
| Read a file | Get data from the file into the program |
| Write a file | Save new data into a file |
| Append to a file | Add data to the end without replacing existing contents |
| Close a file | Release the file after use |
| Navigate directories | Move through folders to find the correct file location |

## Basic Python Example

```py
with open("hello.txt", "w") as file:
    file.write("Hello, file system!\n")
```

This creates or overwrites `hello.txt` and writes one line of text to it.

Read the file:

```py
with open("hello.txt", "r") as file:
    content = file.read()

print(content)
```

## File Modes

| Mode | Meaning |
|---|---|
| `"r"` | Read a file |
| `"w"` | Write to a file, replacing old contents if the file exists |
| `"a"` | Append to the end of a file |
| `"x"` | Create a new file and fail if it already exists |

## Why `with open(...)` Matters

Using `with open(...)` automatically closes the file when the block finishes.

```py
with open("notes.txt", "r") as file:
    text = file.read()
```

This is safer than opening a file and forgetting to close it manually.

## Files and Directories

A file lives inside a directory, also called a folder.

Examples:

```text
notes.txt
reports/summary.txt
data/input.csv
```

A program must either:

- Run from the correct directory, or
- Use the correct relative or full file path

## Common Terminal Commands

### Show current directory

```bash
pwd
```

### List files

```bash
ls
ls -la
```

### Change directory

```bash
cd folder_name
cd ..
```

### Create a directory

```bash
mkdir new_folder
```

### Show files on Windows PowerShell

```powershell
dir
pwd
```

## Common Problems

| Problem | Cause | Fix |
|---|---|---|
| `FileNotFoundError` | Wrong path or filename | Check the current folder and the file path |
| File content is overwritten | Used `"w"` mode by mistake | Use `"a"` to append when needed |
| Encoding issues | File contains characters not handled by the default encoding | Open with an explicit encoding when needed |
| Script cannot find the file | Script is running from a different working directory | Use `pwd`, `dir`, or `ls` and verify the path |

## What to Remember

- Files let programs save and reuse data.
- `open()` connects Python code to a file.
- Use `with open(...)` so files close automatically.
- File paths matter as much as file names.
- Directories organize files and help programs find them.

<!-- Improvement idea: Add a later section comparing absolute paths vs. relative paths once those lessons appear. -->
