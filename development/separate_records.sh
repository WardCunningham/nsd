mkdir -p ../exhibits/records/includes ../exhibits/records/subroutines
rm ../exhibits/records/*/*
cat ../exhibits/files/01 | 
perl -ne '
	if (/^([A-Z]{2,})/) {
		if ($1 eq "COMMON") {
			$g = "includes/$f";
		} else {
			$f = $1;
			$g = "subroutines/$1";
		}
	} else {
		open F, ">../exhibits/records/$g" if $g ne $h;
		$h = $g;
		print F;
	}
'
