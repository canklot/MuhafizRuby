require 'simple_crypt'
require 'crypt/blowfish'
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

  #puts "start" ,start
  #puts okunan.index("\n",start)
  #puts "charsayisi" ,charsayisi
  #puts readed_secret_data

  start = finish+1
  puts "start" ,start

  charsayisi= okunan.index("\n",start) - start
  #puts "charsayisi" ,charsayisi

  readed_iv = okunan[start,charsayisi]
  #puts readed_iv
  finish = okunan.index("\n",start) 
  start = finish+1
  #puts "start" ,start

  charsayisi= okunan.index("\n",start) - start 
  #puts "charsayisi" ,charsayisi

  readed_salt = okunan[start,charsayisi]
  # puts readed_salt
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


def encryptblowfish(input,masterinput)
  blowfish = Crypt::Blowfish.new(masterinput) 
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

  puts("Please enter the name of the site")
  $site = gets.chomp

  puts ("please enter the username")
  $username = gets.chomp

  if $usermode=="s"
    puts("Please enter your password")
    $password = gets.chomp
  end

  puts("Please enter your MasterPassword")
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


end
def howmany(filename,inputstring)
  counter=0
  for i in filename
    if i==inputstring
      counter+=1
    end
  end
  return counter


end

if $usermode =="d"
  
  hashed_site =hashthis($site)
  hashed_username = hashthis($username)
  kasa = readallofthat("kasa")
  kasa = kasa.gsub("\n", '')
  index_site = kasa.index(hashed_site)
  index_username = kasa.index(hashed_username)

  if !((index_site >-1) and (index_username > -1))
    puts "Login credentials cant found"
    exit
  end
  #hata var hep face şifresi veriyor
  if index_site > -1
    #ben burayı neden ekledim ki ? index_username_file = kasa[index_site+48,48].index(hashed_username)+49
    if index_username > -1
      readedobject = getsecretobject("kasa",hashed_username)
      decypted_text = decryptthis(readedobject,$masterpass)
      puts decypted_text
    end
  end
end


#Notes : Doesnt work when username and pass are same