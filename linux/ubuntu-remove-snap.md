# Disabling Snaps in Ubuntu 20.10 (and 20.04 LTS)

https://www.kevin-custer.com/blog/disabling-snaps-in-ubuntu-20-04/


## Intro

Don't get me wrong, snaps are great in theory - If you aren't familiar, a snap package is like a sandboxed application that is packaged in such a way that:

 - You can be sure you're running exactly what the app developer intended, as all dependencies and assets are bundled into the snap application package
 - The snap application generally doesn't own your entire system, it runs in an application sandbox of sorts
 - Snaps are cross-platform and distributed independently from apt/deb packages, and as such are usually more up to date than those found in apt

Now this all sounds great, and it is in some ways (especially for app developers), but it comes at a cost: and that is generally performance and annoyances with application theming, access to user folders, and the like. I personally find that if I want to run a sandboxed application I lean more toward Flatpak as it is more performant and seems a bit more mature than Canonical's snap system.

In any event, I usually disable snaps entirely on a fresh install of Ubuntu, and I'll show you how to do that in the new Ubuntu 20.04 release.


## Remove existing Snaps

On a fresh Ubuntu install, a few snaps come preinstalled. You can see the list of them using snap list:
~~~
kevin@olubuntu2004:~$ snap list
Name               Version             Rev    Tracking         Publisher   Notes
core               16-2.49.1           10908  latest/stable    canonical✓  core
core18             20210128            1988   latest/stable    canonical✓  base
gnome-3-34-1804    0+git.3556cb3       66     latest/stable    canonical✓  -
gtk-common-themes  0.1-50-gf7627e4     1514   latest/stable    canonical✓  -
snap-store         3.38.0-59-g494f078  518    latest/stable/…  canonical✓  -
~~~

~~~
kevin@olubuntu2010:~$ snap list
Name               Version             Rev   Tracking         Publisher   Notes
core18             20200724            1885  latest/stable    canonical✓  base
gnome-3-34-1804    0+git.3556cb3       60    latest/stable/…  canonical✓  -
gtk-common-themes  0.1-36-gc75f853     1506  latest/stable/…  canonical✓  -
snap-store         3.36.0-82-g80486d0  481   latest/stable/…  canonical✓  -
snapd              2.47.1              9721  latest/stable    canonical✓  snapd
~~~

To remove these, you will need them using sudo snap remove <package>.

Run the following command to remove them all (the order of removal seems to be of importance here):
```sh
sudo systemctl stop snapd
sudo snap remove snap-store
sudo snap remove gtk-common-themes
sudo snap remove gnome-3-34-1804
sudo snap remove core18
sudo snap remove snapd
```

Typing snap list now should show the following:
~~~
kevin@olubuntu2010:~$ snap list
No snaps are installed yet. Try 'snap install hello-world'.
~~~

## Unmount the snap mount points

If running Ubuntu 20.04 LTS, you may need to perform this step. I did not see the need on 20.10.
Ubuntu 20.04 LTS

You'll need to replace the xxxx with the actual ID inside the core directory on your system, which you can find out by running df
```
sudo umount /snap/core/xxxx
```

Ubuntu 20.10

In Ubuntu 20.10, I found that this is now under /var/snap. Simply run:
```
sudo umount /var/snap
```

## Remove and purge the snapd package

Next, to remove the snapd package and all of its related services, run:
```
sudo apt purge snapd
```

## Remove any lingering snap directories

Finally, you can remove the remaining snap directories on the system. You may not have any of these directories after step 3, and that's okay. I didn't have these directories on a fresh Ubuntu 20.04 install once snapd was removed, but your mileage may vary.
```
rm -rf ~/snap
sudo rm -rf /snap
sudo rm -rf /var/snap
sudo rm -rf /var/lib/snapd
```

## Gotchas

If you are a user of the Chromium browser, you will want to add the PPAs before installing the browser, as installing the default chromium-browser package will automatically reinstall snapd ... eww!
