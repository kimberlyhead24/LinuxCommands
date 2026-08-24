# `os` vs. `pathlib` for Files and Directories

## Core Idea

Python provides multiple ways to work with files and directories.

- `os` and `os.path` provide function-based tools that closely interact with the operating system.
- `pathlib` provides an object-oriented interface using `Path` objects.

For new Python code, `pathlib` is often easier to read and handles Windows, macOS, and Linux path differences cleanly.

## Create a Directory

### `os` version

```py
import os

dest_dir = os.path.join(os.getcwd(), "test1")

if not os.path.exists(dest_dir):
    os.mkdir(dest_dir)
```

### `pathlib` version

```py
from pathlib import Path

dest_dir = Path("./test1/")

if not dest_dir.exists():
    dest_dir.mkdir()
```

Both examples create a directory named `test1` if it does not already exist.

## Move a File

Use `Path.rename()` to rename or move a file when the destination is on the same filesystem.

```py
from pathlib import Path

source = Path("sample_data/README.md")
destination = Path("test1/README.md")

source.rename(destination)
```

> For moves across different drives or filesystems, use `shutil.move()` instead.

## Common Equivalents

| Task | `os` / `os.path` | `pathlib` |
|---|---|---|
| Current directory | `os.getcwd()` | `Path.cwd()` |
| Join paths | `os.path.join("data", "file.txt")` | `Path("data") / "file.txt"` |
| Check existence | `os.path.exists(path)` | `Path(path).exists()` |
| Check directory | `os.path.isdir(path)` | `Path(path).is_dir()` |
| Check file | `os.path.isfile(path)` | `Path(path).is_file()` |
| List folder contents | `os.listdir(path)` | `Path(path).iterdir()` |
| Create directory | `os.mkdir(path)` | `Path(path).mkdir()` |
| Remove empty directory | `os.rmdir(path)` | `Path(path).rmdir()` |
| Delete file | `os.remove(path)` | `Path(path).unlink()` |
| Rename or move | `os.rename(old, new)` | `Path(old).rename(new)` |
| Absolute path | `os.path.abspath(path)` | `Path(path).resolve()` |

## File Permissions

Permissions control who can read, write, or execute a file.

```py
import os

os.chmod("script.sh", 0o755)
```

`0o755` is an octal permission value commonly used for an executable script on Linux or macOS.

> File permission behavior differs across operating systems. Windows does not use Unix permission bits in the same way as Linux and macOS.

## Handle File-System Errors

File operations can fail because a file is missing, permission is denied, or a path is invalid.

```py
from pathlib import Path

filename = Path("important.txt")

try:
    content = filename.read_text(encoding="utf-8")
    print(content)
except FileNotFoundError:
    print(f"File not found: {filename}")
except PermissionError:
    print(f"Permission denied: {filename}")
except OSError as error:
    print(f"File-system error: {error}")
```

Use specific exceptions when possible. `OSError` can handle other operating-system-related errors.

## Text vs. Binary Files

Python treats text and binary files differently.

### Text file

```py
with open("notes.txt", "rt", encoding="utf-8") as file:
    text = file.read()
```

Text mode may translate line endings automatically between operating systems.

### Binary file

```py
with open("photo.jpg", "rb") as file:
    data = file.read()
```

Use binary mode for images, PDFs, audio, videos, ZIP files, and other non-text data. This prevents Python from treating binary bytes like text or changing line endings.

## Best Practices

- Prefer `pathlib.Path` for new code that works with paths.
- Use `with open(...)` so files close automatically.
- Use text mode for text and binary mode for non-text files.
- Check whether paths exist before destructive actions.
- Use `try/except` around file operations that can fail.
- Test move, rename, delete, and permission changes in a sample folder first.

<!-- Improvement idea: Add a runnable practice script that creates a test folder, moves a copied README file, checks paths, catches errors, and then safely cleans up only the test files. -->

## Resources

- [Python `os` documentation](https://docs.python.org/3/library/os.html)
- [Python `os.path` documentation](https://docs.python.org/3/library/os.path.html)
- [Python `pathlib` documentation](https://docs.python.org/3/library/pathlib.html)
