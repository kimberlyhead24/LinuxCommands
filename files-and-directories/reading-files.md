# Reading Files in Python

## Core Idea

Python uses file objects to read from and write to files.

To work with a file, Python must open it first. The `open()` function returns a file object that provides methods such as `readline()`, `read()`, and `close()`.

## Course Example: Open, Read, Close

```py
file = open("spider.txt")

print(file.readline())
print(file.readline())
print(file.read())

file.close()
```

## Line-by-Line Explanation

```py
file = open("spider.txt")
```

- Opens `spider.txt` in read mode by default.
- Stores the returned file object in the `file` variable.
- Assumes `spider.txt` is in the same directory as the Python script.

```py
print(file.readline())
```

- Reads one line from the current file position.
- Returns that line as a string.
- Prints the line.
- Moves the current position forward.

```py
print(file.readline())
```

- Reads and prints the next line.
- The file position moves forward again.

```py
print(file.read())
```

- Reads everything remaining from the current position to the end of the file.
- Since two lines were already read, this prints the rest of the file.

```py
file.close()
```

- Closes the file after the program finishes using it.
- Releases the operating-system resources associated with the file.

## File Position

A file object keeps track of its current position.

Example file: `spider.txt`

```text
Itsy bitsy spider
Climbed up the water spout
Down came the rain
And washed the spider out
Out came the sun
And dried up all the rain
```

After these two lines run:

```py
file.readline()
file.readline()
```

Python is positioned at the beginning of:

```text
Down came the rain
```

Then this command:

```py
file.read()
```

returns every remaining line through the end of the file.

## `readline()` vs. `read()`

| Method | Returns | File position afterward |
|---|---|---|
| `file.readline()` | One line as a string | Moves forward one line |
| `file.read()` | All remaining content as one string | Moves to the end of the file |

## Why Close Files?

Closing a file is important because:

- It releases the file resource when the program is finished.
- It helps prevent using too many open file descriptors.
- It reduces the chance of conflicts when multiple programs use the same file.
- It helps avoid unexpected behavior when files are read or modified by multiple processes.

## Preferred Pattern: `with open()`

```py
with open("spider.txt") as file:
    print(file.readline())
```

### What `with` Does

- Opens `spider.txt`.
- Assigns the file object to the `file` variable.
- Runs the indented code block.
- Closes the file automatically when the block ends.

This is usually the preferred approach for opening and using a file in one section of code.

## Manual vs. Automatic Closing

| Approach | Example | Closing behavior |
|---|---|---|
| Manual | `file = open("spider.txt")` | Must call `file.close()` yourself |
| Automatic | `with open("spider.txt") as file:` | Python closes the file when the block ends |

## File Paths

### Same directory

```py
with open("spider.txt") as file:
    print(file.read())
```

This works when the file is located in the current working directory.

### Relative path

```py
with open("data/spider.txt") as file:
    print(file.read())
```

This looks for `spider.txt` inside a `data` folder.

### Absolute path

```py
with open("/home/user/project/data/spider.txt") as file:
    print(file.read())
```

An absolute path gives the complete location of a file.

Windows example:

```py
with open(r"C:\Users\YourName\Documents\project\spider.txt") as file:
    print(file.read())
```

The `r` creates a raw string, which helps Python interpret Windows backslashes correctly.

## Common Problems

| Problem | Likely cause | Fix |
|---|---|---|
| `FileNotFoundError` | Filename or path is wrong | Check spelling, current directory, and file path |
| `PermissionError` | The program cannot access the file | Check file permissions and whether another program is locking it |
| `ValueError: I/O operation on closed file` | Code tries to read after `close()` | Read the file before closing it, or reopen it |
| File contents are missing | The file position is already at the end | Reopen the file or use `file.seek(0)` later when learning file positions |

## What to Remember

- `open("filename")` opens a file in read mode by default.
- `readline()` reads one line and moves the file position forward.
- `read()` reads the remaining content from the current position to the end.
- `close()` releases the file when using manual open/close.
- `with open(...) as file:` is usually safer because Python closes the file automatically.

<!-- Improvement idea: Add examples for `readlines()`, iterating through a file line by line, explicit file modes such as `"r"` and `"w"`, and encodings such as `encoding="utf-8"` after those concepts appear in later lessons. -->

## Text Mode and Binary Mode

Python files are usually opened in text mode by default.

```py
with open("sample_data/declaration.txt", "rt") as textfile:
    for line in textfile:
        print(line)
```

### What `"rt"` Means

| Mode character | Meaning |
|---|---|
| `"r"` | Open for reading |
| `"t"` | Treat the file as text |

`"rt"` is the same as the default read mode for a text file:

```py
open("sample_data/declaration.txt")
open("sample_data/declaration.txt", "r")
open("sample_data/declaration.txt", "rt")
```

All three open the file for reading text.

## Binary Files

Use binary mode for non-text data such as images, PDFs, audio, or ZIP files.

```py
with open("photo.jpg", "rb") as file:
    image_data = file.read()
```

| Mode | Meaning |
|---|---|
| `"rb"` | Read binary data |
| `"wb"` | Write binary data |
| `"ab"` | Append binary data |

Binary files are read and written as `bytes`, not normal text strings.

> Do not use `encoding=` with binary mode.
