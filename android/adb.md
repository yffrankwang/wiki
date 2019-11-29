### log time

	adb logcat -v time


### log tag

	adb logcat TAG:V *:S


### block docomo packages

	adb shell pm list packages -s | grep docomo
	adb shell pm block <package>
