require 'unix_crypt'

hashed = UnixCrypt::SHA256.build("Hello world!")
puts hashed
/
myfile = File.open("hashkasa","w")
myfile.write(hashed)
myfile.close
/
reader = File.open("hashkasa","r")
readed = reader.read()
reader.close

myvalid = UnixCrypt.valid?("Hello world!", readed)
puts myvalid

puts "Hello"
/
puts "world"
/
puts "peace"