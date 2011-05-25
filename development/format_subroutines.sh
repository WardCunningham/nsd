mkdir -p ../exhibits/subroutines
perl -e '
	chdir "data/records";
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
		print "<pre class=\"$1\" id=\"$1$2\">\n", map(fmt(),@lines), "</pre>\n";
	}

	sub fmt {
		s/&/&amp;/g;
		s/</&lt;/g;
		s/^\*CALL,([A-Z]+)/*CALL,<a href=\"#includes$1\" class=\"includes\">$1<\/a>/;
		s/\b(CALL\s+)([A-Z]+)(\s*(\(|$))/call()/eo;
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
