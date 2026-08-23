# Run Python Scripts

## Quick Start

1. Open a terminal.
2. Move into the folder containing the Python file.
3. Run the file with the correct Python command.

## Run a Script

### Windows

```powershell
py script_name.py
```

Use Python 3 explicitly:

```powershell
py -3 script_name.py
```

### macOS and Linux

```bash
python3 script_name.py
```

## Example

Create a file named `hello.py`:

```py
print("Hello, world!")
```

Open a terminal in the same folder and run:

### Windows

```powershell
py hello.py
```

### macOS or Linux

```bash
python3 hello.py
```

Expected output:

```text
Hello, world!
```

## Check Your Location

Before running a script, check the current folder.

### Windows PowerShell

```powershell
Get-Location
```

Short version:

```powershell
pwd
```

### macOS and Linux

```bash
pwd
```

## List Files

Use this to confirm the script is in the current folder.

### Windows PowerShell

```powershell
dir
```

### macOS and Linux

```bash
ls
```

## Change Folders

Move into the folder that contains your script:

```bash
cd folder_name
```

Move up one folder:

```bash
cd ..
```

Example:

```bash
cd Documents/python-practice
```

## Run a Script From Another Folder

You can provide a relative or full path instead of changing folders first.

### Relative path

```bash
python3 scripts/hello.py
```

### Full path

```bash
python3 /home/user/projects/hello.py
```

Windows example:

```powershell
py "C:\Users\YourName\Documents\python-practice\hello.py"
```

Use quotation marks if the file path contains spaces.

## Interactive Mode vs. Script Mode

| Mode | Command | Best for |
|---|---|---|
| Interactive Python shell | `py` or `python3` | Testing short lines of code |
| Run a script | `py file.py` or `python3 file.py` | Running saved programs |
| Run a module | `python -m module_name` | Running installed modules or project tools |

## Useful Options

### Start interactive mode after a script finishes

```bash
python3 -i script_name.py
```

This runs the script, then keeps Python open so variables can be inspected.

### Run a module

```bash
python3 -m module_name
```

Example:

```bash
python3 -m pip list
```

This runs the `pip` module using the selected Python interpreter.

## Common Problems

| Problem | Cause | Fix |
|---|---|---|
| `python` or `python3` not found | Python is not installed or not on `PATH` | Check installation and use `py` on Windows |
| `can't open file` | Wrong folder or filename | Run `pwd` and `ls`/`dir`, then use the correct path |
| `ModuleNotFoundError` | Required package is not installed for that interpreter | Install it with `python -m pip install package_name` |
| Script shows no output | The script may not call `print()` or run the expected code | Add a temporary `print()` and save the file |
| Wrong Python version | More than one Python version is installed | Use `py -3` on Windows or `python3` on macOS/Linux |

## What to Remember

- A Python script is usually a text file ending in `.py`.
- Use `py script.py` on Windows.
- Use `python3 script.py` on macOS and Linux.
- Run `pwd` and `ls`/`dir` when Python cannot find your file.
- Use quotes around file paths that contain spaces.
