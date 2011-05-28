echo $0
mkdir -p data/graphs ../exhibits/graphs
perl -e '
	chdir "data/records/subroutines";
	print <<;
digraph calls {
node [shape=box,style=filled];

	for my $file (<*>) {
		print "$file [fillcolor=gold URL=\"blocks/$file.svg\"];\n" unless $file eq "BLKDATA";
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

' > data/graphs/calls.dot
dot -Tsvg data/graphs/calls.dot -o ../exhibits/graphs/calls.svg
