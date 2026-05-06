id // The id command is used to display the user id, main group id, and second group id in the terminal
cat /etc/passwd | head -10 // the cat command is used to display the contents into /etc/passwd file and pipeline give the head information
cat /etc/group | head -10 // When we use /etc/group file, it contains the group information of the system and the 10 firts lines are displayed
groups
groups $USER // the groups command is used to display which enviroment we are in and the $USER variable is used to display the current user
id -u // the id -u command is used to display the user id of the current user
id -g // the id -g command is usted to display the main group id of the current user
id -G // the id -G command is used to display the second group id
The result is 0 because the user is root.
cat /etc/group | grep codespace // It is used to search for the word codespace in the /etc/group file and display the line that contains information about the group codespace
cat /etc/gshadow // It is used to display the contents of the /etc/gshadow file, which contains the shadow password information
mkdir ~/proyecto_unix/ // the mkdir command is usted to create a new directory called proyecto_unix in the home
ls -la ~/proyecto_unix/ // the ls -la command is used to display all the information about the proyecto_unix

# groupadd [options] name_group
#Create a simple group
sudo groupadd desarrolladores
sudo groupadd -g 2000 operaciones #specific GID
#group system (GID < 1000)
sudo groupadd --system servicios servicios_web
#Verify files
grep "desarrolladores\|operaciones\|servicios_web" /etc/group
#See main options
groupadd --help
#see range GIDs in the system
grep "GID_MIN\|GID_MAX\|SYS_GID" /etc/login.defs
#Groups have GID<User
#In ubuntu
#SYS_GID_MIN =100
#SYS_GID_MAX = 999
#GID_MIN = 1000
#GID_MAX = 60 000

#addgroup [options] name_group
#create groups with addgroup
addgroup diseno
addgroup --gid 2100 marketing
addgroup --system cache_web
#verify
grep "diseno\|marketing\|cache_web" /etc/group