require 'simple_crypt'

def cryptthis(thedata,masterkey)
  cryptedtext = SimpleCrypt.encrypt(thedata,masterkey)
  return cryptedtext
end

def decryptthis(thedata,masterkey)
  decryptedtext = SimpleCrypt.decrypt(thedata,masterkey)
  return decryptedtext
end

def appendthis(filename,thedata)
  myfile = File.open(filename,"a")
  myfile.write(thedata)
end

def readallofthat(filename)
  myfile = File.open(filename,"r")
  readedtext = myfile.read
  return readedtext
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

getuserinputs()

if $usermode == "s"
  crypted_pass = cryptthis($password,$masterpass)
  appendthis("kasa",crypted_pass.secret_data)
end

if $usermode =="d"
  readed_file = readallofthat("kasa")
  decrypted_text = decryptthis(readed_file,$masterpass)
  puts(decrypted_text)
end


