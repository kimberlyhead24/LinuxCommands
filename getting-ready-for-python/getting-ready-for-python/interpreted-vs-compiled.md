# Interpreted vs. Compiled Languages

## Core Idea

Programming languages need a way to turn human-written source code into instructions a computer can execute.

## Interpreted Languages

An interpreter reads and executes code at runtime.

Python is commonly described as interpreted:

```bash
python3 script.py
```

Python source code is run through the Python interpreter, so Python must be installed before a `.py` file can run.

## Compiled Languages

A compiler converts source code into an executable program before it runs.

Example with C:

```bash
gcc program.c -o program
./program
```

The first command creates a program. The second command runs it.

## Quick Comparison

| Feature | Interpreted workflow | Compiled workflow |
|---|---|---|
| Main step | Run code through an interpreter | Build an executable first |
| Example | Python | C or C++ |
| Typical command | `python3 app.py` | `gcc app.c -o app` |
| Requirement to run | Interpreter installed | Compiled program available |

## Important Note

The difference is not always absolute. Modern languages may combine interpreters, bytecode, virtual machines, and just-in-time or ahead-of-time compilation.

## What to Remember

- Python needs a Python interpreter to run `.py` files.
- Compiled languages generally create a runnable program before execution.
- `python3 script.py` runs the interpreter and gives it a Python source file.
