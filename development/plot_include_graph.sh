echo $0
mkdir -p data/graphs ../exhibits/graphs
perl -e '
	chdir "data/records/subroutines";
	print <<;
digraph calls {
node [shape=box,style=filled];

	for my $file (<*>) {
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

' > data/graphs/includes.dot
dot -Tsvg data/graphs/includes.dot -o ../exhibits/graphs/includes.svg
