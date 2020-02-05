# ThinkPad X1 Carbon 2017 5th Catalina

https://www.tonymacx86.com/threads/99-perfect-sierra-10-12-6-on-thinkpad-x1-carbon-5th-gen-with-dual-boot-unchanged-win7.237922/

## Preparing the USB installation disk
thanks great guide: https://www.tonymacx86.com/threads/guide-booting-the-os-x-installer-on-laptops-with-clover.148093/

> diskutil list
~~~
/dev/disk1 (external, physical):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:                                                   *8.0 GB     disk1[/B]
~~~

GPT partition:
~~~
# repartition /dev/disk1 GPT, one partition
# EFI will be created automatically
# second partition, "install_osx", HFS+J, remainder
diskutil partitionDisk /dev/disk1 1 GPT HFS+J "install_osx" R
~~~

Output:
~~~
Started partitioning on disk1
Unmounting disk
Creating the partition map
Waiting for the disks to reappear
Formatting disk1s2 as Mac OS Extended (Journaled) with name install_osx
Initialized /dev/rdisk1s2 as a 7 GB case-insensitive HFS Plus volume with a 8192k journal
Mounting disk
Finished partitioning on disk1
/dev/disk1 (external, physical):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      GUID_partition_scheme                        *8.0 GB     disk1
   1:                        EFI EFI                     209.7 MB   disk1s1
   2:                  Apple_HFS install_osx             7.7 GB     disk1s2
~~~

## Create a bootable USB macos installer
https://www.macworld.com/article/3442597/how-to-create-a-bootable-macos-catalina-installer-drive.html

~~~
sudo /Applications/Install\ macOS\ Catalina.app/Contents/Resources/createinstallmedia --volume /Volumes/install_osx -- /Applications/Install\ macOS\ Catalina.app
~~~

## Mount EFI
~~~
mkdir /Volumes/efi
sudo mount -t msdos /dev/disk1s1 /Volumes/efi
~~~

## Replace EFI/Clover

~~~
	git clone https://github.com/B0hrer/Thinkpad-x1c-5th-gen-Hackintosh.git
	sudo cp -a Thinkpad-x1c-5th-gen-Hackintosh/EFI/* /Volumes/efi/EFI/
	sudo rm /Volumes/efi/EFI/CLOVER/ACPI/patched/DSDT.aml
~~~

## BIOS settings
* Config → Network → Wake On LAN: Disabled
* Security → Memory Protection → Execution prevention: Enabled
* Security → Secure Boot: Disabled
* Security → Device Guard: Disabled
* Startup → UEFI/ Legacy Boot: UEFI only
* Startup → CSM support: Yes

## Boot from USB and choose 'install from install_osx'

