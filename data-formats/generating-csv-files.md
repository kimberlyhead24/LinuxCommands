# Generating CSV Files

## Core Idea

Python's built-in `csv` module can write structured tabular data to a CSV file.

Use:

- `csv.writer()` to create a writer object
- `writer.writerow(...)` to write one row
- `writer.writerows(...)` to write many rows

## Course Example

```py
import csv

hosts = [
    ["workstation.local", "192.168.25.46"],
    ["webserver.cloud", "10.2.5.6"],
]

with open("hosts.csv", "w") as hosts_csv:
    writer = csv.writer(hosts_csv)
    writer.writerows(hosts)
```

## Output File

The generated `hosts.csv` file contains:

```csv
workstation.local,192.168.25.46
webserver.cloud,10.2.5.6
```

## Line-by-Line Explanation

```py
import csv
```

Imports Python's built-in CSV module.

```py
hosts = [
    ["workstation.local", "192.168.25.46"],
    ["webserver.cloud", "10.2.5.6"],
]
```

Creates a **list of lists**:

- The outer list represents all rows.
- Each inner list represents one CSV row.
- Each value in an inner list becomes one CSV field.

```py
with open("hosts.csv", "w") as hosts_csv:
```

- Opens `hosts.csv` in write mode.
- Creates the file if it does not exist.
- Overwrites the file if it already exists.
- Closes the file automatically after the `with` block ends.

```py
writer = csv.writer(hosts_csv)
```

Creates a CSV writer object connected to the open file.

```py
writer.writerows(hosts)
```

Writes every inner list in `hosts` as a separate CSV row.

## `writerow()` vs. `writerows()`

| Method | Input | Use it when |
|---|---|---|
| `writer.writerow(row)` | One list or tuple | Writing one record at a time |
| `writer.writerows(rows)` | Iterable containing multiple rows | Writing many records at once |

### Write One Row

```py
writer.writerow(["database.local", "10.2.5.7"])
```

Output:

```csv
database.local,10.2.5.7
```

### Write Multiple Rows

```py
writer.writerows([
    ["database.local", "10.2.5.7"],
    ["cache.local", "10.2.5.8"],
])
```

## Recommended Modern Pattern

When creating CSV files, use `newline=""` and specify an encoding:

```py
import csv

hosts = [
    ["hostname", "ip_address"],
    ["workstation.local", "192.168.25.46"],
    ["webserver.cloud", "10.2.5.6"],
]

with open("hosts.csv", "w", newline="", encoding="utf-8") as hosts_csv:
    writer = csv.writer(hosts_csv)
    writer.writerows(hosts)
```

`newline=""` prevents extra blank lines that can occur on some systems when writing CSV files.

## Add Headers

A header row makes a CSV easier to understand in a spreadsheet or when reading it later.

```py
import csv

hosts = [
    ["hostname", "ip_address"],
    ["workstation.local", "192.168.25.46"],
    ["webserver.cloud", "10.2.5.6"],
]

with open("hosts.csv", "w", newline="", encoding="utf-8") as hosts_csv:
    writer = csv.writer(hosts_csv)
    writer.writerows(hosts)
```

Output:

```csv
hostname,ip_address
workstation.local,192.168.25.46
webserver.cloud,10.2.5.6
```

## Common Problems

| Problem | Likely cause | Fix |
|---|---|---|
| Old data disappears | File opened with `"w"` | Use `"a"` only if appending is intentional |
| Extra blank lines in CSV output | File was opened without `newline=""` | Use `open(..., newline="", encoding="utf-8")` |
| Each character appears in its own CSV column | Passed a string to `writerow()` instead of a list | Use `writer.writerow(["value"])` |
| Rows are not formatted correctly | Used normal `write()` instead of `csv.writer()` | Use the `csv` module |
| File cannot be opened in a spreadsheet | Incorrect extension or malformed rows | Use `.csv` and write rows with `csv.writer()` |

## What to Remember

- `csv.writer(file)` creates a CSV writer object.
- A list of lists is a common way to represent CSV data.
- Each inner list becomes one row in the CSV file.
- `writerow()` writes one row.
- `writerows()` writes multiple rows.
- `"w"` overwrites an existing CSV file.
- Use `newline=""` and `encoding="utf-8"` in new CSV-writing code.

<!-- Improvement idea: Add a csv.DictWriter note next, showing how named dictionary keys can produce header-based CSV files. Add a practical dataset such as recipe ingredients, nutrition data, or delivery-income records. -->

## Course Source

- [Coursera: Generating CSV](https://www.coursera.org/learn/python-operating-system/lecture/qO3kB/generating-csv)
