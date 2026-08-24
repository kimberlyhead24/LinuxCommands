# Update Email Domains in a CSV

## Problem

Given a CSV containing names and email addresses:

```csv
Full Name,Email Address
Blossom Gill,blossom@abc.edu
Hayes Delgado,nonummy@utnisia.com
Petra Jones,ac@abc.edu
```

Replace only the old domain:

```text
abc.edu
```

with:

```text
xyz.edu
```

Then write the updated data to a new CSV file.

## Key Regex Idea

To match an email address that ends in a specific domain:

```py
r"[\w.-]+@abc\.edu$"
```

Pattern breakdown:

| Piece | Meaning |
|---|---|
| `[\w.-]+` | One or more username characters: word characters, periods, or hyphens |
| `@` | Literal at sign |
| `abc\.edu` | The literal domain `abc.edu` |
| `$` | End of the string |

Escape the period in `abc\.edu`; an unescaped `.` means “any character” in regex.

## Better Domain Checker

```py
import re

def contains_domain(address: str, domain: str) -> bool:
    """Return True when address ends with @domain."""
    escaped_domain = re.escape(domain)
    pattern = rf"[\w.-]+@{escaped_domain}"

    return re.fullmatch(pattern, address) is not None
```

```py
assert contains_domain("blossom@abc.edu", "abc.edu") is True
assert contains_domain("blossom@xyz.edu", "abc.edu") is False
assert contains_domain("blossom@abc.edu.fake", "abc.edu") is False
```

## Replace Only the Domain

Avoid replacing every occurrence of the old-domain text anywhere in the address. Anchor the replacement to the end of the address.

```py
import re

def replace_domain(address: str, old_domain: str, new_domain: str) -> str:
    """Replace old_domain only when it is the email's final domain."""
    old_domain_pattern = re.escape(old_domain) + r"$"

    return re.sub(old_domain_pattern, new_domain, address)
```

```py
assert replace_domain(
    "blossom@abc.edu",
    "abc.edu",
    "xyz.edu",
) == "blossom@xyz.edu"

assert replace_domain(
    "user@other.edu",
    "abc.edu",
    "xyz.edu",
) == "user@other.edu"
```

`re.escape()` matters whenever a regex pattern is built from variable text, because it prevents periods and other regex metacharacters in the domain from being interpreted as pattern syntax.

## Complete CSV Script

```py
from pathlib import Path
import csv
import re

OLD_DOMAIN = "abc.edu"
NEW_DOMAIN = "xyz.edu"

def replace_domain(address: str, old_domain: str, new_domain: str) -> str:
    pattern = re.escape(old_domain) + r"$"
    return re.sub(pattern, new_domain, address)

def update_email_domains(
    input_path: Path,
    output_path: Path,
    old_domain: str,
    new_domain: str,
) -> int:
    """Write updated rows and return the number of changed email addresses."""
    updated_count = 0

    with (
        input_path.open(newline="", encoding="utf-8") as source,
        output_path.open("w", newline="", encoding="utf-8") as destination,
    ):
        reader = csv.DictReader(source)
        writer = csv.DictWriter(destination, fieldnames=reader.fieldnames)

        writer.writeheader()

        for row in reader:
            original_email = row["Email Address"]
            updated_email = replace_domain(
                original_email,
                old_domain,
                new_domain,
            )

            if updated_email != original_email:
                updated_count += 1

            row["Email Address"] = updated_email
            writer.writerow(row)

    return updated_count

changed = update_email_domains(
    Path("data/user_emails.csv"),
    Path("data/updated_user_emails.csv"),
    OLD_DOMAIN,
    NEW_DOMAIN,
)

print(f"Updated {changed} email address(es).")
```

## Why This Is Better

| Course approach | Safer reusable approach |
|---|---|
| Builds the regex from `domain` directly | Uses `re.escape(domain)` |
| Uses `re.match()` with `$` | Uses `re.fullmatch()` when validating |
| Focuses on making the edit work | Counts changes and preserves CSV headers |
| Uses broad file permissions with `chmod 777` | Does not modify permissions unnecessarily |
| Does not show encoding/newline handling | Uses `encoding="utf-8"` and `newline=""` |

## Important Security Note

Do **not** use this lab command in real work unless there is a specific reason:

```bash
sudo chmod 777 script.py
```

It makes the script readable, writable, and executable by every user. Usually, run a Python script with:

```bash
python3 script.py
```

If execution permission is actually needed, a safer choice is usually:

```bash
chmod u+x script.py
```

The lab’s main added value is connecting regex to a realistic file-automation workflow: find the legacy `abc.edu` domain, update it to `xyz.edu`, and save the changed CSV as a separate report. [page:74]
