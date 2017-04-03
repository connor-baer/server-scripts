#!/bin/bash

# Sync Backups to Dropbox
#
# Sync local backups to a Dropbox Folder
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

BACKUP_FILE_NAME="backup-$(date '+%Y%m%d-%H%M%S').tar.gz"

# Make sure the local backup directory exists
if [[ ! -d "${LOCAL_BACKUPS_PATH}" ]] ; then
    echo "Backup directory "${LOCAL_BACKUPS_PATH}" is missing, aborting."
    exit 1
fi

# Archive and compress the backup directory
tar -zcf "${BACKUP_FILE_NAME}" "${LOCAL_BACKUPS_PATH}"

# Upload the compressed file to Dropbox
dbxcli put "${BACKUP_FILE_NAME}" "${REMOTE_DROPBOX_PATH}${BACKUP_FILE_NAME}"
rm -f "${BACKUP_FILE_NAME}"
echo "*** Synced backups to ${REMOTE_DROPBOX_PATH}"

# Normal exit
exit 0
