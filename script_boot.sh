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
stat .
mkdir -p /tmp/prueba/sub1/tmp/prueba/sub2 #create multiple folders within /tmp/test, including intermediate ones if they do not exist.
stat /tmp/prueba #displays detailed directory information /tmp/test to verify that it was created correctly.
man mkdir #muestra el manual del comando mkdir, con su uso, opciones y descripción.
ls #shows the files and folders in the current directory.
ls -l ##shows a detailed list 
ls -lh #same as -l, but with human-readable sizes (KB, MB).
ls -lt #sorts files by modification date
pwd #shows the path of the current directory.
ls /
#result
bin                dev  home               lib32  mnt   root  sbin.usr-is-merged  tmp  vscode
bin.usr-is-merged  etc  lib                lib64  opt   run   srv                 usr  workspaces
boot               go   lib.usr-is-merged  media  proc  sbin  sys                 var
ls /etc | head -20 #lists the files in the /etc folder and displays only the first 20 results.
ls /dev | head -20 #lists the files in the /dev folder and displays only the first 20 results.
ls -la #shows all files (including hidden ones)
sudo apt update #update the list of available packages.
sudo apt upgrade #install updates for already installed packages.
sudo apt install -y git vim make gcc libncurses-dev flex bison bc cpio libelf-dev libssl-dev syslinux dosfstools qemu-system-x86
#install several necessary tools
git clone --depth 1 https://github.com/torvalds/linux.git #downloads the Linux kernel source code quickly
cd linux #enters the downloaded project folder.
make menuconfig #opens an interactive menu to configure the kernel before building it.