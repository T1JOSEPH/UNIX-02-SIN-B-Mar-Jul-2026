ls -a #shows all files, including hidden ones
ls --all #same as -a
ls -a / #shows everything in the root /, including hidden files
ls -l -a -ah #detailed list, includes hidden files, human-readable sizes   
ls -l -ah #same, but may not include all hidden files explicitly (depends on -a)
ls -lah #same as combining all: detailed, hidden files, readable sizes
mkdir -- -rf #creates a folder named -rf
rm -- -rf #deletes file/folder named -rf
rmdir -- -rf #deletes folder -rf (empty)
ls --help #quick help
man ls #full manual
q #exit the manual
man git-clone #opens the full manual page for the git clone command
/--depth 
       #Clones a repository into a newly created directory, creates remote-tracking branches for each branch in the
       #forked from the cloned repository’s currently active branch.

       #After the clone, a plain git fetch without arguments will update all the remote-tracking branches, and a git
       #pull without arguments will in addition merge the remote master branch into the current master branch, if any
       #(this is untrue when "--single-branch" is given; see below).

       #This default configuration is achieved by creating references to the remote branch heads under
       #refs/remotes/origin and by initializing remote.origin.url and remote.origin.fetch configuration variables.
chmod #Change mode
chmod +x script2_boot.sh #gives execute permission to everyone
chmod u+x script2_boot.sh #gives execute permission only to the user (owner)
chmod o-r secreto.txt #removes read permission from others
chmod u+rw,go-rwx script2_boot.sh #user: read & write, group/others: no permissions
sudo sh -c 'echo "hola" > /etc/archivo_protegido' #It works because sudo runs the whole command as root, including the > redirection, so the file can be written without permission errors 
echo "hola" | sudo tee /etc/archivo_protegido >/dev/null #Writes as root and hides output
echo "hola" | sudo tee /etc/archivo_protegido  #Writes as root and prints "hola"
sudo cat /etc/archivo_protegido #Displays the protected file content
sudo sh -c 'echo "chao" >> /etc/archivo_protegido' #It works because sudo executes the entire command with root privileges, and the >> operator appends the text to the file instead of replacing what is already inside.
sudo cat /etc/archivo_protegido