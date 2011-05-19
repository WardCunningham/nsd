cd ../exhibits
mkdir -p graphs
perl -e '
	chdir "records/subroutines";
	print <<;
digraph calls {
node [shape=box,style=filled,fillcolor=gold];

	for my $file (<*>) {
		print stderr "$file\n";
		@lines = `cat $file`;
		for (@lines) {
			# print "$file -> $1;\n" if /^\*CALL,([A-Z]+)/
			if (/\bCALL\s+ERROR\s*\((\d+)/) {
				# print "$file -> \"ERROR $1\"" unless $seen{"$file-ERROR $1"};
				next;
			}
			print "$file -> $2;\n" if /\b(CALL\s+)([A-Z]+)(\s*(\(|$))/ and !$seen{"$file-$2"}++;;
		}
		
	}

	print <<;
}

' > graphs/calls.dot
dot -Tsvg graphs/calls.dot -o graphs/calls.svg
