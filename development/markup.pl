@lines = <>;
for (@lines) {
	s/\b[A-Z]+\b/<a href="#subroutines$&" class="subroutines">$&<\/a>/g;
	s/.+/<p>$&<\/p>/;
}
print @lines;