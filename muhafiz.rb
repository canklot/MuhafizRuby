require 'simple_crypt'
require 'unix_crypt'

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

def getsecretobject(filename,inhashedusername)
  okunan = readallofthat("kasa")

  start = okunan.index(inhashedusername)+inhashedusername.length+1
  finish = okunan.index("\n",start) 
  charsayisi= okunan.index("\n",start) - start
  readed_secret_data = okunan[start , charsayisi]

  start = finish+1
  charsayisi= okunan.index("\n",start) - start
  readed_iv = okunan[start,charsayisi]
  
  finish = okunan.index("\n",start) 
  start = finish+1
  charsayisi= okunan.index("\n",start) - start 
  readed_salt = okunan[start,charsayisi]
  
  finish = okunan.index("\n",start) 
  start = finish+1
  charsayisi= okunan.index("\n",start) - start
  readed_auth_tag = okunan[start,charsayisi]

  finish = okunan.index("\n",start) 
  start = finish+1
  charsayisi= okunan.index("\n",start) - start 
  readed_auth_data = okunan[start,charsayisi]

  readed_secret_object = SimpleCrypt::Secret.new
  readed_secret_object.secret_data = readed_secret_data
  readed_secret_object.iv = readed_iv
  readed_secret_object.salt = readed_salt
  readed_secret_object.auth_tag = readed_auth_tag
  readed_secret_object.auth_data = readed_auth_data
  
  return readed_secret_object
end

def secretobject_writetofile(secretobject)
  appendthis("kasa",secretobject.secret_data)
  appendthis("kasa",secretobject.iv)
  appendthis("kasa",secretobject.salt)
  appendthis("kasa",secretobject.auth_tag)
  appendthis("kasa",secretobject.auth_data)
  appendthis("kasa","")
end
 
def getuserinputs
  system ("cls")
  puts("\n      Welcome to the Muhafiz the password storage. \n")

  until $usermode=="s" or $usermode=="d" or $usermode=="u"
    puts("\nPlease select a mode: For Store s , for decrypt d ")
    $usermode = gets.chomp
  end

  puts("\nPlease enter the name of the site")
  $site = gets.chomp

  puts ("\nplease enter the username")
  $username = gets.chomp

  if $usermode=="s"
    puts("\nPlease enter your password")
    $password = gets.chomp
  end

  puts("\nPlease enter your MasterPassword")
  $masterpass = gets.chomp
end

def hashthis(input)
  hashed = UnixCrypt::SHA256.build(input,"")
  return hashed
end

#   Main    ---------------------------------------------------------------------------------

getuserinputs()

if $usermode == "s"
  crypted_pass = encryptthis($password,$masterpass)
  hashed_site =hashthis($site)
  hashed_username = hashthis($username)
  
  appendthis("kasa",hashed_site)
  appendthis("kasa",hashed_username)
  secretobject_writetofile(crypted_pass)
  appendthis("kasa","")
  puts("\nOperation succesfull Thank you for using Muhafiz")
end

if $usermode =="d"
  hashed_site = hashthis($site)
  hashed_username = hashthis($username)
  kasa = readallofthat("kasa")
  index_site = kasa.index(hashed_site)
  index_username = kasa.index(hashed_username)

  if !((index_site !=nil) and (index_username !=nil))
    puts "\nLogin credentials cant found"
    exit
  end
  
  readedobject = getsecretobject("kasa",hashed_username)
  decypted_text = decryptthis(readedobject,$masterpass)

  if decypted_text ==nil
    puts "\n Something went wrong. Your masterpass can be invalid"
  else
    print "\nYour password is: " ,decypted_text ,"\n\n"
  end
end