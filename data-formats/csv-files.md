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

## Course Source

- [Coursera: What is a CSV file?](https://www.coursera.org/learn/python-operating-system/lecture/7BWU9/what-is-a-csv-file)
