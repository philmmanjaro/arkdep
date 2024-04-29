#!/bin/sh

# Save pacman local database
mkdir -p ${workdir}/var/lib/manjaro
tar -czf ${workdir}/var/lib/manjaro/pacman-local-db.tar.gz ${workdir}/var/lib/pacman/local
arch-chroot ${workdir} pacman -Q > /var/lib/manjaro/installed-pkgs.log

# Remove pacman
arch-chroot ${workdir} sed -i -e '/HoldPkg = pacman/d' /etc/pacman.conf
arch-chroot ${workdir} pacman -Scc --noconfirm
arch-chroot ${workdir} pacman -Rdd pacman pacman-mirrors --noconfirm

# Delete pacman database local cache
[[ -d "${workdir}/var/lib/pacman/local" ]] && find "${workdir}/var/lib/pacman/local" -mindepth 1 -delete
# Delete pacman package configs
[[ -d "${workdir}/etc/pacman.d" ]] && find "${workdir}/etc/pacman.d" -type f -delete
[[ -d "${workdir}/etc/pacman.conf" ]] && find "${workdir}/etc/pacman.conf" -type f -delete
