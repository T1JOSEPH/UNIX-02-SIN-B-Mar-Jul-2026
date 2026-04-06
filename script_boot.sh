cd / #takes us to the root directory
cd /home/codespace #moves us to a specific path in the system.
cd ~ #goes directly to the user’s home directory.
cd $HOME #does the same as cd ~, using a system variable that points to the home directory.
mkdir proyecto #created a new folder named “proyecto”.
cd proyecto/ #correctly entered the folder.
ls -lai #isted all files in the directory with detailed information
#result
1572927 drwxrwxrwx+ 2 codespace codespace 4096 Apr  6 12:34 .
1572874 drwxrwxrwx+ 4 codespace root      4096 Apr  6 12:34 .. #This result shows the information of the current directory and its parent directory after using ls -lai, including basic details such as permissions, owner and date, confirming that we are inside the created folder and viewing its contents
