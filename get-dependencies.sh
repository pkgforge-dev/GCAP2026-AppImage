#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm jre-openjdk openssl

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# Comment this out if you need an AUR package
#make-aur-package PACKAGENAME

# If the application needs to be manually built that has to be done down here
wget https://downloadirpf.receita.fazenda.gov.br/irpf/2026/gcap/GCAP2026v1.0.zip
bsdtar -xvf GCAP2026v1.0.zip --strip-components=1
rm -f *.zip

mkdir -p ./AppDir/bin
sed -i 's|java -Xmx2048M -jar GCAP.jar|java -Xmx2048M -jar "$APPDIR/bin/GCAP.jar" "$@"|g' exec.sh
mv -v exec.sh lib GCAP.jar GCAP.acb offline.png online.png pgd-updater.jar ./AppDir/bin
