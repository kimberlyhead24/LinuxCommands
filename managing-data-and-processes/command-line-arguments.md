# Command-Line Arguments and Exit Status

## Core idea

Command-line arguments let you pass values to a program **when it starts**.

This is useful because the script can stay generic while still receiving different inputs each time it runs.

That makes command-line arguments better than interactive `input()` for many automation tasks.

## Why command-line arguments matter

They let you:

- Run scripts non-interactively
- Reuse the same script with different inputs
- Automate tasks in shell scripts and cron jobs
- Pass filenames, flags, or settings into a program
- Avoid waiting for keyboard input

## Access command-line arguments in Python

```py
#!/usr/bin/env python3
import sys

print(sys.argv)
```

## What `sys.argv` is

`sys.argv` is a list containing the command-line arguments passed to the script.

| Index | Meaning |
|---|---|
| `sys.argv[0]` | The script name or path used to launch the script |
| `sys.argv[1]` | The first real argument |
| `sys.argv[2]` | The second real argument |
| ... | More arguments if provided |

## Example: no extra arguments

```bash
./parameters.py
```

Output:

```py
['./parameters.py']
```

The list contains only the script path because no other arguments were passed. [page:83]

## Example: with arguments

```bash
./parameters.py one two three
```

Output:

```py
['./parameters.py', 'one', 'two', 'three']
```

Each argument becomes a separate string in the list. [page:83]

## Important thing to remember

All command-line arguments arrive as strings.

So if you pass a number:

```bash
./script.py 42
```

then in Python:

```py
sys.argv
```

is:

```py
"42"
```

not the integer `42`.

Convert it if needed:

```py
value = int(sys.argv)
```

## Better example

```py
#!/usr/bin/env python3
import sys

def main():
    print("Script name:", sys.argv)
    print("Arguments:", sys.argv[1:])

if __name__ == "__main__":
    main()
```

This is cleaner than putting all logic at the top level.

## Common argument pattern

```py
#!/usr/bin/env python3
import sys

def main():
    if len(sys.argv) < 2:
        print("Usage: ./script.py <name>")
        return

    name = sys.argv
    print(f"Hello, {name}")

if __name__ == "__main__":
    main()
```

This checks whether the expected argument was provided.

## Why this is better than `input()`

`input()` waits for the user after the program starts.

Command-line arguments provide the data up front.

That makes command-line arguments much better for:

- Automation
- Shell scripts
- Repeated system tasks
- Running the same program on many files

The video explicitly says they are especially useful for system administration because they let a script receive needed information before the program even starts. [page:83]

## Exit status

An exit status, also called a return code, is the value a program gives back to the shell when it finishes.

In Unix-like systems:

- `0` means success
- Non-zero means failure

The transcript states that Unix-like systems use zero for success and a non-zero value for failure, with the exact number giving additional information about the error. [page:83]

## Check the exit status in the shell

Use:

```bash
echo $?
```

`$?` is a special shell variable containing the exit status of the most recently executed command. [page:83]

## Example: successful command

```bash
wc variables.py
echo $?
```

If `wc` runs successfully, the exit code is:

```text
0
```

The video uses `wc` as the example of a successful command that returns exit status `0`. [page:83]

## Example: failing command

```bash
wc does_not_exist.py
echo $?
```

Because the file does not exist, `wc` prints an error and the exit code becomes non-zero; the transcript example shows it becoming `1`. [page:83]

## Python and exit status

A Python script normally exits with `0` when it finishes successfully.

If it crashes with an unhandled error, such as `TypeError` or `ValueError`, it exits with a non-zero status. [page:83]

You can also choose the exit code yourself.

## Exit with a specific status

```py
#!/usr/bin/env python3
import sys

print("Something went wrong")
sys.exit(1)
```

### What it does

- `sys.exit(1)` stops the program
- `1` tells the shell the program failed

Success example:

```py
sys.exit(0)
```

## Practical file example

```py
#!/usr/bin/env python3
import os
import sys

def main():
    if len(sys.argv) < 2:
        print("Usage: ./create_file.py <filename>")
        sys.exit(1)

    filename = sys.argv

    if os.path.exists(filename):
        print("Error: file already exists")
        sys.exit(1)

    with open(filename, "w", encoding="utf-8") as file:
        file.write("Created by script\n")

if __name__ == "__main__":
    main()
```

## What this script does

- Reads a filename from the command line
- Checks whether the file already exists
- Creates the file if it does not exist
- Exits with `1` if the file already exists
- Exits with `0` automatically if everything succeeds

The transcript describes this exact workflow: create the file when it does not exist, print an error and exit with `1` when it already exists, and otherwise finish successfully with the default exit code `0`. [page:83]

## Shell workflow example

### First run

```bash
./create_file.py newfile.txt
echo $?
```

Expected result:

- File gets created
- Exit status is `0`

### Second run

```bash
./create_file.py newfile.txt
echo $?
```

Expected result:

- Error message appears
- Exit status is `1`

## Best-practice mindset

- Use command-line arguments for automation-friendly scripts
- Validate argument count before using `sys.argv[1]`
- Convert argument types explicitly when needed
- Use exit code `0` for success
- Use non-zero exit codes for failure
- Print useful error messages when something fails

## Better structure for scripts

```py
#!/usr/bin/env python3
import sys

def main():
    if len(sys.argv) != 2:
        print("Usage: ./script.py <value>")
        return 1

    value = sys.argv
    print(f"Received: {value}")
    return 0

if __name__ == "__main__":
    sys.exit(main())
```

This is a strong pattern because:

- `main()` contains the logic
- `main()` returns a status code
- `sys.exit(main())` sends that code back to the shell

## What to remember

- `sys.argv` holds command-line arguments
- `sys.argv[0]` is the script name/path
- The rest are user-provided arguments
- Arguments are strings
- `echo $?` shows the last exit status in the shell
- `0` means success
- Non-zero means failure
- `sys.exit(code)` lets Python control the returned exit status
- Command-line arguments and exit codes are essential for automation
