#!/usr/bin/env python3

import csv
from pathlib import Path


def read_employees(csv_file_location):
    """Return employee CSV rows as a list of dictionaries."""
    employees = []

    with open(csv_file_location, newline="", encoding="utf-8") as employee_file:
        reader = csv.DictReader(employee_file, skipinitialspace=True)

        for row in reader:
            employees.append(dict(row))

    return employees


def process_data(employee_list):
    """Return a dictionary of department names and employee counts."""
    department_counts = {}

    for employee in employee_list:
        department = employee["Department"]
        department_counts[department] = department_counts.get(department, 0) + 1

    return department_counts


def write_report(department_counts, report_file):
    """Write sorted department counts to a text report."""
    with open(report_file, "w", encoding="utf-8") as file:
        for department in sorted(department_counts):
            file.write(f"{department}:{department_counts[department]}\n")


def main():
    script_directory = Path(__file__).resolve().parent
    project_directory = script_directory.parent

    csv_file = project_directory / "data" / "employees.csv"
    report_file = project_directory / "data" / "report.txt"

    employees = read_employees(csv_file)
    department_counts = process_data(employees)
    write_report(department_counts, report_file)


if __name__ == "__main__":
    main()
