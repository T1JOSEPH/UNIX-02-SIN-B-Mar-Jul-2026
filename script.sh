
The structure that we have in a linux command are, command, options and arguments
ls -a (Short command, if we want a fast typing (hacking NASA)) 
ls --all (Large command, the better use is when we reading scripts) 
In both cases are similar, the mean of each one is give me all the files
also the structure in both commands are, command and option.

ls -l -a -h (This command help us wehn we know all the files with every information of each one, it means, hidden files, dates and who is the propietarie.)
ls -l -ah (With this commmand we have the same information)
ls -lah (-lah is better when we want a fast typing (Hacking FBI))

mkdir -- -rf (We use -- because -r is a option that means strong remove, and helping us with --, linux thinks that the new of the directory is rf)
rmdir -- -rf (We use rmdir when we want remove sepcific file)


(In both commands re have the infoormstion about the command like ls)
ls --help (Here we have the resumize of the ls command)
man ls (When we use man, is the all the manual and how can we use, and the options next the command, it means all the information)

man git-clone (Clones a repository into a newly created directory, creates remote-tracking branches for
       each branch in the cloned repository (visible using git branch --remotes), and creates and
       checks out an initial branch that is forked from the cloned repository’s currently active
       branch.

       After the clone, a plain git fetch without arguments will update all the remote-tracking
       branches, and a git pull without arguments will in addition merge the remote master branch
       into the current master branch, if any (this is untrue when "--single-branch" is given;
       see below).)


chmod +x script.sh (All the people can execute the script)
chmod u+x script.sh (U = users and x = execute, said, only users can execute the script)
chmod o-r script.sh (O= others and - =less and r = read, it means others cannot read the script)
chmod u+rw,go-rwx script.sh (u = users + = can  r = read w = write, go = group and others - = less r =read w = write and x =execure)
it means Users can read and write the script, in the other hand, group and others cannot read, write and execute the script.

sudo echo "hola" > /etc/archivo_protegido (Here we have a problem like, the frist commmand part has sudo, it means, all the athorized permissions , in the other hand, the other command after > doesnt have permissions)
echo "hola" | sudo tee /etc/archivo_protegido > /dev/null (This command its netter than use  the redirection >, because we can executre this command with a pipeline and the sudo must be for all the command, however/dev/null, dont let see the content)
cat /etc/archivo_protegido(We can use cat to see the file content)
echo "hola" | sudo tee /etc/archivo_protegido (We have the same, however /dev/null are eliminated, and the command give the content wehn we executre it)

sudo sh -c 'echo "chao" >> /etc/archivo_protegido' (This command is execute as root and sh open a new shell and -c give more information it means "add" information)
cat /etc/archivo_protegido (The content in archivo_protegido are hola and chao)
sudo su - (Sudo su - give us the user root)

echo "$HOME" (We can use this code if we want a new enviroment in codespaces)
echo '$HOME' (We can create a string with  '')
 
boot-exploration (27-04-2026)
umask --> 0022 #When yo create a file/directory you can subtract permission 725 - 705 --> 020
touch archivo1 #Try to touch the file if the file dosent exist crete this file
mkdir directorio1 #Create a directory
ls-l #List of the files and directorys in long format
#Search the problem un the browser and you can find the solution for this problem
https://github.com/orgs/community/discussions/26026 
sudo apt-get update
sudo apt-get upgrade #Missing step
sudo apt-get install acl
sudo chown -R $(whoami) .
sudo setfacl -bnR .

umask 077 #Change the permission with umask 
touch secreto.txt #Create a new file but when you crete the file this are created with the 077 permission 677-077 = 700
mkdir privado #Same as the last one 777-077 = 700
ls -l #List all the files 
-rw------- 1 codespace codespace     0 Apr 27 12:59 secreto.txt
drwx------ 2 codespace codespace  4096 Apr 27 12:59 privado

chown #Change the owner. Usually only the root can change it
chgrp #Change group 

whoami
echo "Hola" > mi_archivo #Create a file with the text/message "Hola"
ls -l mi_archivo #List only this file in long format

sudo useradd -m -s /usr/bin/zsh luna #Add new user with a home directory and define the shell lune is about to use
sudo chown luna mi_archivo #Change the user luna instead of Codespaces
ls -l mi_archivo

groups #See the groups 
newgrp grupo_test #Crete a new group called grupo_test 
groupadd grupo_test #Add the group
groups #See all the groups again
touch comun #Create a file called comun
ls -l comun #List the file


sudo chown luna:grupo_test mi_archivo #Change the owner to luna and in the group create a file mi_archivo
ls -l mi_archivo #list the file
-rw-r--r-- 1 luna grupo_test 5 Apr 27 13:12 mi_archivo
#Use this if the command needs a passwrod
sudo usermod -aG grupo_test $USER
#Estructure
chown usuario:grupo fichero

mkdir -p proyecto/sub #Create a directory in proyecto and other folder in sub
touch proyecto/readme proyecto/sub/datos #Use touch to create a readme in proyecto and other in /sub/datos
sudo chown -R luna:grupo_test proyecto #Change the user in recursive to luna for the new grpuo grupo_test in proyecto
ls -lR proyecto #Use ls to see the list with a long format with Recursive reading