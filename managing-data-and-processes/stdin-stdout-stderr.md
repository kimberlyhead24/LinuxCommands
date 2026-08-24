# stdin, stdout, and stderr

## Core idea

Programs communicate through **I/O streams**.

Think of a stream as a path that lets data flow between a program and some input source or output target.

Most operating systems provide three standard streams by default:

- `stdin` — standard input
- `stdout` — standard output
- `stderr` — standard error

These streams are not specific to Python. Terminal commands use them too.

## The three standard streams

| Stream | Meaning | Typical use |
|---|---|---|
| `stdin` | Input coming into a program | Keyboard input, piped input |
| `stdout` | Normal output produced by a program | Printed results, regular command output |
| `stderr` | Error messages and diagnostics | Exceptions, warnings, command errors |

## Python examples

### Read from standard input

```py
name = input("Name: ")
```

`input()` reads from `stdin`.

### Write to standard output

```py
print("Hello")
```

`print()` writes to `stdout`.

### Errors go to standard error

```py
data = input("This will come from STDIN: ")
print("Now we write it to STDOUT: " + data)
print("Now we generate an error to STDERR: " + data + 1)
```

The last line raises a `TypeError` because it tries to concatenate a string and an integer.

That error message is written to `stderr`.

## Example script

```py
#!/usr/bin/env python3

data = input("This will come from STDIN: ")
print("Now we write it to STDOUT: " + data)
print("Now we generate an error to STDERR: " + data + 1)
```

## Why `stdout` and `stderr` both look like the screen

In the terminal, both normal output and errors are often displayed on the screen.

They can look similar, but they are different streams.

That distinction matters because they can later be redirected separately.

## System command examples

### Normal output

```bash
cat file.txt
```

`cat` prints file contents to `stdout`.

### Error output

```bash
ls --not-a-real-flag
```

If `ls` gets an unsupported flag, the error message goes to `stderr`.

## Why this matters

Understanding the standard streams helps when you:

- Write scripts that accept user input
- Debug Python errors
- Use shell commands
- Redirect output to files
- Pipe output from one program to another
- Separate normal results from error messages

## Best-practice mindset

- Use `stdin` for incoming data.
- Use `stdout` for expected program output.
- Let real errors go to `stderr`.
- Do not think of terminal output as just “stuff printed on the screen.”
- Think in terms of separate channels for normal output and error output.

## Quick memory hooks

- `input()` -> `stdin`
- `print()` -> `stdout`
- Exceptions and tracebacks -> `stderr`

## Useful command-line examples

Save normal output to a file:

```bash
python3 script.py > output.txt
```

Save errors to a file:

```bash
python3 script.py 2> errors.txt
```

Save both:

```bash
python3 script.py > output.txt 2> errors.txt
```

## Better Python example

```py
#!/usr/bin/env python3

def main():
    text = input("Enter text: ")
    print(f"stdout: {text}")

if __name__ == "__main__":
    main()
```

This keeps the reusable logic cleaner than putting everything at the top level.
## Python 2 vs Python 3 Input

In Python 3, `input()` always returns a string.

```py
value = input("Enter something: ")
print(value)
print(type(value))
```

If the user types:

```text
123 + 1
```

the result is still a string:

```text
123 + 1
<class 'str'>
```

In Python 2:

- `raw_input()` returned a string
- `input()` roughly behaved like `eval(raw_input(...))`

In Python 3:

- `raw_input()` does not exist
- `input()` does **not** evaluate the user's text

## `eval()` warning

```py
eval(user_text)
```

`eval()` executes a string as Python code.

Do not use `eval()` on user input or untrusted text.

## What to remember

- Streams are how programs send and receive information.
- Operating systems usually provide `stdin`, `stdout`, and `stderr` automatically.
- Python uses them through `input()`, `print()`, and exception output.
- Terminal commands use the same idea.
- `stdout` and `stderr` may look similar on screen, but they serve different purposes.
