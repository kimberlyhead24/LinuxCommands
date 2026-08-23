# Environment Setup Resources

## Purpose

Use these resources when setting up Python on a new computer or when learning how software installation works on a specific operating system.

## Python Installation

Download Python from the official website:

- [Python Downloads](https://www.python.org/downloads/)

Choose the installer that matches your operating system:

- Windows
- macOS
- Linux

After installing, verify Python in a terminal:

```bash
python3 --version
```

On Windows, also try:

```powershell
py --version
python --version
```

## pip and Python Packages

`pip` is Python's package-management tool. It installs and manages third-party packages from PyPI.

### Check pip

```bash
python3 -m pip --version
```

Windows:

```powershell
py -m pip --version
```

### Common pip Commands

```bash
python3 -m pip list
python3 -m pip install package_name
python3 -m pip install --upgrade package_name
python3 -m pip uninstall package_name
```

Use `python -m pip` instead of `pip` by itself when possible. It helps ensure packages are installed for the same Python interpreter that runs the project.

## Operating System Package Managers

A package manager installs, updates, and removes software through the command line. The correct tool depends on the operating system.

| Operating system | Common package manager | Example |
|---|---|---|
| Windows | `winget`, Chocolatey (`choco`) | `winget install Python.Python.3` |
| macOS | Homebrew (`brew`) | `brew install python` |
| Ubuntu / Debian Linux | APT (`apt`) | `sudo apt install python3 python3-pip` |
| Fedora Linux | DNF (`dnf`) | `sudo dnf install python3 python3-pip` |
| Arch Linux | Pacman (`pacman`) | `sudo pacman -S python python-pip` |

## Python vs. System Package Manager

Use the right tool for the job:

| Need | Recommended tool |
|---|---|
| Install Python itself | Operating-system package manager or official Python installer |
| Install a Python library such as `requests` | `python -m pip install requests` |
| Update Python packages for a project | `python -m pip install --upgrade package_name` |
| Install a system tool such as Git | Operating-system package manager or official installer |

## Helpful Links

- [Official Python downloads](https://www.python.org/downloads/)
- [Real Python installation guide](https://realpython.com/installing-python/)
- [Python Packaging User Guide: pip and virtual environments](https://packaging.python.org/guides/installing-using-pip-and-virtual-environments/)
- [Technical Support Fundamentals](https://www.coursera.org/learn/technical-support-fundamentals)
- [Operating Systems and You: Becoming a Power User](https://www.coursera.org/learn/os-power-user)

## What to Remember

- Download Python from an official source or a trusted operating-system package manager.
- Use the package manager designed for your operating system to install system software.
- Use `pip` to install Python packages.
- Prefer `python -m pip` so `pip` matches the Python interpreter you are using.
- Installation commands differ across Windows, macOS, and Linux.
