 npm err refusing to delete npm.cmd
------------------------------------
### error
	npm ERR! path C:\Program Files\nodejs\npm.cmd
	npm ERR! code EEXIST
	npm ERR! Refusing to delete C:\Program Files\nodejs\npm.cmd: is outside C:\Program Files\nodejs\node_modules\npm and not a link
	npm ERR! File exists: C:\Program Files\nodejs\npm.cmd
	npm ERR! Move it away, and try again.

### fix
	cd %ProgramFiles%\nodejs
	del npm npx npm.cmd npx.cmd
	move node_modules\npm node_modules\npm2
	node node_modules\npm2\bin\npm-cli.js i -g npm@latest
	rd /S /Q node_modules\npm2
	
