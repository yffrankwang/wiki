 Creating a Swap File
-----------------------

First, create a file which will be used as swap space:

	sudo fallocate -l 2G /swapfile

If the fallocate utility is not available on your system or you get an error message saying fallocate failed: Operation not supported, use the following command to create the swap file:

	sudo dd if=/dev/zero of=/swapfile bs=1024 count=2097152

Ensure that only the root user can read and write the swap file:

	sudo chmod 600 /swapfile

Next, set up a Linux swap area on the file:

	sudo mkswap /swapfile

Run the following command to activate the swap:

	sudo swapon /swapfile

Make the change permanent by opening the /etc/fstab file:

	echo '/swapfile swap swap defaults 0 0' | sudo tee -a /etc/fstab

Verify that the swap is active by using either the swapon or the free command as shown below:

	sudo swapon --show
	sudo free -h


 Adjusting the Swappiness Value
---------------------------------

Swappiness is a Linux kernel property that defines how often the system will use the swap space. Swappiness can have a value between 0 and 100. A low value will make the kernel to try to avoid swapping whenever possible while a higher value will make the kernel to use the swap space more aggressively.

The default swappiness value on CentOS 7 is 30. You can check the current swappiness value by typing the following command:

	cat /proc/sys/vm/swappiness

While the swappiness value of 30 is OK for desktop and development machines, for production servers you may need to set a lower value.

For example, to set the swappiness value to 10, type:

	sudo sysctl vm.swappiness=10

To make this parameter persistent across reboots append the following line to the /etc/sysctl.conf file:

	vm.swappiness=10



 Removing a Swap File
---------------------------------

To deactivate and remove the swap file, follow these steps:

Start by deactivating the swap space by typing:

	sudo swapoff -v /swapfile


Next, remove the swap file entry /swapfile swap swap defaults 0 0 from the /etc/fstab file.

Finally, delete the actual swapfile file:

	sudo rm /swapfile

