+++
date = "2017-09-12T12:00:00"
draft = false
tags = ["Technical"]
title = "Recovering Arch Linux after a side-by-side install"
math = true
+++

If another OS (also *nix based) is installed alongside arch, grub will likely get messed up on the arch side of things. Grub will see the arch linux boot option, however, upon startup it will throw a kernel panic with the error:
``` text
Not syncing: VFS
Unable to mount root fs on unknown-block.
```

This is caused by a bug in the way some other linux distros generate the grub.cfg file. If you have the above error, your grub.cfg arch linux entry will likely look like this:
``` text
initrd /boot/intel-ucode.img
```
It should be:
``` text
initrd /boot/intel-ucode.img /boot/initramfs-linux.img
```

So here is how to fix it:

1. Boot to grub and press `e` over the Arch linux boot entry to edit it
2. Add `/boot/initramfs-linux.img` to the line starting with `initrd`
3. Boot with above changes (probably `F10`)

The above steps allow you to boot into arch linux, however, currently that edit has to be made everytime you want to boot arch. To fix this do the following:

1. Ensure os-prober is installed: `sudo pacman -S os-prober`
2. Run `sudo grub-mkconfig -o /boot/grub/grub.cfg`
3. Run `sudo grub-install /dev/sda` 
  * Note: replace `/dev/sda` with your boot drive if it is different

These commands will generate a new grub.cfg file and also give arch linux control of grub again. This ensures that the arch linux boot entry will always be correct! 

