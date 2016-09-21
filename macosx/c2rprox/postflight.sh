#!/usr/bin/env bash
chmod +x /Library/LaunchDaemons/fr.c2is.c2rprox.plist
chown root:admin /Library/LaunchDaemons/fr.c2is.c2rprox.plist
ln -nfs /usr/share/c2rprox/LaunchDaemons/fr.c2is.c2rprox.plist /Library/LaunchDaemons/fr.c2is.c2rprox.plist
ln -nfs /usr/share/c2rprox/c2rproxd /usr/bin/c2rproxd
ln -nfs /usr/share/c2rprox/targets /etc/targets