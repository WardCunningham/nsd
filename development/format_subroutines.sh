cd ../exhibits
mkdir -p subroutines
perl -e '
	chdir "records";
	print <<;
<html>
<head>
<link rel="stylesheet" type="text/css" href="style.css" />
</head>
<body>


	for (<*/*>) {
		next unless /(\w+)\/(\w+)/;
		@lines = `cat $_`;
		print "<pre class = \"$1\"id = \"$1$2\">\n", map(fmt(),@lines), "</pre>\n";
	}

	sub fmt {
		s/&/&amp;/g;
		s/</&lt;/g;
		s/^\*CALL,([A-Z]+)/*CALL,<a href=\"#includes$1\" class = \"includes\">$1<\/a>/;
		s/\b(CALL\s+)([A-Z]+)(\s*(\(|$))/$1<a href=\"#subroutines$2\" class = \"subroutines\">$2<\/a>$3/;
		$_;
	}

	print <<;
</body>
</html>

' > subroutines/index.html
