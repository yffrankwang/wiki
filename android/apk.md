### Version Codes
	http://developer.android.com/reference/android/os/Build.VERSION_CODES.html

### which aapt
	android-sdk/build-tools/23.0.1/aapt

### aapt dump xmltree
	aapt dump xmltree some.apk AndroidManifest.xml

### Get minSdkVersion from apk
	aapt dump badging some.apk | grep sdk
	aapt dump badging some.apk | findstr /C:sdk

### Get application label from apk
	aapt dump badging some.apk | grep application-label


### Get package name from apk
	aapt dump badging some.apk | grep package
