# Environment Variables

## Core idea

Environment variables are named values stored in the shell environment.

Programs can read them to change behavior without hardcoding values into the code.

This is useful for things like:

- Finding system paths
- Reading the current user's home directory
- Configuring scripts
- Passing settings into programs
- Keeping machine-specific values outside the source code

## What a shell is

A shell is a command-line interface used to interact with the operating system.

In this course, the shell being discussed is **bash**.

Other shells exist, such as:

- Zsh
- Fish

But the examples here are based on bash.

## See all environment variables

```bash
env
```

This prints the current environment variables available in the shell.

You can think of it as “show me the variables this shell knows about.”

## Print one environment variable

```bash
echo $PATH
```

### What it does

- `echo` prints text in the shell
- `$PATH` means “substitute the value of the environment variable named `PATH`”

### What `PATH` is for

`PATH` is one of the most important environment variables.

It stores a list of directories that the shell searches when you run a command without giving a full path.

Example:

```bash
python3
```

When you type that, the shell checks the directories in `PATH` in order until it finds an executable named `python3`.

Example `PATH` value:

```text
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
```

Those directories are separated by colons.

## Read environment variables in Python

```py
#!/usr/bin/env python3

import os

print("HOME: " + os.environ.get("HOME", ""))
print("SHELL: " + os.environ.get("SHELL", ""))
print("FRUIT: " + os.environ.get("FRUIT", ""))
```

## What this code does

### `import os`

```py
import os
```

This imports Python's `os` module, which gives access to operating system features.

That includes the process environment.

### `os.environ`

```py
os.environ
```

`os.environ` is a dictionary-like object containing the current environment variables.

You can access values in it by variable name.

## Two ways to access a variable

### Direct dictionary-style access

```py
os.environ["HOME"]
```

This works only if the variable exists.

If the key is missing, Python raises a `KeyError`.

### Safer access with `.get()`

```py
os.environ.get("HOME", "")
```

This tries to get the value for `"HOME"`.

If it does not exist, it returns the default value instead.

In this example, the default is:

```py
""
```

which is an empty string.

That is why the course uses `.get()` instead of direct indexing.

## What each line prints

```py
print("HOME: " + os.environ.get("HOME", ""))
```

Prints the value of the `HOME` environment variable, or an empty string if it does not exist.

```py
print("SHELL: " + os.environ.get("SHELL", ""))
```

Prints the shell path, if defined.

```py
print("FRUIT: " + os.environ.get("FRUIT", ""))
```

Prints the custom variable `FRUIT`, if it exists.

If `FRUIT` has not been defined yet, this prints just:

```text
FRUIT:
```

## Run the script

```bash
./variables.py
```

This runs the script directly from the shell.

For that to work, the file needs:

- A shebang line at the top
- Execute permission

The shebang used here is:

```py
#!/usr/bin/env python3
```

That tells the system to locate Python 3 and use it to run the script.

You could also run it with:

```bash
python3 variables.py
```

## Create a new environment variable

```bash
export FRUIT=Pineapple
```

## What it does

- `FRUIT=Pineapple` sets the value
- `export` makes that variable available to commands started from the current shell

After doing that, if you run the Python script again, it can read `FRUIT`.

## Important shell syntax rule

Do not put spaces around the equals sign.

Correct:

```bash
export FRUIT=Pineapple
```

Incorrect:

```bash
export FRUIT = Pineapple
```

The incorrect version does not assign the variable the way you want.

## Why `export` matters

Without `export`, a shell variable may exist only inside the shell itself.

With `export`, it becomes part of the environment passed to child processes, including Python scripts started from that shell.

That is why the script can see `FRUIT` only after it is exported. [page:81]

## Example workflow

### Step 1: Run the script before defining `FRUIT`

```bash
./variables.py
```

Possible output:

```text
HOME: /home/user
SHELL: /bin/bash
FRUIT:
```

### Step 2: Define and export the variable

```bash
export FRUIT=Pineapple
```

### Step 3: Run the script again

```bash
./variables.py
```

Possible output:

```text
HOME: /home/user
SHELL: /bin/bash
FRUIT: Pineapple
```

## Best way to remember this

### In the shell

```bash
echo $NAME
```

means:

> show me the value of an environment variable

### In Python

```py
os.environ.get("NAME", "")
```

means:

> get the value of an environment variable safely

## When to use environment variables

Use them when a value depends on the machine, user, or shell session instead of belonging in the source code.

Common examples:

- Home directories
- API keys
- Database URLs
- Debug settings
- Configuration flags
- Paths to tools

## Better Python patterns

### Simple safe read

```py
import os

home = os.environ.get("HOME", "")
```

### Required variable

```py
import os

api_key = os.environ.get("API_KEY")
if not api_key:
    raise RuntimeError("API_KEY is not set")
```

### Boolean-like flag

```py
import os

debug = os.environ.get("DEBUG", "").lower() in {"1", "true", "yes"}
```

## What to remember

- Environment variables are values stored in the shell environment.
- The shell passes exported environment variables to programs it launches.
- `PATH` tells the shell where to search for executables.
- `echo $PATH` prints a variable in bash.
- Python reads environment variables through `os.environ`.
- `os.environ.get("NAME", default)` is safer than `os.environ["NAME"]`.
- `export NAME=value` makes the variable visible to child processes.
