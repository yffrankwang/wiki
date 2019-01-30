 config
-------------------
### unset
	git config --global --unset core.autocrlf

### EOL
@see https://git-scm.com/book/en/v2/Customizing-Git-Git-Configuration
	git config --global core.autocrlf false

### save/cache credential
@see https://git-scm.com/docs/git-credential-store  
@see https://git-scm.com/book/ja/v2/Git-のさまざまなツール-認証情報の保存  

	$ git config --global credential.helper cache
	$ git config --global credential.helper store

### disable windows credential manager
@see https://stackoverflow.com/questions/37182847/how-to-disable-git-credential-manager-for-windows

	$ git config --system credential.helper store
	$ git config --system --unset credential.helper


 branch
--------------------
### create branch
	git checkout -b <name>

### create clean branch
	git checkout --orphan <name>

### show branch
	git branch

### checkout branch
	git checkout <name>


 tag
------------------------- 
### create lightweight tag
	git tag <name>

### create annotated tag
	git tag -a <name> -m <message>

### list tag
	git tag

### show tag
	git show <name>

### tag later
	git log --pretty=oneline
	git tag <name> <hash>

### checkout tag
	git checkout <name>

### push tag
	git push origin <name>
	git push origin --tags

 rebase
------------------------
### pull rebase
	git pull --rebase

### pull rebase default
	< 1.7.9
	git config --global branch.autosetuprebase always

	> 1.7.9
	git config --global pull.rebase true

### git pull force
	git pull
	git reset --hard origin/master

### git add remote
	git remote add origin git://original/repo.git
	git remote add other git://other/repo.git
	git remote set-url --add --push origin git://original/repo.git
	git remote set-url --add --push origin git://another/repo.git

### git rebase
	git rebase -i --root
	git rebase -i xxxx
	git commit --amend --no-edit --author="Frank Wang <yf.frank.wang@outlook.com>"
	git rebase --continue

### .gitignore ignore all files except one
	/cache/*
	!/cache/index.html


 submodule
------------------------------------
### git submodule
	git submodule add https://bitbucket.org/xxx/yyy.git  path/name
	git submodule update --init --recursive --remote

### change submodule url
	git config --file=.gitmodules submodule.Submod.url https://xxx/yyy
	git config --file=.gitmodules submodule.Submod.branch Develop
	git submodule sync
	git submodule update --init --recursive --remote


 history
-------------------------------------
### find file
	git log --all --full-history -- **/filename.ext


 windows
-------------------------------------
### chmod
	git update-index --chmod=+x <file>
