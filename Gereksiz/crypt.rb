require 'crypt/blowfish'
blowfish = Crypt::Blowfish.new("A key up to 56 bytes long")
plainBlock = "ABCD1234"
encryptedBlock = blowfish.encrypt_block(plainBlock)
decryptedBlock = blowfish.decrypt_block(encryptedBlock)
puts encryptedBlock
puts decryptedBlock


myfile=File.open("cryptkasa","w")
myfile.write(encryptedBlock)
myfile.close

reader = File.open("cryptkasa","r")
readedtext=reader.read
puts readedtext

readeddecryoted = blowfish.decrypt_block(readedtext)
puts "okunan altta"
puts readeddecryoted