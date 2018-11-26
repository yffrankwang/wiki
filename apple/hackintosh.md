# grub boot clover

	savedefault
	insmod part_gpt
	insmod fat
	set root='hd1,gpt1'
	if [ x$feature_platform_search_hint = xy ]; then
	  search --no-floppy --fs-uuid --set=root --hint-bios=hd1,gpt1 --hint-efi=hd1,gpt1 --hint-baremetal=ahci1,gpt1  5658-757C
	else
	  search --no-floppy --fs-uuid --set=root 5658-757C
	fi
	chainloader /efi/boot/bootx64c.efi


# grub boot osx

	savedefault
	insmod hfsplus
	set root='(hd1,gpt6)'
	chainloader /System/Library/CoreServices/boot.efi

