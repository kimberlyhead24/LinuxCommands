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

## Advanced `subprocess.run()` Options

`subprocess.run()` can control more than the command and its output.

Useful options include:

| Option | Purpose |
|---|---|
| `env=` | Give the child process a custom environment |
| `cwd=` | Run the command from a chosen working directory |
| `timeout=` | Stop a command that runs too long |
| `shell=True` | Run the command through a shell; use sparingly |

## Run a Command with a Modified Environment

A child process inherits the parent process's environment by default.

To change the environment for only one subprocess:

1. Copy the current environment
2. Modify the copy
3. Pass the copy using `env=`

```py
import os
import subprocess

my_env = os.environ.copy()

my_env["PATH"] = os.pathsep.join([
    "/opt/myapp",
    my_env.get("PATH", ""),
])

result = subprocess.run(
    ["myapp"],
    env=my_env,
)
```

### What this does

- `os.environ.copy()` makes a separate dictionary of the current environment variables.
- `my_env` can be changed without modifying Python's own environment.
- The code adds `/opt/myapp` at the beginning of `PATH`.
- `env=my_env` gives that modified environment only to the `myapp` subprocess.

`PATH` tells the operating system where to search for executable commands. Putting `/opt/myapp` first means an executable in that folder is found before an executable with the same name in a later directory.

## Why `os.pathsep` Matters

Do not hardcode `:` between `PATH` entries.

```py
os.pathsep
```

Returns:

| System | Path separator |
|---|---|
| Linux/macOS | `:` |
| Windows | `;` |

```py
os.pathsep.join(["/opt/myapp", old_path])
```

builds a valid `PATH` value for the current operating system.

## Run in a Specific Directory

Use `cwd=` to set the child process's current working directory.

```py
import subprocess

result = subprocess.run(
    ["git", "status"],
    cwd="/path/to/project",
    capture_output=True,
    text=True,
)
```

This runs `git status` as if you had first used:

```bash
cd /path/to/project
git status
```

Your Python script's own working directory does not change.

This is useful when the same command must run against several directories.

```py
from pathlib import Path
import subprocess

for project_dir in Path("/projects").iterdir():
    if project_dir.is_dir():
        subprocess.run(
            ["git", "status", "--short"],
            cwd=project_dir,
        )
```

## Stop Commands That Hang

Use `timeout=` to limit how long a command may run.

```py
import subprocess

try:
    result = subprocess.run(
        ["ping", "-c", "1", "example.com"],
        capture_output=True,
        text=True,
        timeout=10,
        check=True,
    )
except subprocess.TimeoutExpired:
    print("Command timed out")
except subprocess.CalledProcessError as error:
    print(error.stderr.strip())
else:
    print(result.stdout)
```

`timeout=10` means Python stops the command if it has not finished after 10 seconds.

Use a timeout for commands that could hang because of:

- Network failures
- Unresponsive services
- Locked resources
- Unexpected external-tool behavior

## `shell=True`

Normally, pass the command and arguments as a list:

```py
subprocess.run(["echo", "hello"])
```

This does not use a shell.

Use `shell=True` only when you specifically need shell features such as:

- Variable expansion: `$HOME`
- Globbing: `*.log`
- Pipes: `|`
- Redirection: `>`
- Shell operators: `&&`, `||`

```py
subprocess.run(
    "echo $HOME && ls *.log",
    shell=True,
)
```

Without `shell=True`, Python does not interpret `$HOME`, `*.log`, pipes, or redirection.

## Security Rule

Never combine `shell=True` with untrusted input.

Unsafe:

```py
subprocess.run(
    "ls " + user_input,
    shell=True,
)
```

A user could inject additional shell commands.

Safe default:

```py
subprocess.run(["ls", user_input])
```

Use a list and keep `shell=False` unless a known, controlled command genuinely requires shell behavior.

## Prefer Native Python for Long-Lived Automation

System commands can be convenient, but they make scripts depend on:

- A particular operating system
- An installed external command
- Command locations in `PATH`
- Command-line flags staying the same
- Command output format staying the same

Prefer Python's standard library when possible:

| Task | Prefer |
|---|---|
| Files and directories | `pathlib`, `shutil`, `os` |
| CSV data | `csv` |
| JSON data | `json` |
| HTTP requests | A Python HTTP library |
| Process execution | `subprocess` only when an external command is the right tool |

Use `subprocess` for quick, well-defined tasks or when the command-line tool is specifically required. For complex or long-running automation, a native Python library is usually more portable, testable, and maintainable.

## Safe Command Template

```py
import subprocess
from collections.abc import Sequence
from pathlib import Path

def run_command(
    command: Sequence[str],
    *,
    cwd: Path | None = None,
    timeout: float = 30,
) -> str:
    result = subprocess.run(
        command,
        cwd=cwd,
        capture_output=True,
        text=True,
        check=True,
        timeout=timeout,
    )
    return result.stdout.strip()
```

```py
try:
    output = run_command(["git", "status", "--short"], cwd=Path("/path/to/project"))
except subprocess.TimeoutExpired:
    print("Command took too long")
except subprocess.CalledProcessError as error:
    print(error.stderr.strip())
else:
    print(output)
```
## What to Remember

- Add `capture_output=True` when Python needs command output.
- Captured data is stored separately in `.stdout` and `.stderr`.
- Captured output is `bytes` by default.
- Use `.decode("utf-8")` to convert bytes to text.
- Prefer `text=True` when you want text output immediately.
- Check `.returncode` before trusting command output.
- Use `.strip()`, `.split()`, or `.splitlines()` to process text output.
