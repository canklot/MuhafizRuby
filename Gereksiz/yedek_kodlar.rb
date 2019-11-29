cryptedobject = SimpleCrypt.encrypt(benisifrele,masterkey)
cryptedtext = cryptedobject
#puts(cryptedtext)
#decrypted = SimpleCrypt.decrypt(cryptedtext,masterkey)
#puts(decrypted)


myfile = File.open("dosyam.txt","w")
myfile.write(cryptedtext)
myfile.close

myfile = File.open("dosyam.txt","r")
readed = myfile.read()
myfile.close

puts(readed)
puts(SimpleCrypt.decrypt(readed,masterkey))



 

class Userinputs
    @@usermode = "-nothing"
    def self.getuserinputs
      puts("Welcome to the Muhafiz the password storage.")
      until @@usermode=="-s" || @@usermode=="-m" || @@usermode=="-u"
        puts("Please select a mode. Store -s , decrypt -d , update -u")
        @@usermode = gets.chomp
       end
    def self.usermode
      @@usermode
    end
  
  end