# Install macOS Monterey on VirtualBox

https://i12bretro.github.io/tutorials/0629.html
https://saturday-in-the-park.netlify.app/Mac/MontereyOnVirtualbox/
https://shaadlife.com/install-macos-monterey-on-virtualbox/
https://osxdaily.com/2021/07/15/how-install-macos-virtualbox-windows/


## Create install iso (on real mac or hackintosh)

(1) 14GBの空イメージを作成する。

$ hdiutil create -o monterey  -size 14G -layout SPUD -fs HFS+J -type SPARSE
created: /Users/username/monterey.sparseimage

(2) 空イメージをマウントする。

$ hdiutil attach monterey.sparseimage -noverify -mountpoint /Volumes/Monterey
/dev/disk2          	Apple_partition_scheme         	
/dev/disk2s1        	Apple_partition_map            	
/dev/disk2s2        	Apple_HFS                      	/Volumes/Monterey

(3) 空イメージに、起動可能なインストールメディアを作成する。

$  sudo /Applications/Install\ macOS\ Monterey.app/Contents/Resources/createinstallmedia --volume /Volumes/Monterey/
Password:
Ready to start.
To continue we need to erase the volume at /Volumes/Monterey.
If you wish to continue type (Y) then press return: Y
Erasing disk: 0%... 10%... 20%... 30%... 100%
Making disk bootable...
Copying to disk: 0%... 10%... 20%... 30%... 40%... 50%... 60%... 70%... 80%... 90%... 100%
Install media now available at "/Volumes/Install macOS Monterey"

(4) ボリュームをアンマウントする。

$ hdiutil detach "/Volumes/Install macOS Monterey"
"disk2" ejected.

このコマンドで失敗した場合は、ボリュームを強制的にゴミ箱へドラッグ！

(5) isoイメージに変換する。

$ hdiutil convert monterey.sparseimage -format UDTO -o monterey
created: /Users/username/monterey.cdr

(6) 後始末

$ mv monterey.cdr InstallMonterey.iso
$ rm monterey.sparseimage

以上で起動可能なインストールメディアイメージ「InstallMonterey.iso」が完成。


## Install macOS on VirtualBox

### VM Configuration
System / Montheboard
> Memory: > 4GB
> Boot Order: CD -> HDD
> Chipset: ICH9
> Poiting Device: USB Table
> Extended Features:
>  (OK) Enbale I/O APIC
>  (OK) Enbale EFI
>  (OK) Hardware Clock in UTC Time

System / Processor
> Processors: 1  <-- prevent panic on install
> (OK) Enable PAE/NX

Display / Screen
> Video Memory: 128M

Audio / Audio
> uncheck: Enable Audio

USB / USB
> (OK) USB 3.0

### Patch

#### desktop
```bat
cd "%programfiles%\Oracle\VirtualBox\"
VBoxManage.exe modifyvm     "MacOS" --cpuidset 00000001 000106e5 00100800 0098e3fd bfebfbff
VBoxManage.exe setextradata "MacOS" "VBoxInternal/Devices/efi/0/Config/DmiSystemProduct" "iMac19,1"
VBoxManage.exe setextradata "MacOS" "VBoxInternal/Devices/efi/0/Config/DmiSystemVersion" "1.0"
VBoxManage.exe setextradata "MacOS" "VBoxInternal/Devices/efi/0/Config/DmiBoardProduct" "Mac-AA95B1DDAB278B95"
VBoxManage.exe setextradata "MacOS" "VBoxInternal/Devices/smc/0/Config/DeviceKey" "ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc"
VBoxManage.exe setextradata "MacOS" "VBoxInternal/Devices/smc/0/Config/GetKeyFromRealSMC" 1
VBoxManage.exe setextradata "MacOS" "VBoxInternal2/EfiHorizontalResolution" 1600
VBoxManage.exe setextradata "MacOS" "VBoxInternal2/EfiVerticalResolution"   900
```

### laptop
```bat
VBoxManage.exe setextradata "MacOS" "VBoxInternal/Devices/efi/0/Config/DmiSystemProduct" "MacBookPro15,1"
VBoxManage.exe setextradata "MacOS" "VBoxInternal/Devices/efi/0/Config/DmiBoardProduct" "Mac-551B86E5744E2388"
```

## Troubleshooting

### Failed to open a session for the virtual machine MacOS.

Failed to query SMC value from the host (VERR_INVALID_HANDLE).

Result Code: E_FAIL (0x80004005)
Component: ConsoleWrap
Interface: IConsole {872da645-4a9b-1727-bee2-5585105b9eed}

> Solution:
> VBoxManage.exe setextradata "MacOS" "VBoxInternal/Devices/smc/0/Config/GetKeyFromRealSMC" 0
