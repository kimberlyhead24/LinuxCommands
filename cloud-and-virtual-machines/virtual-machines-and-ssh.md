# Virtual Machines and SSH

## Core Idea

A virtual machine (VM) is a computer simulated by software.

A VM can run its own operating system and use allocated CPU, memory, storage, and network resources while sharing underlying physical hardware with other VMs.

## Why VMs Matter

Virtual machines are useful for:

- Testing software in a separate environment
- Running an operating system not installed on the local computer
- Practicing Linux commands safely
- Creating temporary development, testing, or server environments
- Reproducing a configured environment for a lab or team

## Cloud Virtual Machines

A cloud VM runs on remote hardware in a data center and is accessed over the internet.

Cloud platforms can create VMs on demand, configure them for a task, and delete them when they are no longer needed.

## SSH

SSH stands for Secure Shell.

It is a command-line protocol used to securely connect to and control a remote computer, often a Linux server or cloud VM.

```bash
ssh username@server-address
```

## What to Remember

- A VM is a software-based computer.
- Cloud VMs run remotely in data centers.
- VMs can be created and deleted as needed.
- SSH lets you use a remote Linux machine through a terminal.
- Temporary lab environments are useful because they let you practice without changing your own computer.

<!-- Improvement idea: Add practical SSH key setup, host aliases, and VS Code Remote - SSH notes after using a real cloud VM or Linux server. -->
