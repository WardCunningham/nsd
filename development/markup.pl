@lines = <>;
for (@lines) {
	s/\b[A-Z]+\b/anchor()/geo;
	s/.+/<p>$&<\/p>/;
}
print @lines;

sub anchor {
	return "<a href=\"#subroutines$&\" class=\"subroutines records\">$&</a>" if -f "data/records/subroutines/$&";
	return $&;
}
