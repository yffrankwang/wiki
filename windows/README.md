### To completely uninstall OneDrive

	taskkill /f /im OneDrive.exe
	
 - 32bit windows
	%SystemRoot%\System32\OneDriveSetup.exe /uninstall

 - 64bit windows
	%SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall
	

### USB keyboard layout incorrectly changes to English 101

	http://support.microsoft.com/kb/822190/en-us


### Shell Startup

	Win+R> shell:startup

Autostart for currently logged-on user:
	shell:startup = %appdata%\Microsoft\Windows\Start Menu\Programs\Startup

And startup folder all users:
	shell:common startup = %programdata%\Microsoft\Windows\Start Menu\Programs\Startup


### SendTo folder

	%APPDATA%\Microsoft\Windows\SendTo


### Always use classic logon:

	gpedit.msc 
	-> Computer Configuration 
	-> Admiministrative Templates 
	-> System
	-> Logon 
	-> Always use classic logon
	

### Hibernate off

	powercfg.exe -h off


### Find known WIFI password

	netsh wlan show profiles
	netsh wlan show profile name=<profilename> key=clear


### Uninstall Language Packs

	Lpksetup /u


### RemoteDesktop "CredSSP encryption oracle remediation" error
https://support.microsoft.com/en-us/help/4295591/credssp-encryption-oracle-remediation-error-when-to-rdp-to-azure-vm

> REG ADD HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System\CredSSP\Parameters\ /v AllowEncryptionOracle /t REG_DWORD /d 2


### Change DNS server with command prompt

	netsh
	interface ip show config
	interface ip set dns "Ethernet0" static 8.8.8.8
