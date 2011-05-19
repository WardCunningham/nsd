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
		shift @lines;
		next if $lines[0] eq "COMMON\n";
		for (@lines) {
			next unless /^\*CALL,([A-Z]+)/;
			if ($file eq "BLKDATA") {
				print "$file -> \"/$1/\";\n";
			} else {
				print "\"/$1/\" -> $file;\n";
			}
		}
		
	}

	print <<;
}

' > graphs/includes.dot
dot -Tsvg graphs/includes.dot -o graphs/includes.svg
