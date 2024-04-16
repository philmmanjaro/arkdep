#!/bin/sh
# Change to Discover
sed -i -e 's/org.manjaro.pamac.manager.desktop/org.kde.discover.desktop/g' \
${workdir}/usr/share/plasma/look-and-feel/org.manjaro.breath-dark.desktop/contents/layouts/org.kde.plasma.desktop-layout.js
sed -i -e 's/org.manjaro.pamac.manager.desktop/org.kde.discover.desktop/g' \
${workdir}/usr/share/plasma/look-and-feel/org.manjaro.breath.desktop/contents/layouts/org.kde.plasma.desktop-layout.js
sed -i -e 's/org.manjaro.pamac.manager.desktop/org.kde.discover.desktop/g' \
${workdir}/usr/share/plasma/look-and-feel/org.manjaro.breath-light.desktop/contents/layouts/org.kde.plasma.desktop-layout.js
sed -i -e 's/org.manjaro.pamac.manager.desktop/org.kde.discover.desktop/g' \
${workdir}/usr/share/plasma/layout-templates/org.manjaro.desktop.breathPanel/contents/layout.js

# Enable flathub
arch-chroot ${workdir} flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Save pacman local database
mkdir -pv ${workdir}/usr/share/manjaro
arch-chroot ${workdir} tar -czf /opt/manjaro/pacman-local-db.tar.gz /var/lib/pacman/local
pacman -Q --root=${workdir} > ${workdir}/usr/share/manjaro/installed.pkgs

# Remove pacman
arch-chroot ${workdir} sed -i -e '/HoldPkg = pacman/d' /etc/pacman.conf
arch-chroot ${workdir} pacman -Scc --noconfirm
arch-chroot ${workdir} pacman -Rdd pacman pacman-mirrors --noconfirm

# Delete pacman database local cache
[[ -d "${workdir}/var/lib/pacman/local" ]] && find "${workdir}/var/lib/pacman/local" -mindepth 1 -delete
# Delete pacman package configs
[[ -d "${workdir}/etc/pacman.d" ]] && find "${workdir}/etc/pacman.d" -type f -delete
[[ -d "${workdir}/etc/pacman.conf" ]] && find "${workdir}/etc/pacman.conf" -type f -delete
