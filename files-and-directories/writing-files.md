# Writing Files in Python

## Core Idea

Python can write text to a file with the `write()` method.

Before writing, choose a file mode carefully. Some modes replace existing content, while others add new content without deleting what is already there.

## Example: Write a File

```py
with open("novel.txt", "w") as file:
    file.write("It was a dark and stormy night")
```

## Line-by-Line Explanation

```py
with open("novel.txt", "w") as file:
```

- `open("novel.txt", "w")` opens a file named `novel.txt`.
- `"w"` means **write mode**.
- If `novel.txt` does not exist, Python creates it.
- If `novel.txt` already exists, Python overwrites its contents.
- `as file` stores the file object in the variable named `file`.
- `with` automatically closes the file when the indented block ends.

```py
file.write("It was a dark and stormy night")
```

- `write()` writes the given string into `novel.txt`.
- `write()` does not add a newline automatically.
- The resulting file contains:

```text
It was a dark and stormy night
```

## Write Mode: `"w"`

```py
with open("output.txt", "w") as file:
    file.write("First line\n")
    file.write("Second line\n")
```

### What `"w"` Does

- Creates the file if it does not exist.
- Replaces all existing contents if the file already exists.
- Starts writing from the beginning of the file.

> **Warning:** `"w"` can erase existing file content. Use it only when replacing the file is intentional.

## Append Mode: `"a"`

```py
with open("output.txt", "a") as file:
    file.write("A new line added later\n")
```

### What `"a"` Does

- Creates the file if it does not exist.
- Adds new content to the end if the file already exists.
- Does not delete existing contents.

Use append mode for logs, history files, or adding records over time.

## Write Text with Newlines

`write()` does **not** add a newline automatically.

```py
with open("notes.txt", "w") as file:
    file.write("First line")
    file.write("Second line")
```

Output:

```text
First lineSecond line
```

Add `\n` to create new lines:

```py
with open("notes.txt", "w") as file:
    file.write("First line\n")
    file.write("Second line\n")
```

Output:

```text
First line
Second line
```

## Write Multiple Lines

### Loop with `write()`

```py
tasks = ["Study Python", "Practice Git", "Build a project"]

with open("tasks.txt", "w") as file:
    for task in tasks:
        file.write(f"{task}\n")
```

### Use `writelines()`

```py
lines = [
    "Study Python\n",
    "Practice Git\n",
    "Build a project\n",
]

with open("tasks.txt", "w") as file:
    file.writelines(lines)
```

`writelines()` writes each string from an iterable, but it does **not** add `\n` for you. Include newline characters in each string when separate lines are needed.

## File Modes

| Mode | Meaning | Creates file? | Replaces existing content? |
|---|---|---:|---:|
| `"r"` | Read | No | No |
| `"w"` | Write | Yes | Yes |
| `"a"` | Append | Yes | No |
| `"x"` | Create a new file only | Yes | Fails if file already exists |

## Read and Write Mode

```py
with open("notes.txt", "r+") as file:
    content = file.read()
    file.write("\nNew note")
```

`"r+"` allows both reading and writing, but it requires the file to already exist. For most beginner scripts, use separate read or write steps unless you specifically need both.

## Use an Encoding

For text files, specify UTF-8 when you want predictable behavior across computers:

```py
with open("notes.txt", "w", encoding="utf-8") as file:
    file.write("Hello, world!\n")
```

## Common Problems

| Problem | Likely cause | Fix |
|---|---|---|
| Existing content disappeared | Used `"w"` mode | Use `"a"` if you mean to add content |
| Text appears on one line | Missing `\n` | Add `\n` after each line |
| `FileExistsError` | Used `"x"` but the file already exists | Choose a new filename or use `"w"`/`"a"` intentionally |
| `FileNotFoundError` | Parent folder does not exist | Create the folder or use the correct path |
| `PermissionError` | Program cannot write to that location | Choose a writable folder or check permissions |
| Strange characters appear | Encoding mismatch | Use `encoding="utf-8"` |

## Safety Checklist

Before writing a file:

- Confirm the filename and folder path.
- Decide whether old content should be replaced or preserved.
- Use `"a"` for logs or adding records.
- Use `"w"` only when overwriting is intentional.
- Test with a sample file before changing important data.
- Use `with open(...)` so the file closes automatically.

## What to Remember

- `file.write()` writes a string to an open file.
- `write()` does not add line breaks automatically.
- `"w"` creates or replaces a file.
- `"a"` creates or adds to the end of a file.
- `with open(...)` automatically closes the file.
- Add `encoding="utf-8"` for consistent text-file handling.

<!-- Improvement idea: Add the course's exact writing-files code and a line-by-line explanation if the transcript or review page exposes it. Add a later example that writes CSV data using Python's built-in csv module. -->

## Course Source

- [Coursera: Writing Files](https://www.coursera.org/learn/python-operating-system/lecture/fC3e9/writing-files)
