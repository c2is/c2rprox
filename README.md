c2rprox
========

Reverseproxy which automatically defines pass target.  
Useful with docker installed on your desktop computer.

## Linux Installation (debian's like systems)
Important : stop all services listening on port 80

```
wget --no-check-certificate https://github.com/c2is/c2rprox/blob/master/linux/c2rprox.deb?raw=true -O c2rprox.deb
dpkg -i c2rprox.deb
```

In the config file add some rules according this scheme :  
HostRegularExpression ip:port  
Example:

```
vi /etc/c2rprox/targets
```

```
domain-alpha.* 192.168.1.12:82
domain-omega.* 192.168.99.100:81
```

Then start the daemon
```
/etc/init.d/c2rproxd start
```

IMPORTANT : after any change in the targets file you have to restart the daemon :
```
/etc/init.d/c2rproxd stop & /etc/init.d/c2rproxd start
```

## MacOsx Installation
Important : stop all services listening on port 80

Download installer image
```
wget --no-check-certificate https://github.com/c2is/c2rprox/raw/master/macosx/C2rproxInstall.dmg -O C2rproxInstall.dmg
```

Double click on the file C2rproxInstall.dmg it will appear in your finder.  
Go inside and double click on the installer c2rprox.pkg.  
Follow installer steps.

Once installation finished, edit file /etc/targets and fill it with some rules according this scheme :  
HostRegularExpression ip:port

Example:

```
vi /etc/targets
domain-alpha.* 192.168.1.12:82
domain-omega.* 192.168.99.100:81
```

With these rules all incoming http request like http://domain-alpha.mydesktop.localdomain/XXX will be passed to 192.168.1.12:82.  
And all incoming http request like http://domain-omega.mydesktop.localdomain/XXX will be passed to 192.168.99.100:81. 


Then start the daemon
```
sudo c2rproxd start
```

IMPORTANT : after any change in the targets file you have to restart the daemon :
```
sudo c2rproxd stop && sudo c2rproxd start
```

## Windows Installation
Important : stop all services listening on port 80

Download setup: https://github.com/c2is/c2rprox/raw/master/windows/c2rproxSetup.exe

Run it.

Once installation finished, edit file C:\c2rprox\targets and fill it with some rules according this scheme :  
HostRegularExpression ip:port

Example:

```
vi /etc/targets
domain-alpha.* 192.168.1.12:82
domain-omega.* 192.168.99.100:81
```

Then start the service c2rprox using the Windows Services tool or by typing in command prompt :  
```
net start c2rprox
```

IMPORTANT : after any change in the targets file you have to restart the daemon :
```
net stop c2rprox
net start c2rprox
```

