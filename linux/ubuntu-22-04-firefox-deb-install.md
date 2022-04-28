# Install Firefox via “Mozilla Team” team PPA

The team described that it has assumed responsibility for Ubuntu’s official Firefox and Thunderbird packages.

And, the Firefox and Firefox ESR package maintainer for “Mozilla Team” team PPA, Rico Tzschichholz, is a well-known Ubuntu user who also maintains the official pakages for LibreOffice, Plank dock, and unbound DNS server.

## Remove Firefox Snap

It’s OK to keep the default Snap package. But it will cause duplicated icons in search results.

NOTE: Export bookmarks and backup other important data before removing it!

To remove it, press Ctrl+Alt+T on keyboard to open terminal. Then, run the command:

```
sudo snap remove firefox
```

## Add Mozilla Team PPA

In terminal, run the command below to add the PPA. Type user password (no asterisk feedback) when it asks and hit Enter to continue.

```
sudo add-apt-repository ppa:mozillateam/ppa
```

As the PPA description indicates, the PPA was previously created for Firefox ESR and Thunderbird. It now contains the latest Firefox too.

## Install Firefox via apt
Tip: the commands in this step also installs Firefox for the old Ubuntu 16.04. Though sudo apt update need to be run first.

Finally, run the command below to install the latest Firefox package as deb:

```
sudo apt install -t 'o=LP-PPA-mozillateam' firefox
```

Here -t 'o=LP-PPA-mozillateam' specifies to install Firefox from that PPA. It’s required until you set higher PPA package priority (see next step).


## Set PPA priority:

The empty Firefox deb in Ubuntu’s official repository has version number 1:1snap1-0ubuntu2. It’s always higher than the PPA package version. Running package updates either via sudo apt upgrade or ‘Software Updater’ will automatically install the official one which redirects to Snap.

To workaround the issue, you have to set a higher PPA priority. To do so, run the command below in terminal (Ctrl+Alt+T):

```
sudo nano /etc/apt/preferences.d/mozillateamppa
```

The command creates and opens empty config file in Gedit text editor. When it opens, add the lines below and save it:

```
Package: firefox*
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 501
```
