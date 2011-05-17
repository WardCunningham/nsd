mkdir -p ../exhibits/records
rm ../exhibits/records/*
cat ../exhibits/files/01 | 
perl -ne '
	open F, ">../exhibits/records/$1" if /^([A-Z]{2,})/ and $1 ne "COMMON";
	print F;
'
