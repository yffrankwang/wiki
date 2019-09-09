# Mojave
	hdiutil create -o /tmp/Mojave -size 8000m -layout SPUD -fs HFS+J
	hdiutil attach /tmp/Mojave.dmg -noverify -mountpoint /Volumes/install_build
	sudo /Applications/Install\ macOS\ Mojave.app/Contents/Resources/createinstallmedia --volume /Volumes/install_build
	hdiutil detach /Volumes/Install\ macOS\ Mojave
	hdiutil convert /tmp/Mojave.dmg -format UDTO -o ~/Downloads/Mojave
	mv ~/Downloads/Mojave.cdr ~/Downloads/Mojave.iso
	zip -s 1g ~/Downloads/Mojave.zip ~/Downloads/Mojave.iso
