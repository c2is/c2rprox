c2rprox
========

Reverseproxy which automatically define target pass.  
Useful with docker installed on your desktop computer.


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

