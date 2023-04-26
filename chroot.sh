#!/bin/bash

#sda1 boot
#sda2 efi boot
#sda3 swap
#sda 4 root luks encrypted

read -p "Provide LUKS PW" LUKS_PW
echo -n "${LUKS_PW}" | cryptsetup luksOpen /dev/sda4 ROOT -

swapon /dev/sda3
mount -t ext4 /dev/mapper/ROOT /mnt
mount /dev/sda1 /mnt/boot
mount /dev/sda2 /mnt/boot/efi

mount -t proc /proc /mnt/proc/
mount -t sysfs /sys /mnt/sys/
mount -o bind /dev /mnt/dev
mount --rbind /sys/firmware/efi/efivars /mnt/sys/firmware/efi/efivars
cp /etc/resolv.conf /mnt/etc/resolv.conf
chroot /mnt /bin/bash



