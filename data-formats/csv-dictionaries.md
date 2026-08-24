# Reading and Writing CSV Files with Dictionaries

## Core Idea

Use `csv.DictReader` and `csv.DictWriter` when a CSV file has column headers.

They represent CSV rows as dictionaries, so you access values by names such as:

```py
row["name"]
```

instead of by position:

```py
row
```

This is easier to read and safer when a CSV file has many columns.

## Course CSV File

Terminal command:

```bash
cat software.csv
```

CSV content:

```csv
name,version,status,users
MailTree,5.34,production,324
CalDoor,1.25.1,beta,22
Chatty Chicken,0.34,alpha,4
```

> On Windows PowerShell, use this instead of `cat`:

```powershell
Get-Content software.csv
```

## Read CSV Data with `DictReader`

### Course Example

```py
import csv

with open("software.csv") as software:
    reader = csv.DictReader(software)

    for row in reader:
        print("{} has {} users".format(row["name"], row["users"]))
```

## What `DictReader` Produces

For this CSV row:

```csv
MailTree,5.34,production,324
```

`DictReader` produces a dictionary similar to:

```py
{
    "name": "MailTree",
    "version": "5.34",
    "status": "production",
    "users": "324",
}
```

This makes values easy to access:

```py
row["name"]
row["version"]
row["status"]
row["users"]
```

## Output

```text
MailTree has 324 users
CalDoor has 22 users
Chatty Chicken has 4 users
```

## Why `DictReader` Helps

| Standard `csv.reader` | `csv.DictReader` |
|---|---|
| Each row is a list | Each row is a dictionary |
| Access by position: `row[0]` | Access by name: `row["name"]` |
| Requires remembering column order | Uses header names |
| Better for small, fixed rows | Better for many columns or clear, maintainable code |

The CSV header row becomes the dictionary keys:

```csv
name,version,status,users
```

## Write CSV Data with `DictWriter`

### Course Example

```py
import csv

users = [
    {
        "name": "Sol Mansi",
        "username": "solm",
        "department": "IT infrastructure",
    },
    {
        "name": "Lio Nelson",
        "username": "lion",
        "department": "User Experience Research",
    },
    {
        "name": "Charlie Grey",
        "username": "greyc",
        "department": "Development",
    },
]

keys = ["name", "username", "department"]

with open("by_department.csv", "w") as by_department:
    writer = csv.DictWriter(by_department, fieldnames=keys)
    writer.writeheader()
    writer.writerows(users)
```

## Line-by-Line Explanation

```py
users = [...]
```

Creates a list of dictionaries.

- Each dictionary represents one CSV row.
- Dictionary keys represent CSV column names.
- Dictionary values become the data stored in each row.

```py
keys = ["name", "username", "department"]
```

Defines the column order for the generated CSV file.

```py
writer = csv.DictWriter(by_department, fieldnames=keys)
```

Creates a dictionary-based CSV writer.

`fieldnames=keys` tells Python which dictionary keys become columns and the order in which they should appear.

```py
writer.writeheader()
```

Writes the header row:

```csv
name,username,department
```

```py
writer.writerows(users)
```

Writes every dictionary in `users` as one row in the CSV file.

## Generated File

Terminal command:

```bash
cat by_department.csv
```

Expected contents:

```csv
name,username,department
Sol Mansi,solm,IT infrastructure
Lio Nelson,lion,User Experience Research
Charlie Grey,greyc,Development
```

On Windows PowerShell:

```powershell
Get-Content by_department.csv
```

## Recommended Modern Pattern

Use `newline=""` and `encoding="utf-8"` when opening CSV files:

```py
import csv

keys = ["name", "username", "department"]

with open(
    "by_department.csv",
    "w",
    newline="",
    encoding="utf-8",
) as by_department:
    writer = csv.DictWriter(by_department, fieldnames=keys)
    writer.writeheader()
    writer.writerows(users)
```

## Common Problems

| Problem | Likely cause | Fix |
|---|---|---|
| `KeyError` | A header name or dictionary key is spelled differently | Match the CSV headers and dictionary keys exactly |
| Missing CSV headers | `DictReader` needs a header row | Add headers or pass `fieldnames=` explicitly |
| Header order is wrong | `fieldnames` list is in the wrong order | Arrange `keys` in the desired column order |
| Extra blank lines in output | CSV file opened without `newline=""` | Use `newline=""` |
| Existing CSV content disappears | File opened with `"w"` | Use `"a"` only if appending is intended |
| Fields appear blank | Dictionary does not contain a required key | Verify every record has all expected keys |

## What to Remember

- `csv.DictReader` turns each CSV row into a dictionary.
- The CSV header row becomes the dictionary keys.
- `row["column_name"]` is clearer than `row[index]`.
- `csv.DictWriter` writes dictionaries to a CSV file.
- `fieldnames` defines the header names and column order.
- `writeheader()` writes the CSV header row.
- `writerows(list_of_dicts)` writes multiple records.
- Use `newline=""` and `encoding="utf-8"` for new CSV code.

<!-- Improvement idea: Add an example that converts the "users" field from a string to an integer with int(row["users"]), then filters software records by status. Add a real project example that exports recipe, nutrition, or delivery-income data to CSV. -->

## Course Source

- [Coursera: Reading and Writing CSV Files with Dictionaries](https://www.coursera.org/learn/python-operating-system/lecture/BY6Kn/reading-and-writing-csv-files-with-dictionaries)
