@lines = <>;
for (@lines) {
	s/\b[A-Z]+\b/anchor()/geo;
	s/\b[a-zA-Z0-9\.\-\/]+\.(png|jpg|gif)\b/<img src="$&" \/>/g;
	s/\b($vars)\b/<span class="global" global="$1">$1<\/span>/g;
	s/.+/<p>$&<\/p>/;
}
print @lines;

sub anchor {
	return "<a href=\"#subroutines$&\" class=\"subroutines records\">$&</a>" if -f "data/records/subroutines/$&";
	return $&;
}
