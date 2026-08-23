# What Is an IDE?

## Core Idea

An **IDE** (Integrated Development Environment) is software that combines common programming tools into one workspace.

Instead of using separate programs to write code, run code, debug errors, manage files, and use version control, an IDE puts many of those tools in one application.

## Common IDE Features

| Feature | What it does |
|---|---|
| Code editor | Lets you write and edit source code |
| Syntax highlighting | Colors code to make keywords, strings, comments, and errors easier to read |
| Autocomplete / IntelliSense | Suggests code as you type |
| Linter | Identifies style issues, mistakes, and possible bugs |
| Debugger | Lets you pause a program, inspect variables, and step through code |
| Integrated terminal | Runs commands without leaving the editor |
| File explorer | Lets you create, move, rename, and organize project files |
| Version-control tools | Helps manage Git changes, commits, branches, and remotes |
| Extensions | Add language support, formatting, testing, themes, and other features |

## VS Code

Visual Studio Code is a lightweight, extensible code editor that can function like an IDE when you install extensions for the languages and tools you use.

Useful VS Code tools for Python:

- Python extension
- Pylance extension for type checking and IntelliSense
- Python debugger
- Integrated terminal
- Git source-control panel
- Formatter and linter extensions

## IDE vs. Text Editor

| Tool type | Main purpose | Examples |
|---|---|---|
| Plain text editor | Edit text or code with few programming tools | Notepad, TextEdit |
| Code editor | Write code with programming features | VS Code, Sublime Text |
| IDE | Write, run, debug, test, and manage projects in one environment | PyCharm, Visual Studio, IntelliJ IDEA |

The categories can overlap. VS Code is often called a code editor, but extensions can give it many IDE features.

## Basic Python Workflow in VS Code

1. Open a project folder with **File → Open Folder**.
2. Create a Python file such as `main.py`.
3. Write code.
4. Select a Python interpreter.
5. Run the file in the integrated terminal or with the Run button.
6. Use breakpoints and the debugger to investigate problems.
7. Review changes in Source Control and commit with Git.

## Useful VS Code Shortcuts

| Task | Windows / Linux | macOS |
|---|---|---|
| Open terminal | `Ctrl` + `` ` `` | `Control` + `` ` `` |
| Open Command Palette | `Ctrl` + `Shift` + `P` | `Command` + `Shift` + `P` |
| Open Source Control | `Ctrl` + `Shift` + `G` | `Control` + `Shift` + `G` |
| Search files | `Ctrl` + `P` | `Command` + `P` |
| Run without debugging | `Ctrl` + `F5` | `Control` + `F5` |
| Start debugging | `F5` | `F5` |

## What to Remember

- IDE stands for Integrated Development Environment.
- An IDE combines tools for writing, running, debugging, and organizing code.
- VS Code becomes more IDE-like through language extensions.
- The terminal and Git tools inside VS Code are useful, but they still run real command-line and Git commands.
- Knowing the command line remains valuable even when an IDE provides buttons and menus.
