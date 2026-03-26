uname -a   # Show system information (kernel, OS, architecture)
which gpg # Check if GPG is installed and its location  
gpg --version # Display GPG version     
gpg --full-generate-key # Generate a new GPG key pair (public and private keys)    
gpg --list-keys  # List all public keys in the keyring  
gpg --armor --export vacamejia2017@gmail.com > mi_llave_publica.asc  # Export public key in readable format to share    
cat mi_llave_publica.asc   # Display the exported public key    
gpg --list-secret-keys --keyid-format=long   # List private (secret) keys with long key ID
gpg --armor --export-secret-keys # Export private key (for backup purposes, not to share)       
gpg --import mi_llave_publica_Arthur.asc   # Import partner's public key  
gpg --output doc_no_cifrado_firmado.txt --clearsign doc_no_cifrado.txtecho "Hola que hace" > doc_no_cifrado.txt  # Create a plaintext file with a message # Sign the file in clear text (readable format) 
gpg --output doc_cifrado.txt --encrypt --recipient beltranartfire@hotmail.com "hash o correo de la persona" doc_no_cifrado.txt   # Encrypt the file using recipient's public key    
gpg --decrypt doc_cifrado.txt    # Decrypt the encrypted file using private key 
cat doc_no_cifrado_firmado.txt  # Verify signed file from partner
gpg --verify doc_no_cifrado_firmado_Arthur.txt # Verify signed file from partner
gpg --edit-key 8877B3D2D00354939A4A0DBCF8FF2318CE917242 # Edit partner's key to assign trust level
trust # Set trust level for the key
q # Quit key editing mode
gpg --sign-key 8877B3D2D00354939A4A0DBCF8FF2318CE917242 # Sign partner's public key to validate identity
gpg --verify doc_no_cifrado_firmado_Arthur.txt # Verify again to observe trust changes
gpg --output doc_no_cifrado_firmado_binario.txt --sign doc_no_cifrado.txt # Sign file in binary format
gpg --output firma_separada_doc_no_cifrado.sig --detach-sign doc_no_cifrado.txt # Create a detached signature file
gpg --verify doc_no_cifrado_firmado_binario_Arthur.txt # Verify binary signed file from partner
gpg --verify firma_separada_doc_no_cifrado_Arthur.sig doc_no_cifrado_Arthur.txt # Verify detached signature with original file
gpg --output doc_cifrado_y_firmado.txt --encrypt --sign --recipient 8877B3D2D00354939A4A0DBCF8FF2318CE917242 doc_no_cifrado. # Encrypt and sign the file at the same time
gpg --output doc_cifrado_y_firmado_descifrado_y_validado.txt --decrypt doc_cifrado_y_firmado_Arthur.txt # Decrypt and verify the signed file
cat doc_cifrado_y_firmado_descifrado_y_validado.txt # Display final decrypted content