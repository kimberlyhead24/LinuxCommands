# Windows Python Setup Notes

## Setup Checklist

- Install Python 3
- Select **Add Python to PATH** during installation
- Open PowerShell, Command Prompt, or the VS Code terminal
- Verify Python works
- Verify `pip` works
- Run a test script

## Main Commands

### Check Python version

```powershell
py --version
python --version
py -3 --version
```

Use these to confirm Python is installed and that Python 3 is available.

### Start Python

```powershell
py
```

Starts the interactive Python shell.

### Exit Python

```py
exit()
```

Leaves the Python interpreter.

### Run a Python file

```powershell
py hello.py
python hello.py
```

Runs a Python script from the current folder.

### Check pip

```powershell
py -m pip --version
```

Shows whether `pip` is installed and connected to Python.

### List installed packages

```powershell
py -m pip list
```

Shows installed third-party packages.

### Install a package

```powershell
py -m pip install package_name
```

Installs a package from PyPI.

### Upgrade a package

```powershell
py -m pip install --upgrade package_name
```

Updates an installed package.

### Remove a package

```powershell
py -m pip uninstall package_name
```

Uninstalls a package.

## Recommended Windows Commands

### Show current folder

```powershell
pwd
```

Shows the current working directory.

### List files

```powershell
dir
```

Lists files and folders in the current directory.

### Change folders

```powershell
cd folder_name
cd ..
```

Moves into a folder or up one level.

### Create a folder

```powershell
mkdir project-name
```

Creates a new folder.

## Quick Test

Create a file named `hello.py`:

```py
print("Hello, world!")
```

Run it:

```powershell
