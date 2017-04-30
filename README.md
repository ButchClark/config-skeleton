# config_project
Configure a Beacon Skeleton project

# Instructions
In the project skeleton directory, run the command:

`./config_project.sh`

You will see a startup graphic.  Then type in responses to the prompts.
Once the parameters are collected, the script will rename files and
directories.  It will also substitute tag strings for the values you 
supplied.  This is done with a `sed` command with several `-e` 
substitution commands.

