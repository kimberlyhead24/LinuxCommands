# Getting Your Computer Ready for Python

## Purpose

Running Python scripts locally is important for practicing programming skills and learning how Python interacts with an operating system. Python runs on major operating systems, including Windows, macOS, and Linux.

## Check Python Installation

Open a terminal or command prompt and check the installed Python version:

```bash
python --version
```

Possible results:

| Result | Meaning | Next step |
|---|---|---|
| Command not recognized / not found | Python is not installed or is not on the system PATH | Install Python 3 |
| `Python 2.x.x` | An outdated Python 2 installation was found | Try `python3 --version`; use Python 3 for this course |
| `Python 3.x.x` | Python 3 is installed and available | Ready to continue |

On many Linux and macOS systems, the Python 3 command is:

```bash
python3 --version
```

## Why Python 3?

Python 2 and Python 3 have important differences. Use Python 3 because most modern libraries and tools target it, and it includes language improvements and features that Python 2 does not. 

## Python Standard Library

The Python standard library is installed together with Python. It contains built-in modules for common programming tasks, so those modules do not need to be downloaded separately.

## External Modules

Not every useful capability is included in the standard library. External modules can add features such as:

- Generating PDF files
- Serving web pages
- Creating compressed files
- Working with email
- Many other specialized tasks

Developers publish reusable external Python modules on **PyPI**, the Python Package Index.

## pip

`pip` is Python's cross-platform package-management tool. It can install, update, and remove external Python packages.

Common commands:

```bash
python -m pip install package_name
python -m pip install --upgrade package_name
python -m pip uninstall package_name
python -m pip list
```

Using `python -m pip` helps ensure that `pip` installs a package for the same Python interpreter you plan to use.

## Study Checklist

- [ ] Open a terminal or command prompt
- [ ] Run `python --version`
- [ ] Run `python3 --version` if needed
- [ ] Confirm that Python 3 is installed
- [ ] Run `python -m pip --version`
- [ ] Understand the difference between the standard library and external packages
- [ ] Know that PyPI is where Python packages are published
## Windows Python launcher
- [ ] Run 'py --version'
- [ ] Run 'py -3 --version'
- [ ] Run 'py -m pip --version'
