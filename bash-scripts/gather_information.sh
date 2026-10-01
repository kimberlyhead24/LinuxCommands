
#!/bin/bash

### ps - print current running processes
uptime - how long the computer has been running
free - tells how much memory is free ###
line="-----------------------------"
echo "Starting at: ${date}"; echo $line

echo "UPTIME"; uptime; echo $line

echo "FREE"; free; echo $line

echo "WHO"; who; echo $line

echo "Finishing at: ${date}"
