sudo apt update #Aquí lo que hago es actualizar la lista de paquetes del sistema.
sudo apt upgrade #Aquí hay un error: debería ser upgrade.
sudo apt install parted #Aquí estoy instalando parted, que es una herramienta para ver discos y/o las partciones
sudo parted -l && echo -e "\n---\n" && lsblk -f && echo -e "\n---\n" #Ejecuta varios comandos en cadena para analizar el disco, pero de forma ordenada.




#Estudio
parted -l
lsblk -f
mount | grep
&&
-e