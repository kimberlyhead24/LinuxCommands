#!/bin/bash
if grep -q "127.0.0.1" /etc/hosts; then
    echo "Everything is OK: 127.0.0.1 is in /etc/hosts."
else
    echo "ERROR! 127.0.0.1 is not in /etc/hosts."
fi

if test -n "$PATH"; then 
    echo "Your path is not empty"; 
fi
if [ -n "$PATH" ]; then 
    echo "Your path is not empty"; 
    fi
  

