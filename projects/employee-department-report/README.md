# Employee Department Report

## Goal

Read employee records from a CSV file, count how many employees belong to each department, and write the results to a text report.

## Skills Practiced

- Linux navigation: `cd`, `ls`, and `cat`
- Creating and editing Python files with `nano`
- Shebangs and executable Python scripts
- File permissions with `chmod +x`
- Reading CSV data with `csv.DictReader`
- Registering a CSV dialect
- Building a list of dictionaries
- Extracting values from dictionaries
- Counting repeated values
- Writing a sorted text report
- Running a script with `./generate_report.py`

## Command Workflow

```bash
cd data
ls
cat employees.csv

cd ~/scripts
nano generate_report.py

chmod +x generate_report.py
./generate_report.py

cd ~/data
ls
cat report.txt
```

## Expected Input

Example `employees.csv`:

```csv
Full Name,Username,Department
Audrey Miller,audrey,Development
Arden Garcia,ardeng,Sales
Bailey Thomas,baileyt,Human Resources
Charlie Grey,greyc,Development
```

## Expected Output

Example `report.txt`:

```text
Development:2
Human Resources:1
Sales:1
```

## Project Flow

```text
employees.csv
      |
      v
read_employees()
      |
      v
list of employee dictionaries
      |
      v
process_data()
      |
      v
department-count dictionary
      |
      v
write_report()
      |
      v
report.txt
```

<!-- Improvement idea: Add automated tests with pytest, command-line arguments using argparse, UTF-8 encoding, error handling, and pathlib after completing the basic version. -->
