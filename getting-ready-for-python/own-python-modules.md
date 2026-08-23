# Your Own Python Modules

## Core Idea

A **module** is a Python file that contains reusable code.

Any file ending in `.py` can be imported as a module by another Python file.

## Why Use Modules?

Modules help you:

- Organize related code
- Reuse functions, classes, and variables
- Keep files smaller and easier to read
- Separate application logic into clear parts
- Make code easier to test and maintain

## Basic Example

Project files:

```text
project/
├── greeting.py
└── main.py
```

### `greeting.py`

```py
def say_hello(name):
    return f"Hello, {name}!"
```

### `main.py`

```py
import greeting

message = greeting.say_hello("Kimberly")
print(message)
```

Run the main file:

```bash
python3 main.py
```

Windows:

```powershell
py main.py
```

Output:

```text
Hello, Kimberly!
```

## Import a Specific Item

Instead of importing the entire module:

```py
import greeting

print(greeting.say_hello("Kimberly"))
```

Import only the function you need:

```py
from greeting import say_hello

print(say_hello("Kimberly"))
```

## Rename an Import

Use `as` to give an imported module or item a shorter name:

```py
import greeting as g

print(g.say_hello("Kimberly"))
```

```py
from greeting import say_hello as hello

print(hello("Kimberly"))
```

## Module Search Path

When Python runs:

```py
import greeting
```

it looks for `greeting.py` in places such as:

1. The folder containing the current script
2. Installed Python packages
3. Other folders listed in Python's module search path

View the search path:

```py
import sys

for folder in sys.path:
    print(folder)
```

## `__name__` and Main Files

Python automatically gives each module a `__name__` value.

```py
print(__name__)
```

- When a file runs directly, `__name__` is `"__main__"`.
- When a file is imported, `__name__` is normally the module name.

Use this pattern for code that should run only when the file is executed directly:

```py
def say_hello(name):
    return f"Hello, {name}!"

if __name__ == "__main__":
    print(say_hello("Kimberly"))
```

This lets the module be imported without automatically running the test code.

## Common Problems

| Problem | Likely cause | Fix |
|---|---|---|
| `ModuleNotFoundError` | Python cannot find the module | Confirm the file is in the same folder, check spelling, or use the correct project structure |
| `ImportError` | The module exists but the requested name does not | Check the function, class, or variable name |
| Circular import error | Two modules import each other | Move shared code to a third module or redesign the dependency |
| Import runs unwanted code | Module has code at the top level | Put test/run code inside `if __name__ == "__main__":` |
| Wrong module imports | A local file has the same name as a standard or installed module | Rename the local file, such as avoiding `json.py`, `random.py`, or `requests.py` |

## What to Remember

- A module is usually a `.py` file with reusable code.
- Use `import module_name` to import a whole module.
- Use `from module_name import item_name` to import a specific item.
- Use `if __name__ == "__main__":` for code that should run only when a file is executed directly.
- Keep module names lowercase and use underscores when needed, such as `file_helpers.py`.
