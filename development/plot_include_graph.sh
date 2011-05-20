cd ../exhibits
mkdir -p graphs
perl -e '
	chdir "records/subroutines";
	print <<;
digraph calls {
node [shape=box,style=filled];

	for my $file (<*>) {
		print stderr "$file\n";
		@lines = `cat $file`;
		for (@lines) {
			next unless /^\*CALL,([A-Z]+)/;
			print "$file [fillcolor=gold URL=\"../subroutines/#subroutines$file\"];\n" unless $done{$file};
			print "\"/$1/\"[URL=\"../subroutines/#includes$1\"];" unless $done{"/$1/"};
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
