#!/bin/bash
#
# Automatically downloads files from math website
# Uses wget, will be put into cron
# TARGET_DIR is where ever you are storing the files and whatnot
# replace file_list_name with whatever you want your hidden file to be (stores a list of the current files in the directory)
# need to download mail (might be the xmail package) and set that up to email yourself

readonly DIR_VAR=[TARGET_DIR]
cd $DIR_VAR
new_files=

# Remove previous .html files and Download new files
rm *.html
wget --no-directories --no-clobber --recursive [url]

# new_files is set to list of new files based on previous file list(stored in hidden file)
new_files=`ls -1 | grep --file=.[file_list_name] -v`
new_files=${new_files//"\n"/" "}	# Formatting line

# Test new_files for null value, send email if new files, update file list
[ -n new_files ] && echo "The files \"$new_files\" have been added to your math folder." |
mail -s "New math items" [email@address.com] && ls -1 >.[file_list_name]

# Automate with cron/anacron, and you're done.
