# Linux Python Setup Notes

## Setup Checklist

- Open a terminal
- Check whether Python 3 is installed
- Check whether `pip` is installed
- Install Python 3 if needed
- Verify Python commands work
- Run a test script

## Main Commands

### Check Python version

```bash
python3 --version
python --version
```

Use `python3` first because many Linux systems separate Python 2 and Python 3.

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

Displays installed third-party packages.

### Install a package

```bash
python3 -m pip install package_name
```

Installs a Python package from PyPI.

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

## Install Python on Linux

### Debian / Ubuntu

```bash
sudo apt update
sudo apt install python3 python3-pip
```

### Fedora

```bash
sudo dnf install python3 python3-pip
```

### Arch Linux

```bash
sudo pacman -S python python-pip
```

## Useful Linux Commands

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

Lists files and folders. `-la` shows hidden files and details.

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

### Create a file

```bash
touch hello.py
```

Creates an empty file.

## Quick Test

Create `hello.py`:

```py
print("Hello from Linux!")
```

Run it:

```bash
python3 hello.py
```

## Best Practice

On Linux, prefer:

```bash
python3
python3 -m pip
```

This makes it clear which Python version is being used and helps avoid installing packages into the wrong environment.

## Common Problems

| Problem | Fix |
|---|---|
| `python3` not found | Install Python 3 with your distro package manager |
| `pip3` not found | Install `python3-pip` or use `python3 -m ensurepip` if available |
| `python` points to the wrong version | Use `python3` explicitly |
| Permission denied during install | Use a virtual environment or install with the system package manager |
| Package installs but import fails | Make sure the package was installed with the same interpreter used to run the script |

## What to remember

- On Linux, `python3` is usually the safest command.
- `python3 -m pip` is better than using `pip` alone.
- Package installation commands differ by Linux distribution.
- The terminal is the main place for checking versions, running scripts, and managing packages.
