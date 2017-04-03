# Server Scripts Defaults
#
# Default settings for Server scripts
#
# @author    Connor Bär
# @copyright Copyright (c) 2017 Connor Bär
# @link      https://madebyconnor.co/
# @package   server-scripts
# @since     1.0.0
# @license   MIT

# -- LOCAL settings --

# Local path constants; paths should always have a trailing /
LOCAL_ROOT_PATH="/home/forge/"

# Local user & group that should own the Server install
LOCAL_CHOWN_USER="forge"
LOCAL_CHOWN_GROUP="forge"

# Local backups path; paths should always have a trailing /
LOCAL_BACKUPS_PATH="${LOCAL_ROOT_PATH}backups/"

# -- REMOTE settings --

# Remote ssh credentials, user@domain.com and Remote SSH Port
REMOTE_SSH_LOGIN="REPLACE_ME"
REMOTE_SSH_PORT="22"

# Remote path constants; paths should always have a trailing /
REMOTE_ROOT_PATH="REPLACE_ME"

# Remote backups path; paths should always have a trailing /
REMOTE_BACKUPS_PATH="${REMOTE_ROOT_PATH}backups/"

# Remote Amazon S3 bucket name
REMOTE_S3_BUCKET="REPLACE_ME"

# Remote Dropbox path; paths should always have a trailing /
REMOTE_DROPBOX_PATH="/Apps/Backups/"

# Remote Slack incoming webhook url
REMOTE_SLACK_HOOK="REPLACE_ME"
