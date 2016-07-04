#!/bin/sh
if [ "$(uname)" != "Linux" ]; then 

	if test "`find ./linux/ -name c2rprox -mmin +5`"; 
	then 
		echo "The bin linux/c2rprox is older than 5 minutes, are you sure it's the lastest compiled version ?"; 
		echo "If you have any doubt, run on you linux filesystem : go build -o linux/c2rprox c2rprox.go"
	fi

fi;

cwd=`pwd`

cd linux
cp c2rprox debian_package/usr/share/c2rprox/
cp c2rproxd debian_package/usr/share/c2rprox/
touch debian_package/usr/share/c2rprox/targets
echo "#Don't forget to restart c2rprox (/etc/init.d/c2rprox stop & /etc/init.d/c2rprox start)\n" > debian_package/usr/share/c2rprox/targets
echo "#domain-alpha.* 127.0.0.1:81\n" >> debian_package/usr/share/c2rprox/targets
touch debian_package/usr/share/c2rprox/c2rprox.log

cd $cwd/linux/debian_package/var/log/
ln -s ../../usr/share/c2rprox/c2rprox.log c2rprox.log
cd ../../

cd $cwd/linux/debian_package/etc/c2rprox/;
ln -s ../../usr/share/c2rprox/targets targets

cd $cwd/linux/;
dpkg --build debian_package c2rprox.deb

rm $cwd/linux/debian_package/etc/c2rprox/*
rm -rf $cwd/linux/debian_package/usr/share/c2rprox/*
rm $cwd/linux/debian_package/var/log/*
