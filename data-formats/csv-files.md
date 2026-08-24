# CSV Files

## Core Idea

CSV stands for **Comma-Separated Values**.

A CSV file stores tabular data as plain text. Each line usually represents one row, and commas usually separate the values in each row.

## Example CSV File

```csv
name,email,city
Kimberly,kimberly@example.com,Peoria
Jordan,jordan@example.com,Chicago
```

## How to Read It

| CSV concept | Example |
|---|---|
| File extension | `.csv` |
| First row | Often contains column headers |
| Each later row | Usually represents one record |
| Comma | Separates values into columns |
| Newline | Separates records into rows |

The example has:

- Columns: `name`, `email`, `city`
- Two data records
- Three fields per record

## Why CSV Is Useful

CSV files are commonly used because they are:

- Plain text and easy to inspect
- Easy to create and share
- Supported by spreadsheets, databases, and programming languages
- Useful for exporting and importing structured data
- Smaller and simpler than many spreadsheet formats

## CSV Is Not Always Simple

A comma inside a value must be handled correctly.

```csv
name,address
Kimberly,"123 Main Street, Peoria, IL"
```

The address is wrapped in quotes because it contains commas.

> Do not parse real CSV files with `line.split(",")`. Use Python's built-in `csv` module, which correctly handles quoted commas, line breaks, and other CSV rules.

## Python Quick Start

Read CSV rows:

```py
import csv

with open("people.csv", newline="", encoding="utf-8") as file:
    reader = csv.reader(file)

    for row in reader:
        print(row)
```

Example output:

```py
["name", "email", "city"]
["Kimberly", "kimberly@example.com", "Peoria"]
["Jordan", "jordan@example.com", "Chicago"]
```

## What to Remember

- CSV means Comma-Separated Values.
- CSV stores table-like data in plain text.
- A row is usually one line.
- A field is one value inside a row.
- The first row often contains headers.
- Use Python's `csv` module instead of splitting lines manually.
- Quotes allow a field to contain commas.

<!-- Improvement idea: Add course-specific CSV examples and separate notes for csv.reader, csv.DictReader, csv.writer, and csv.DictWriter after their lessons appear. Add a small practice dataset related to recipes, nutrition, or delivery tracking. -->

## CSV Dialects and Formatting

A CSV dialect is a set of rules that describes how fields in a delimited file are formatted.

The default CSV dialect uses:

- A comma as the field delimiter
- Double quotes around fields that need quoting
- Non-strict parsing by default

## Delimiters

A delimiter separates fields in a row.

### Comma-separated values

```csv
name,department,salary
Aisha Khan,Engineering,80000
```

```py
import csv

with open("employees.csv", newline="", encoding="utf-8") as file:
    reader = csv.reader(file)

    for row in reader:
        print(row)
```

### Tab-separated values

Some files use tabs instead of commas.

```text
name	department	salary
Aisha Khan	Engineering	80000
```

```py
import csv

with open("employees.tsv", newline="", encoding="utf-8") as file:
    reader = csv.reader(file, delimiter="\t")

    for row in reader:
        print(row)
```

### Semicolon-separated values

```csv
name;department;salary
Aisha Khan;Engineering;80000
```

```py
import csv

with open("employees.csv", newline="", encoding="utf-8") as file:
    reader = csv.reader(file, delimiter=";")

    for row in reader:
        print(row)
```

## Quote Characters

CSV uses a quote character to wrap a field that contains special characters, such as a comma.

```csv
name,address
Kimberly,"123 Main Street, Peoria, IL"
```

By default, Python's `csv` module uses a double quote (`"`) as its quote character.

```py
reader = csv.reader(file, quotechar='"')
```

Usually, you do not need to specify `quotechar` because the default already uses double quotes.

## Strict Parsing

By default, CSV parsing is not strict:

```py
reader = csv.reader(file, strict=False)
```

To raise `csv.Error` when malformed CSV data is detected:

```py
reader = csv.reader(file, strict=True)
```

Use strict parsing when bad CSV formatting should stop the program instead of being handled loosely.

## Get One Row with `next()`

A CSV reader is an iterator, so `next(reader)` returns the next parsed row.

```py
import csv

with open("employees.csv", newline="", encoding="utf-8") as file:
    reader = csv.reader(file)

    header = next(reader)
    print(header)

    first_employee = next(reader)
    print(first_employee)
```

Example output:

```py
["name", "department", "salary"]
["Aisha Khan", "Engineering", "80000"]
```

> `next(reader)` raises `StopIteration` when no rows remain. Use it only when you expect a row to exist or provide a default value.

```py
header = next(reader, None)

if header is None:
    print("The CSV file is empty.")
```

## Useful References

- [Python documentation: `csv`](https://docs.python.org/3/library/csv.html)
- [Real Python: Reading and Writing CSV Files](https://realpython.com/python-csv/)

## What to Remember

- A dialect defines the CSV file's formatting rules.
- `delimiter` is the one-character field separator; it defaults to `,`.
- `quotechar` wraps values containing special characters; it defaults to `"`.
- Use `delimiter="\t"` for tab-separated data.
- Use `next(reader)` to get one parsed row at a time.
- `strict=True` raises `csv.Error` for malformed CSV input.

<!-- Improvement idea: Add a practice file for comma-, tab-, and semicolon-delimited data; then write one parser that selects the delimiter through a command-line argument. -->

## Course Source

- [Coursera: What is a CSV file?](https://www.coursera.org/learn/python-operating-system/lecture/7BWU9/what-is-a-csv-file)
