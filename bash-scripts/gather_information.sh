
#!/bin/bash

### ps - print current running processes
uptime - how long the computer has been running
free - tells how much memory is free ###

echo "Starting at: ${date}"; echo

echo "UPTIME"; uptime; echo

echo "FREE"; free; echo

echo "WHO"; who; echo

echo "Finishing at: ${date}"
