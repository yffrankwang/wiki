## gem install mimemagic failure

Could not find MIME type database in the following locations: ["/usr/local/share/mime/packages/freedesktop.org.xml", "/opt/homebrew/share/mime/packages/freedesktop.org.xml", "/opt/local/share/mime/packages/freedesktop.org.xml", "/usr/share/mime/packages/freedesktop.org.xml"]

solution: https://stackoverflow.com/questions/47026174/find-spec-for-exe-cant-find-gem-bundler-0-a-gemgemnotfoundexception

First, create a file named freedesktop.org.xml.

Then copy the file content found in this link and paste it into the file just created.

Finally, set the FREEDESKTOP_MIME_TYPES_PATH environment variable

Unix terminal:

	export FREEDESKTOP_MIME_TYPES_PATH=/path/to/freedesktop.org.xml

Command prompt:

	set FREEDESKTOP_MIME_TYPES_PATH="\path\to\freedesktop.org.xml" 


## How to solve "libxml2 missing package" error on "gem install ovirt-engine-sdk" on Windows?

https://stackoverflow.com/questions/54258576/how-to-solve-libxml2-missing-package-error-on-gem-install-ovirt-engine-sdk-o

```
$ gem fetch ovirt-engine-sdk
$ gem unpack ovirt-engine-sdk-4.3.0.gem
$ cat ovirt-engine-sdk-4.3.0/ext/ovirtsdk4c/extconf.rb
```

The relevant portion is here (found by searching for the error message):
```
xml2_config = find_executable('xml2-config')
if xml2_config
  # other stuff
elsif !pkg_config('libxml2')
  raise 'The "libxml2" package isn\'t available.'
end
```

We can see it's checking for an executable named xml2-config. According to the [documentation](http://ruby-doc.org/stdlib/libdoc/mkmf/rdoc/MakeMakefile.html#method-i-find_executable) 
for find_executable, it checks your path for that.

So, this means we need two things to fix this error:

The xml2-config executable
We need to add that to our path. It sounds like this is the step you're missing.
You can download from https://pages.lip6.fr/Jean-Francois.Perrot/XML-Int/Session1/WinLibxml.html - Then add the entire bin folder to your path.

