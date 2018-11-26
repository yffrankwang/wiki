## Android-x86 5.1-rc1
~~~
set root='(hd0,7)'
search --no-floppy --fs-uuid --set=root 033e8fc7-4cfe-9454-bc59-df7329ca862d
linux  /android-5.1-rc1/kernel quiet root=/dev/ram0 androidboot.hardware=android_x86_64 SRC=/android-5.1-rc1
initrd /android-5.1-rc1/initrd.img
~~~

## Advanced options for Android-x86
### Android-x86 5.1-rc1 (Debug mode)
~~~
set root='(hd0,4)'
search --no-floppy --fs-uuid --set=root 033e8fc7-4cfe-9454-bc59-df7329ca862d
linux /android-5.1-rc1/kernel root=/dev/ram0 androidboot.hardware=android_x86_64 DEBUG=2 SRC=/android-5.1-rc1
initrd /android-5.1-rc1/initrd.img
~~~

### Android-x86 5.1-rc1 (Debug nomodeset)
~~~
set root='(hd0,4)'
search --no-floppy --fs-uuid --set=root 033e8fc7-4cfe-9454-bc59-df7329ca862d
linux /android-5.1-rc1/kernel nomodeset root=/dev/ram0 androidboot.hardware=android_x86_64 DEBUG=2 SRC=/android-5.1-rc1
initrd /android-5.1-rc1/initrd.img
~~~

### Android-x86 5.1-rc1 (Debug video=LVDS-1:d)
~~~
set root='(hd0,1)'
search --no-floppy --fs-uuid --set=root 5658-757C
linux /android-5.1-rc1/kernel video=LVDS-1:d root=/dev/ram0 androidboot.hardware=android_x86_64 DEBUG=2 SRC=/android-5.1-rc1
initrd /android-5.1-rc1/initrd.img
~~~
