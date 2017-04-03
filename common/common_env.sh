#!/bin/bash

# Common Env
#
# Shared script to set various environment-related variables
#
# @author    Connor Bär
# @copyright Copyright (c) 2017 Connor Bär
# @link      https://madebyconnor.co/
# @package   server-scripts
# @since     1.0.0
# @license   MIT

# Commands to output database dumps, using gunzip -c instead of zcat for MacOS X compatibility
DB_ZCAT_CMD="gunzip -c"
DB_CAT_CMD="cat"

# For nicer user messages
PLURAL_CHAR="s"
