sudo apt update # Here I update the system's package list.
sudo apt upgrade # This command upgrades all installed packages to their latest versions.
sudo apt install parted #Aquí estoy instalando part# Here I install parted, which is a tool used to manage disks and partitions.
sudo parted -l && echo -e "\n---\n" && lsblk -f && echo -e "\n---\n" #Executes multiple commands in sequence to analyze the disk in an organized way.
[ -d /sys/firmware/efi ] && echo "UEFI" || echo "BIOS" #This checks if the system is using UEFI or BIOS
echo "esto es un archivo" > archivo.txt #Creates a file named archivo.txt and writes the text "esto es un archivo" into it, overwriting the file if it already exists.
stat archivo.txt #Displays detailed information about the file, such as its size, permissions, and timestamps.

#Estudio
parted -l
lsblk -f
mount | grep
&&
-e