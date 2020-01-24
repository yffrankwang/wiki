https://linuxnewbieguide.org/how-to-mount-macos-apfs-disk-volumes-in-linux/

### prepare

	sudo apt update
	sudo apt install fuse libfuse-dev libicu-dev bzip2 libbz2-dev cmake clang git libattr1-dev

### Now we can download (clone) the driver source code with git:

	git clone https://github.com/sgan81/apfs-fuse.git
	cd apfs-fuse
	git submodule init
	git submodule update

### After that’s done, it’s time to compile the downloaded source code:

	mkdir build
	cd build
	cmake .. -DUSE_FUSE3=OFF
	make

### After compilation, the binaries are located in the build directory. I recommend copying the apfs* tools into a directory that can be accessed in the path, for example /usr/local/bin. To copy them simply do this:

	sudo cp apfs-* /usr/local/bin

### Now we need to find out which disk partition macOS is on. By using the fdisk -l command you’ll be able to see the layout of the disk.

	fdisk -l

~~~
Disk /dev/sda: 465.9 GiB, 500277790720 bytes, 977105060 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
Disklabel type: gpt
Disk identifier: 6153AD88-FE14-4E88-8D9A-60E8AA465516

Device         Start       End   Sectors   Size Type
/dev/sda1         40    409639    409600   200M EFI System
/dev/sda2     409640 764593231 764183592 364.4G unknown
/dev/sda3  764594176 781570047  16975872   8.1G Microsoft basic data
/dev/sda4  781832192 976842751 195010560    93G Microsoft basic data
~~~

You can see in my example above that there is a 364.4GB unknown partition. I know that this is my macOS partition because I know that the size of my macOS partition is 365GB. This means that the device identifier is /dev/sda2, so that’s what we will mount.

### Let’s check it out and see if it works….

	sudo mkdir -p /media/$USERNAME/macos
	sudo ./apfs-fuse -o allow_other /dev/sda2 /media/<your userame>/macos

Hopefully, all going well, you won’t have received any error messages at this point. If you have, then perhaps the README file can provide some enlightenment.
You can see that the macos partition is now mounted in the File browser.
Making it stick

### If you want to have your macos partition automatically mount every time you start up you computer, then you’ll need to edit into your filesystem table (fstab). To do this, we will need to make a symlink to the apfs mount tool, and then edit the fstab (if you don’t have nano, use vim):

	sudo ln -s /usr/local/bin/apfs-fuse /usr/sbin/mount.apfs
	sudo nano /etc/fstab

Add a line at the bottom of the file (all on one line) that says this:

	mount.apfs#/dev/sda2    /media/<your username>/macos/    fuse    user,allow_other        0       0

If you want to see if that works immediately just unmount the disk (see the cleaning up section below). Then type sudo mount -a to mount the disk from the fstab.
Getting to know your partition

When the partition is mounted, you will see two directories, private-dir and root. The directory root is the one you want. Inside there is the root filesystem of your mac. You’ll find your stuff in the ‘Users’ folder.
Cleaning up (Unmounting)

### To unmount the macos directory properly, you should use the fusermount command:

	fusermount -u /media/<your username>/macos
