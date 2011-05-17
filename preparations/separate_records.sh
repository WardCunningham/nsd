mkdir -p ../exhibits/records
cat ../exhibits/files/01 | 
perl -ne '
	open F, ">../exhibits/records/$1" if /^(DATA|STACK|BOX|SEGS|MOUSE|FILE|MAIN)/;
	print F;
'
