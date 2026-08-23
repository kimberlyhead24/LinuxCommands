# macOS Python Setup Notes

## Setup Checklist

- Check whether Python 3 is already installed
- Open Terminal
- Verify Python 3 works
- Verify `pip3` works
- Run a test script
- Make sure the correct Python command is used

## Main Commands

### Check Python version

```bash
python3 --version
python --version
```

Use `python3` first on macOS because `python` may point to an older version or may not be configured the way you expect.

### Start Python

```bash
python3
```

Starts the interactive Python 3 shell.

### Exit Python

```py
exit()
```

Leaves the Python interpreter.

### Run a Python file

```bash
python3 hello.py
```

Runs a Python script from the current folder.

### Check pip

```bash
python3 -m pip --version
pip3 --version
```

Shows whether Python package management is available.

### List installed packages

```bash
python3 -m pip list
```

Shows installed third-party packages.

### Install a package

```bash
python3 -m pip install package_name
```

Installs a package from PyPI.

### Upgrade a package

```bash
python3 -m pip install --upgrade package_name
```

Updates an installed package.

### Remove a package

```bash
python3 -m pip uninstall package_name
```

Uninstalls a package.

## Useful Terminal Commands

### Show current folder

```bash
pwd
```

Prints the current working directory.

### List files

```bash
ls
ls -la
```

Lists files and folders. `-la` shows hidden files and more details.

### Change folders

```bash
cd folder_name
cd ..
```

Moves into a folder or up one level.

### Create a folder

```bash
mkdir project-name
```

Creates a new folder.

## Quick Test

Create a file named `hello.py`:

```py
print("Hello from macOS!")
```

Run it:

```bash
python3 hello.py
```

## Best Practice

On macOS, prefer:

```bash
python3
python3 -m pip
```

This helps avoid confusion between Python versions and makes it clearer which interpreter is being used.

## Common Problems

| Problem | Fix |
|---|---|
| `python` runs the wrong version | Use `python3` |
| `pip` installs to the wrong place | Use `python3 -m pip` |
| `python3` not found | Install Python 3, then reopen Terminal |
| Package installs but script cannot import it | Make sure the package was installed with the same Python interpreter used to run the script |

## What to remember

- On macOS, `python3` is usually the safest command.
- `python3 -m pip` is better than relying on `pip` alone.
- Use Terminal to verify Python, run scripts, and manage packages.
- Keep setup notes focused on commands you can quickly scan later.
