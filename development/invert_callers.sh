mkdir -p data/callers
perl -e '
	chdir "data/records/subroutines";
	for my $file (<*>) {
		print stderr "$file\n";
		@lines = `cat $file`;
		for (@lines) {
			# print "$file -> $1;\n" if /^\*CALL,([A-Z]+)/
			$callers{$2}.="$file\n" if /\b(CALL\s+)([A-Z]+)(\s*(\(|$))/ and !$seen{"$file-$2"}++;;
		}
		
	}
	chdir "../../callers";
	for (keys %callers) {
		open F, ">$_";
		print F $callers{$_};
	}

'
touch data/callers/MAIN
touch data/callers/BLKDATA