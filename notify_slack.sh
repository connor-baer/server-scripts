#!/bin/bash

# Notify Slack
#
# Send notifications to Slack channel
#
# @author    Connor Bär
# @copyright Copyright (c) 2017 Connor Bär
# @link      https://madebyconnor.co/
# @package   server-scripts
# @since     1.0.0
# @license   MIT

# Get the directory of the currently executing script
DIR="$(dirname "${BASH_SOURCE[0]}")"

# Include files
INCLUDE_FILES=(
            "common/defaults.sh"
            ".env.sh"
            "common/common_env.sh"
            )
for INCLUDE_FILE in "${INCLUDE_FILES[@]}"
do
    if [ -f "${DIR}/${INCLUDE_FILE}" ]
    then
        source "${DIR}/${INCLUDE_FILE}"
    else
        echo 'File "${DIR}/${INCLUDE_FILE}" is missing, aborting.'
        exit 1
    fi
done

if [ -z "$1" ]
then
    echo "No message specified, aborting."
    exit 1
fi

# Post specified message to Slack channel
curl -X POST -H 'Content-type: application/json' --data '{"text":"'"${1}"'"}' ${REMOTE_SLACK_HOOK}

# Normal exit
exit 0
