# Set the BIOS clock to local time instead of UTC in a systemd-based version (15.04 and above)

You can set the hardware clock time standard through the command line. You can check what you have set to use by:
$ timedatectl | grep local

The hardware clock can be queried and set with the timedatectl command. To change the hardware clock time standard to localtime, use:
$ timedatectl set-local-rtc 1

If you want to revert to the hardware clock being in UTC, do:
$ timedatectl set-local-rtc 0
