require 'simple_crypt'

benisifrele="ben onemli bir yaziyim"
masterkey="master"

cryptedobject = SimpleCrypt.encrypt(benisifrele,masterkey)
cryptedtext = cryptedobject#secret_data
puts(cryptedtext)
decrypted = SimpleCrypt.decrypt(cryptedtext,masterkey)
puts(decrypted)