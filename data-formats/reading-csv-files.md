# Reading CSV Files

## Core Idea

Python's built-in `csv` module reads and parses CSV files.

A CSV reader turns each row in a CSV file into a list. Each field in that row becomes one item in the list.

## Course Example

```py
import csv

f = open("csv_file.txt")
csv_f = csv.reader(f)

for row in csv_f:
    name, phone, role = row
    print("Name: {}, Phone: {}, Role: {}".format(name, phone, role))

f.close()
```

## Example CSV Data

The code expects each row to contain exactly three comma-separated fields:

```csv
Sabrina Green,555-0123,Developer
Jordan Lee,555-0456,Support Specialist
```

## Line-by-Line Explanation

```py
import csv
```

Imports Python's built-in `csv` module.

```py
f = open("csv_file.txt")
```

Opens the CSV file in text read mode, which is the default mode.

```py
csv_f = csv.reader(f)
```

Creates a CSV reader object that parses each comma-separated row from the open file.

```py
for row in csv_f:
```

Loops through one CSV row at a time.

Each `row` is a list:

```py
["Sabrina Green", "555-0123", "Developer"]
```

```py
name, phone, role = row
```

Unpacks the three values in the row into descriptive variables:

```py
name = "Sabrina Green"
phone = "555-0123"
role = "Developer"
```

For unpacking to work, the number of variables on the left must match the number of fields in the CSV row.

```py
print("Name: {}, Phone: {}, Role: {}".format(name, phone, role))
```

Prints the values in a readable format.

Example output:

```text
Name: Sabrina Green, Phone: 555-0123, Role: Developer
Name: Jordan Lee, Phone: 555-0456, Role: Support Specialist
```

```py
f.close()
```

Closes the opened CSV file.

## Why Unpacking Helps

This works:

```py
print(row, row, row)[2][3]
```

But this is easier to understand:

```py
name, phone, role = row
print(name, phone, role)
```

Named variables make it clearer what each value represents.

## Common Error: Too Many or Too Few Values

This fails when a row does not contain exactly three fields:

```py
name, phone, role = row
```

For example:

```csv
Sabrina Green,555-0123
```

Raises a `ValueError` because the row has only two values.

A row with four values also raises an error:

```csv
Sabrina Green,555-0123,Developer,Full-time
```

## Safer Modern Pattern

Use `with open(...)` so Python closes the file automatically. Use `newline=""` when opening CSV files, as recommended by Python's CSV documentation.

```py
import csv

with open("csv_file.txt", newline="", encoding="utf-8") as file:
    csv_file = csv.reader(file)

    for row in csv_file:
        name, phone, role = row
        print(f"Name: {name}, Phone: {phone}, Role: {role}")
```

## When Field Counts Can Vary

If rows may contain a different number of fields, check the length before unpacking:

```py
import csv

with open("csv_file.csv", newline="", encoding="utf-8") as file:
    csv_file = csv.reader(file)

    for row in csv_file:
        if len(row) != 3:
            print(f"Skipped invalid row: {row}")
            continue

        name, phone, role = row
        print(f"Name: {name}, Phone: {phone}, Role: {role}")
```

## What to Remember

- Import `csv` to work with CSV data.
- `csv.reader(file)` creates an object that parses CSV rows.
- Each parsed row is a list of fields.
- `for row in csv_file:` processes one record at a time.
- `name, phone, role = row` unpacks a three-field row into named variables.
- The number of unpacked variables must match the number of fields.
- Prefer `with open(..., newline="", encoding="utf-8")` for new CSV code.

<!-- Improvement idea: Add a DictReader example after the next lessons so CSV columns can be accessed by header name, such as row["name"], instead of by position. Add a small practice CSV related to recipe ingredients or delivery data. -->

## Course Source

- [Coursera: Reading CSV Files](https://www.coursera.org/learn/python-operating-system/lecture/ULRBZ/reading-csv-files)
