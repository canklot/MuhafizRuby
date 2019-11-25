require 'simple_crypt'
require 'crypt/blowfish'

#   Functions   ---------------------------------------------------

def encryptthis(thedata,masterkey)
  cryptedtext = SimpleCrypt.encrypt(thedata,masterkey)
  return cryptedtext
end

def decryptthis(thedata,masterkey)
  decryptedtext = SimpleCrypt.decrypt(thedata,masterkey)
  return decryptedtext
end

def appendthis(filename,thedata)
  myfile = File.open(filename,"a")
  myfile.write(thedata , "\n")
  myfile.close

end

def writethis(filename,thedata)
  myfile = File.open(filename,"w")
  myfile.write(thedata)
  myfile.close
end

def readallofthat(filename)
  myfile = File.open(filename,"r")
  readedtext = myfile.read
  myfile.close
  return readedtext

end

def getsecretobject(filename)
  myfile = File.open(filename,"r")
  readed_secret_data = myfile.readline.chomp
  readed_iv = myfile.readline.chomp
  readed_salt = myfile.readline.chomp
  readed_auth_tag = myfile.readline.chomp
  readed_auth_data = myfile.readline.chomp
  readed_secret_object = SimpleCrypt::Secret.new
  readed_secret_object.secret_data = readed_secret_data
  readed_secret_object.iv = readed_iv
  readed_secret_object.salt = readed_salt
  readed_secret_object.auth_tag = readed_auth_tag
  readed_secret_object.auth_data = readed_auth_data
  return readed_secret_object

end

def encryptblowfish(input,masterinput)
  blowfish = Crypt::Blowfish.new(masterinput) # i didnt get what double colons means
  encryptedBlock = blowfish.encrypt_block(input)
  return encryptedBlock
end


def decryptblowfish(input,masterinput)
  blowfish = Crypt::Blowfish.new("A key up to 56 bytes long")
  decryptedBlock = blowfish.decrypt_block(encryptedBlock)
  return decryptedBlock
end
 
def getuserinputs
  puts("Welcome to the Muhafiz the password storage.")
  until $usermode=="s" or $usermode=="d" or $usermode=="u"
    puts("Please select a mode:\n For Store s , for decrypt d , for update u")
    $usermode = gets.chomp
  end
  puts("Please enter the name of the site or application or device")
  $site_app_device = gets.chomp
  if $usermode=="s"
    puts("Please enter your password")
    $password = gets.chomp
  end
  puts("Please enter your MasterPassword")
  $masterpass = gets.chomp
end


#   Main    ---------------------------------------------------------------------------------


getuserinputs()

if $usermode == "s"
  crypted_pass = encryptthis($password,$masterpass)
  appendthis("kasa",crypted_pass.secret_data)
  appendthis("kasa",crypted_pass.iv)
  appendthis("kasa",crypted_pass.salt)
  appendthis("kasa",crypted_pass.auth_tag)
  appendthis("kasa",crypted_pass.auth_data)

end

if $usermode =="d"
  #readed = readallofthat("kasa")
  #decrypted_text = decryptblowfish(readed,$masterpass)
  #puts(decrypted_text)

  readedobject = getsecretobject("kasa")
  decypted_text = decryptthis(readedobject,$masterpass)
  puts decypted_text
end


