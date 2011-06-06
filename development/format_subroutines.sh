echo $0
mkdir -p ../exhibits/subroutines
perl -e '
	chdir "data/records";
	@vars = `cat subroutines/BLKDATA`;
	for (@vars) {
		$vars{$1} = "$1$2 -- $3" if /C\s+(\w+)(\(.*?\))? - (.*)/;
	}
	$vars = join("|", sort keys %vars);
	print <<;
<!DOCTYPE HTML>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>nsd</title>
    <link rel="stylesheet" type="text/css" href="style.css" />
    <script type="text/javascript" src="jquery.min.js"></script>
    <script type="text/javascript" src="nsd.js"></script>
</head>
<body>


	for (<*/*>) {
		next unless /(\w+)\/(\w+)/;
		@lines = `cat $_`;
        print "<div class=\"wrapper $1\" id=\"$1$2\">\n";
		print "    <pre>\n", map(fmt(),@lines), "    </pre>\n";
		$nariative = -f "../../interpretation/records/$_" ? `cd ../..; perl markup.pl <interpretation/records/$_` : <<;
			Fiery the Angels rose, & as they rose deep thunder rolled
			Around their shores: indignant burning with the fires of Orc
			And Bostons Angel cried aloud as they flew through the dark night.

        print "    <div class=\"narrative\">\n$nariative\n    </div>\n";
        print "</div>\n";
	}

	sub fmt {
		s/&/&amp;/g;
		s/</&lt;/g;
		s/^\*CALL,([A-Z]+)/*CALL,<a href=\"#includes$1\" class=\"includes\">$1<\/a>/;
		s/\b(CALL\s+)([A-Z]+)(\s*(\(|$))/call()/eo;
		s/\b($vars)\b/<span class="global" global="$1">$1<\/span>/g;
		$_;
	}

	sub call {
		if (-f "subroutines/$2") {
			"$1<a href=\"#subroutines$2\" class=\"subroutines\">$2<\/a>$3"
		} else {
			"$1$2$3"
		}
	}

	print <<;
</body>
</html>

' > ../exhibits/subroutines/index.html
