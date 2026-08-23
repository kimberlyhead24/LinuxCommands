# Python Virtual Environments

## Core Idea

A virtual environment is an isolated Python environment for one project.

Each virtual environment has its own Python interpreter and installed packages, which helps prevent conflicts between projects.

## Why Use Virtual Environments?

Use a virtual environment to:

- Avoid dependency conflicts between projects
- Test different package versions safely
- Keep the system Python installation cleaner
- Make project setup more consistent for other people

## Create a Virtual Environment

Create a virtual environment in the current project folder:

```bash
python -m venv myenv
```

This creates a folder named `myenv` that contains the virtual environment. [page:20]

## Activate the Environment

### Windows

```powershell
myenv\Scripts\activate
```

### macOS and Linux

```bash
myenv/bin/activate
```

After activation, the terminal prompt usually changes to show the environment name. [page:20]

## Install Packages

Once the environment is active, install packages normally with `pip`:

```bash
pip install package_name
```

Because the environment is active, the package installs into that project’s virtual environment instead of the global Python installation. [page:20]

## Save Dependencies

Create a `requirements.txt` file:

```bash
pip freeze > requirements.txt
```

Install dependencies from that file later:

```bash
pip install -r requirements.txt
```

This helps recreate the same environment on another machine or for another developer. [page:20]

## Deactivate the Environment

When finished, leave the virtual environment with:

```bash
deactivate
```

The page recommends activating the correct environment before working and deactivating it when done to reduce confusion and conflicts. [page:20]

## Best Practices

- Create one virtual environment per project. [page:20]
- Keep a `requirements.txt` file for package versions. [page:20]
- Activate the environment before installing packages. [page:20]
- Add setup instructions to version control so others can reproduce the environment. [page:20]
- Upgrade `pip` and `setuptools` after creating a new environment. [page:20]

## Useful Commands

### Upgrade packaging tools

```bash
python -m pip install --upgrade pip setuptools
```

The page recommends upgrading `pip` and `setuptools` in a new virtual environment so the tools are current. [page:20]

### Check installed packages

```bash
pip list
```

Shows packages installed inside the active environment.

## Example Workflow

```bash
mkdir my_project
cd my_project
python -m venv venv
```

Activate it:

### Windows

```powershell
venv\Scripts\activate
```

### macOS and Linux

```bash
source venv/bin/activate
```

Install a package:

```bash
pip install requests
```

Save dependencies:

```bash
pip freeze > requirements.txt
```

When done:

```bash
deactivate
```

## What to Remember

- A virtual environment isolates one project’s Python packages and interpreter. [page:20]
- Use one environment per project. [page:20]
- Create it with `python -m venv myenv`. [page:20]
- Activate it before installing packages. [page:20]
- Save dependencies with `pip freeze > requirements.txt`. [page:20]
