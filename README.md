This is my generation terrain example.
<how to set up workspace>

download xampp(lampp) version 8.0.30  [linux]
https://www.apachefriends.org/download.html
(so http conf file would be easy to set up)

when there is a folder, named "HTTPD FILES" and inside is
setting of httpd.conf file, to replace existing one.
found in "/opt/lampp/etc/"

And second file, incase you want to know, what is changed inside new httpd.conf

all those files have to be inside
"/opt/lampp/cgi-bin/"
(besides httpd.conf)

when that done, assemble code like this:
cd /opt/lampp/cgi-bin
nasm -f elf64 work.asm -o work.o
    gcc work.o -lfcgi -no-pie -o index.fcgi
chmod +x index.fcgi

start compiled code:
spawn-fcgi -n -p 9000 ./index.fcgi

to stop code either ctrl + c inside console or:
sudo fuser -k 9000/tcp

<SLIGHT EXPLANATION OF THE CODE>
0) "work.asm" is main file
1) it begins by initializing data
Loads 10mb data file into memory which contains 100k possible user slots (each 100bytes)
Loads images into memory (6,1 mb)
Both for fast acces
2) when it begins main loop
3) waits for new request
4) when receaves request it when checks if user has cookies, "token" and "pass"
If user has both, it when checks by the token, which is hash and logins each time
If user registers/ new login it when hashes username into unique string in range of 100k variants
If none of these when it just prcceds to go to login screen
5) will finish explaining tommorow.
