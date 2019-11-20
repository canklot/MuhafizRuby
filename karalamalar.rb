require 'simple_crypt'

cryptedobject = SimpleCrypt.encrypt("asdw","master")
cryptedtext = cryptedobject.secret_data
puts(cryptedobject)
puts(cryptedtext)
#decrypted = SimpleCrypt.decrypt(cryptedtext,masterkey)
#puts(decrypted)

