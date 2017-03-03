#!/usr/bin/env bash
ln -nfs /Users/Shared/c2rprox/LaunchDaemons/fr.c2is.c2rprox.plist /Library/LaunchDaemons/fr.c2is.c2rprox.plist
chmod +x /Library/LaunchDaemons/fr.c2is.c2rprox.plist
chown root:admin /Library/LaunchDaemons/fr.c2is.c2rprox.plist

ln -nfs /Users/Shared/c2rprox/c2rproxd /usr/bin/c2rproxd
echo 'export PATH="/Users/Shared/c2rprox/:$PATH"' >> ~/.bashrc
ln -nfs /Users/Shared/c2rprox/targets /etc/targets