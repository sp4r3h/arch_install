#uk keyboard layout
loadkeys uk

#format GPT filesystem
cgdisk
#ef02 1024k partition at front.

#format partitions
mkfs -t ext4 /dev/sda1
mkfs -t ext4 /dev/sda2

#mount partitions
mount /dev/sda1 /mnt/
mkdir /mnt/home
mount /dev/sda2 /mnt/home

#rank mirrors
pacman -Sy reflector
reflector --verbose --country 'United Kingdom -l 200 -p http --sort rate --save /etc/pacman.d/mirrorlist

#install the base system
pacstrap /mnt base base-devel


#write the fstab
genfstab -p -U /mnt >> /mnt/etc/fstab

#chroot into system
arch-chroot /mnt

#hostname
echo archbox >> /etc/hostname

#symlink time to localtime
ln -s /usr/share/zoneinfo/Europe/London /etc/localtime
hwclock --systohc --utc

#uncomment locale in /etc/locale.gen  en-gb utf-8
#then
locale-gen
#create /etc/locale.conf
echo LANG="en_GB.UTF-8" > /etc/locale.conf
export LANG=en_GB.UTF-8

#create /etc/vconsole.conf
KEYMAP=uk

#mkinitcpio
mkinitcpio -p linux

#root password
passwd

#network
systemctl enable dhcpcd@eno1.service

#install grub
pacman -Sy grub-bios
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

useradd -m -g users -G wheel,storage,power -s /bin/bash spowney
passwd spowney

EDITOR=nano visudo

pacman -S bash-completion


#unmount and reboot
umount /mnt/{boot,home,}
reboot


##Post Install

##add (archlinuxfr) to list, uncomment multilib in pacman.conf

pacman -Sy yaourt

##remove archlinuxfr form pacman.conf beforecontinuing

yaourt -S alsa-utils alsa-plugins xorg-server xorg-server-utils xorg-xinit xterm bash-completion mesa lib32-nvidia-utils nvidia git i3 ttf-google-fonts-git google-chrome google-chrome-extension-moonlight

echo exec i3 > ~.xinitrc

reboot (for nvidia drivers)

startx
