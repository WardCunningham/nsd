git push
ssh c2.com '
	cd web/nsd/development
	git pull origin master
	sh make.sh
'
