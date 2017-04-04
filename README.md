# server-scripts
Shell scripts to manage and maintain Ubuntu servers

## Overview

There are several scripts included in `server-scripts`, each of which perform different functions. They all use a shared `.env.sh` to function. This `.env` should be created on each environment where you wish to run the `server-scripts`, and it should be excluded from your git repo via `.gitignore`.

### `backup_s3.sh`

The `backup_s3.sh` script syncs the backups from `LOCAL_BACKUPS_PATH` to the Amazon S3 bucket specified in `REMOTE_S3_BUCKET`.

This script assumes that you have already [installed awscli](http://docs.aws.amazon.com/cli/latest/userguide/installing.html) and have [configured it](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html) with your credentials.

It's recommended that you set up a separate user with access to only S3, and set up a private S3 bucket for your backups.

### `backup_dropbox.sh`

The `backup_dropbox.sh` script uploads a compressed archive of the backups from `LOCAL_BACKUPS_PATH` to the Dropbox folder specified in `REMOTE_DROPBOX_PATH`.

This script assumes that you have already [installed dbxcli](https://github.com/dropbox/dbxcli#installation) and have configured it with your credentials.

### `notify_slack.sh`

The `restore_db.sh` restores the local database to the database dumb passed in via command line argument. It backs up your local database before doing the restore.

You can pass in either a path to a `.sql` file or ` .gz` file to `restore_db.sh`, and it will do the right thing based on the file type.

### Setting it up

1. Download or clone the `server-scripts` git repo to your server.
2. Duplicate the `example.env` file, and rename it to `.env`.
3. Then open up the `.env` file into your favorite editor, and replace `REPLACE_ME` with the appropriate settings.
4. Optionally set up [automatic script execution](#automatic-script-execution).

All configuration is done in the `.env` file, rather than in the scripts themselves. This is is so that the same scripts can be used in multiple environments such as `local` dev, `staging`, and `live` production without modification. Just create a `.env` file in each environment, and keep it out of your git repo via `.gitignore`.

#### Local Settings

All settings that are prefaced with `LOCAL_` refer to the local environment where the script will be run, **not** your `local` dev environment.

`LOCAL_ROOT_PATH` is the absolute path to the root of your local server install, with a trailing `/` after it.

`LOCAL_CHOWN_USER` is the user that is the owner of your entire server install.

`LOCAL_CHOWN_GROUP` is your webserver's group, usually either `nginx` or `apache`.

`LOCAL_BACKUPS_PATH` is the absolute path to the directory where local backups should be stored. For database backups, a sub-directory `LOCAL_DB_NAME/db` will be created inside the `LOCAL_BACKUPS_PATH` directory to store the database backups. Paths should always have a trailing `/`

#### Remote Settings

All settings that are prefaced with `REMOTE_` refer to the remote environment where assets and the database will be pulled from.

`REMOTE_SSH_LOGIN` is your ssh login to the remote server, e.g.: `user@domain.com`

`REMOTE_SSH_PORT` is the port to use for ssh on the remote server. This is normally `22`

`REMOTE_ROOT_PATH` is the absolute path to the root of your server install on the remote server, with a trailing `/` after it.

`REMOTE_BACKUPS_PATH` is the absolute path to the directory where the remote backups are stored. For database backups, a sub-directory `REMOTE_DB_NAME/db` inside the `REMOTE_BACKUPS_PATH` directory is used for the database backups. Paths should always have a trailing `/`

`REMOTE_S3_BUCKET` is the name of the Amazon S3 bucket to backup to via the `backup_s3.sh` script

`REMOTE_DROPBOX_PATH` is the path of the Dropbox folder to backup to via the `backup_dropbox.sh` script

`REMOTE_SLACK_HOOK` is the incoming webhook url to post notifications to Slack via the `notify_slack.sh` script

### Setting up SSH Keys

Normally when you `ssh` into a remote server (as some of the `server-scripts` do), you have to enter your password. Best practices from a security POV is to not allow for password-based logins, but instead use [SSH Keys](https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys--2).

The day in, day out benefit of setting up SSH Keys is that you never have to enter your password again, so it allows for automated execution of the various `server-scripts`. Use the excellent [How To Set Up SSH Keys](https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys--2) artice as a guide for setting up your SSH keys.

### Permissions and Git

If you use `git`, a sample `.gitignore` file that you can modify & use for your server projects is included in `server-scripts` as `example.gitignore`. If you wish to use it, the file should be copied to your server project root, and renamed `.gitignore`

If you change file permissions on your remote server, you may encounter git complaining about `overwriting existing local changes` when you try to deploy. This is because git considers changing the executable flag to be a change in the file, so it thinks you changed the files on your server (and the changes are not checked into your git repo).

To fix this, we just need to tell git to ignore permission changes on the server. You can change the `fileMode` setting for `git` on your server, telling it to ignore permission changes of the files on the server:

    git config --global core.fileMode false

See the [git-config man page](https://git-scm.com/docs/git-config#git-config-corefileMode) for details.

### Automatic Script Execution

If you want to run any of these scripts automatically at a set schedule, here's how to do it. We'll use the `backup_dropbox.sh` script as an example, but the same applies to any of the scripts.

Please see the **Setting up SSH Keys** section and set up your SSH keys before you set up automatic script execution.

#### On Linux

If you're using [Forge](https://forge.laravel.com/) you can set the `backup_dropbox.sh` script to run nightly (or whatever interval you want) via the Scheduler. If you're using [ServerPilot.io](https://serverpilot.io/community/articles/how-to-use-cron-to-schedule-scripts.html) or are managing the server yourself, just set the `backup_dropbox.sh` script to run via `cron` at whatever interval you desire.

🐼 [Made by Connor](https://madebyconnor.co/)
