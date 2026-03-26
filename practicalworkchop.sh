uname -a    #Muestra información del sistema (kernel, arquitectura, etc.)
which gpg   #Indica la ruta donde está instalado gpg
gpg --version       #Muestra la versión de GPG y sus características
gpg --full-generate-key     #Crea un nuevo par de claves (pública y privada)
gpg --list-keys     #Lista las claves públicas almacenadas
gpg --armor --export vacamejia2017@gmail.com > mi_llave_publica.asc      #Exporta tu clave pública en formato texto(armor) (.asc)
cat mi_llave_publica.asc        #Muestra el contenido de la clave pública en pantalla
gpg --list-secret-keys --keyid-format=long   
gpg --armor --export-secret-keys        #Exporta tus claves privadas en formato texto (uso delicado)
gpg --import mi_llave_publica_Arthur.asc     #Importa la llave publica de alguien mas 
echo "Hola que hace" > doc_no_cifrado.txt   #"Muestra con echo el mensaje, y lo crea en un documento nuevo"
gpg --output doc_cifrado.txt --encrypt --recipient beltranartfire@hotmail.com "hash o correo de la persona" doc_no_cifrado.txt       
#Cifra el archivo usando la clave pública del destinatario y genera un archivo encriptado que solo esa persona puede descifrar
#output especifica el nombre del archivo donde se guardará el resultado del comando
gpg --decrypt doc_cifrado.txt       #desenecripta 
gpg --output doc_no_cifrado_firmado.txt --clearsign doc_no_cifrado.txt
cat doc_no_cifrado_firmado.txt