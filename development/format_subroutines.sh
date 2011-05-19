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


	for (<*>) {
		@lines = `cat $_`;
		shift @lines;
		my $class = $lines[0] eq "COMMON\n" ? (shift(@lines), "common") : "subroutine";
		print "<pre class = \"$class\" id = \"$_\">\n", map(fmt(),@lines), "</pre>\n";
		print stderr "$_ -- $class\n";
	}

	sub fmt {
		s/&/&amp;/g;
		s/</&lt;/g;
		s/^\*CALL,([A-Z]+)/*CALL,<a href=\"#$1\" class = \"include\">$1<\/a>/;
		s/\b(CALL\s+)([A-Z]+)(\s*(\(|$))/$1<a href=\"#$2\" class = \"call\">$2<\/a>$3/;
		$_;
	}

	print <<;
</body>
</html>

' > subroutines/index.html
