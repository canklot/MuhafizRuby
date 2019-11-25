require 'simple_crypt'


def getsecretobject(filename)
    myfile = File.open(filename,"r")
    readed_secret_data = myfile.readlines
    readed_iv = myfile.readlines
    readed_salt = myfile.readlines
    readed_auth_tag = myfile.readlines
    readed_auth_data = myfile.readlines
    readed_secret_object = SimpleCrypt::Secret.new
    readed_secret_object.secret_data = readed_secret_data
    readed_secret_object.iv = readed_iv
    readed_secret_object.salt = readed_salt
    readed_secret_object.auth_tag = readed_auth_tag
    readed_secret_object.auth_data = readed_auth_data
    return readed_secret_object
  
  end
 
  myfile = File.open("kasa","r")
  ilkline= myfile.readline
  puts ilkline
