mkdir -p data/records/includes data/records/subroutines
rm data/records/*/*
cat data/files/01 | 
perl -ne '
	if (/^([A-Z]{2,})/) {
		if ($1 eq "COMMON") {
			$g = "includes/$f";
		} else {
			$f = $1;
			$g = "subroutines/$1";
		}
	} else {
		open F, ">data/records/$g" if $g ne $h;
		$h = $g;
		print F;
	}
'
