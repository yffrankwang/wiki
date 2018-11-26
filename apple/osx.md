# bootcamp bluetooth
	[Computer Management] -> [Device Mangaer] -> [Bluetooth] (Update Driver Software)
	Broadcom　/　BCM2033 Bluetooth 2.4 GHz Single Chip Transceiver

# list xattr

	xattr xxx.file

# remote xattr

	xattr -dr com.apple.quarantine  xxx.dir


# print plist

Install: pip install biplist

Read:
```py

from biplist import *

plist = readPlist("Info.plist")

print(plist)

```

# sshpass (https://gist.github.com/arunoda/7790979)
	> brew install https://raw.githubusercontent.com/kadwanev/bigboybrew/master/Library/Formula/sshpass.rb
	
	or download https://sourceforge.net/projects/sshpass/
	
	./configure
	sudo make install


# SK8855
	http://pplog.jugem.cc/?eid=952
	keyRemap4MacBook
