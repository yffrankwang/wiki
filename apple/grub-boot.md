## Chain Load MacOS OpenCore

Name: MacOS OpenCore
Type: Other
Boot sequence:
```
savedefault
insmod part_gpt
insmod fat
set root='hd0,gpt1'
if [ x$feature_platform_search_hint = xy ]; then
  search --no-floppy --fs-uuid --set=root --hint-bios=hd0,gpt1 --hint-efi=hd0,gpt1 --hint-baremetal=ahci0,gpt1  D823-D6A0
else
  search --no-floppy --fs-uuid --set=root D823-D6A0
fi
chainloader /EFI/OC/OpenCore.efi
```

## Chain Load MacOS Clover

Name: MacOS Clover
Type: Other
Boot sequence:
```
savedefault
insmod part_gpt
insmod fat
set root='hd0,gpt1'
if [ x$feature_platform_search_hint = xy ]; then
  search --no-floppy --fs-uuid --set=root --hint-bios=hd0,gpt1 --hint-efi=hd0,gpt1 --hint-baremetal=ahci0,gpt1  D823-D6A0
else
  search --no-floppy --fs-uuid --set=root D823-D6A0
fi
chainloader /EFI/Boot/clover.efi
```

# grub boot clover
~~~
savedefault
insmod part_gpt
insmod fat
insmod chain
search --no-floppy --fs-uuid --set=root 5658-757C
chainloader /efi/boot/bootx64c.efi
~~~

~~~
insmod part_gpt
insmod fat
set root='hd0,gpt1'
if [ x$feature_platform_search_hint = xy ]; then
  search --no-floppy --fs-uuid --set=root --hint-bios=hd0,gpt1 --hint-efi=hd0,gpt1 --hint-baremetal=ahci0,gpt1  5658-757C
else
  search --no-floppy --fs-uuid --set=root 5658-757C
fi
chainloader /efi/boot/bootx64c.efi
~~~

# grub boot osx
~~~
savedefault
insmod hfsplus
set root='(hd1,gpt6)'
chainloader /System/Library/CoreServices/boot.efi
~~~
