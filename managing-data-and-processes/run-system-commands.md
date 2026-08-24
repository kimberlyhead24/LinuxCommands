## Capture and Process Command Output

By default, a command run with `subprocess.run()` prints its output directly to the terminal.

```py
import subprocess

subprocess.run(["date"])
```

Use `capture_output=True` when Python needs to inspect, parse, save, or transform what the command prints.

```py
import subprocess

result = subprocess.run(
    ["host", "8.8.8.8"],
    capture_output=True,
)
```

## `CompletedProcess` Output Attributes

When output is captured, the returned `CompletedProcess` object includes:

| Attribute | Contains |
|---|---|
| `result.returncode` | Exit status: `0` for success, non-zero for failure |
| `result.stdout` | Captured standard output |
| `result.stderr` | Captured standard error |

```py
import subprocess

result = subprocess.run(
    ["host", "8.8.8.8"],
    capture_output=True,
)

print(result.returncode)
print(result.stdout)
print(result.stderr)
```

## Captured Output Is Bytes by Default

When you print `result.stdout`, it may look like this:

```py
b'8.8.8.8.in-addr.arpa domain name pointer dns.google.\n'
```

The leading `b` means the value is a `bytes` object, not a normal Python string.

Computers store and transmit data as bytes. Python does not automatically know which character encoding a command used for its output, so captured output is returned as bytes by default.

## Decode Bytes into Text

Use `.decode()` to convert bytes into a Python string.

```py
import subprocess

result = subprocess.run(
    ["host", "8.8.8.8"],
    capture_output=True,
)

output = result.stdout.decode()
print(output)
```

`.decode()` uses UTF-8 by default, which is the usual encoding for modern command output.

Be explicit when useful:

```py
output = result.stdout.decode("utf-8")
```

## Modern Shortcut: `text=True`

Instead of capturing bytes and then calling `.decode()`, prefer `text=True`.

```py
import subprocess

result = subprocess.run(
    ["host", "8.8.8.8"],
    capture_output=True,
    text=True,
)

print(result.stdout)
```

With `text=True`:

- `result.stdout` is a `str`
- `result.stderr` is a `str`
- You do not need `.decode()`

This is usually the clearest default when you expect text output.

## Process Command Output

```py
import subprocess

result = subprocess.run(
    ["host", "8.8.8.8"],
    capture_output=True,
    text=True,
)

if result.returncode == 0:
    parts = result.stdout.split()
    hostname = parts[-1]
    print(hostname)
else:
    print(result.stderr)
```

The course example splits command output into pieces and selects the last item, which is the hostname associated with the IP address.

Use `.strip()` when you only need to remove the trailing newline:

```py
output = result.stdout.strip()
```

## Capture Errors Separately

```py
import subprocess

result = subprocess.run(
    ["rm", "does_not_exist"],
    capture_output=True,
    text=True,
)

print("Return code:", result.returncode)
print("stdout:", result.stdout)
print("stderr:", result.stderr)
```

Expected behavior:

- `returncode` is non-zero
- `stdout` is empty
- `stderr` contains the error message

`stdout` and `stderr` are separate channels. Capturing output preserves that separation.

## Safe Reusable Pattern

```py
import subprocess

def run_command(command: list[str]) -> str | None:
    result = subprocess.run(
        command,
        capture_output=True,
        text=True,
    )

    if result.returncode != 0:
        print(f"Command failed: {' '.join(command)}")
        print(result.stderr.strip())
        return None

    return result.stdout.strip()
```

```py
output = run_command(["date"])

if output is not None:
    print(output)
```

## Better Failure Handling: `check=True`

Use `check=True` when command failure should stop the current operation.

```py
import subprocess

try:
    result = subprocess.run(
        ["host", "8.8.8.8"],
        capture_output=True,
        text=True,
        check=True,
    )
except subprocess.CalledProcessError as error:
    print(error.stderr)
else:
    print(result.stdout)
```

When `check=True` is used, Python raises `CalledProcessError` for a non-zero exit status.

## Use Cases

Capture command output when you need to:

- Build a report from `who` output
- Parse IP or hostname information
- Check disk, process, or network status
- Read output from an existing command-line tool
- Save a command result to a file or database
- Make a decision based on a command result

Example idea:

```py
result = subprocess.run(
    ["who"],
    capture_output=True,
    text=True,
)

logged_in_users = result.stdout.splitlines()
```

## What to Remember

- Add `capture_output=True` when Python needs command output.
- Captured data is stored separately in `.stdout` and `.stderr`.
- Captured output is `bytes` by default.
- Use `.decode("utf-8")` to convert bytes to text.
- Prefer `text=True` when you want text output immediately.
- Check `.returncode` before trusting command output.
- Use `.strip()`, `.split()`, or `.splitlines()` to process text output.
