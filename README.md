c2rprox
========

Reverseproxy which automatically defines pass target.  
Useful with docker installed on your desktop computer.

## Linux Installation (debian's like systems')
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

```
git clone git@github.com:c2is/c2rprox.git
cd c2rprox/macosx/
```

Here make a file named targets and fill it with some rules according this scheme :  
HostRegularExpression ip:port  
Example:

```
domain-alpha.* 192.168.1.12:82
domain-omega.* 192.168.99.100:81
```

With these rules all incoming like http request http://domain-alpha.mydesktop.localdomain/XXX will be passed to 192.168.1.12:82.  
And all incoming http request http://domain-omega.mydesktop.localdomain/XXX will be passed to 192.168.99.100:81. 

## Run/Stop daemon
In you c2rprox/macosx/:
```
sudo ./c2rprox.d start
sudo ./c2rprox.d stop
```

