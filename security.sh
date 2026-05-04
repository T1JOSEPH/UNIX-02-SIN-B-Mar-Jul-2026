id // The id command is used to display the user id, main group id, and second group id in the terminal
cat /etc/passwd | head -10 // the cat command is used to display the contents into /etc/passwd file and pipeline give the head information
cat /etc/group | head -10 // When we use /etc/group file, it contains the group information of the system and the 10 firts lines are displayed
groups
groups $USER // the groups command is used to display which enviroment we are in and the $USER variable is used to display the current user
id -u // the id -u command is used to display the user id of the current user
id -g // the id -g command is usted to display the main group id of the current user
id -G // the id -G command is used to display the second group id
The result is 0 because the user is root.

