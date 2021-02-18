#!/bin/bash

set -e

# Keep alive until user cancel the workflow
while true; do
    sleep 1
    if [ -e /tmp/cancel ]; then
        echo You have successfully requested the workflow to be canceled.
        exit 0
    fi
done