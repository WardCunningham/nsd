my $sub = $ARGV[0];
my @callers = ('MAIN','ZOOM','INCMND');
$mode = 'code';

# scan source detecting alternating blocks of comments and code

open F, "$sub" or die($!);
for (<F>) {
	next if /^\d+\s+(FORMAT|CONTINUE)/;
	next if /^C     GOTO 902/;
	if (/^C\s*$/){
		$blanks++;
		next;
	}
	if (/^C\s*(.+)$/) {
		if ($mode eq 'code') {
			$mode = 'comments';
			$n++;
			$sequence{$b} = "b$n" unless ($n==1) or ($prev =~ /^\s+GOTO|RETURN/);
			$b = "b$n";
		}
		$comments{$b} .= "$1\\n" unless $blanks > 1;
	} else {
		$mode = 'code';
		$blanks = 0;
		$return{$b} = 'RET' if /RETURN/;
		$called{$b} .= "$1 " if /CALL (\w+)/ and -f $1 and !$mark{"$b called $1"}++;
		$used{$b} .= "$1 " if /CALL (\w+)/ and !-f $1 and !$mark{"$b used $1"}++;
		$goto{$b} .= "$1 " if /GOTO (\d+)/ and !$mark{"$b goto $1"}++;
		$goto{$b} .= "$1 " if /DO (\d+)/ and !$mark{"$b goto $1"}++;
		if (/GOTO \(/) {while (/\b(\d+)\b/g) {$goto{$b} .= "$1 " if !$mark{"$b goto $1"}++;}}
		$label{$b} .= "$1 " if /^(\d+)/ and !$mark{"$1 labeled $b"}++;
		$prev = $_;
	}
}

# convert hash elements to dot commands

my $callers = join '', map "$_ -> $sub;\n$_ [URL=\"$_.svg\"]\n", @callers; 
my $comments = join '', map "$_ [label=\"" . fold($comments{$_}) . "\"];\n", sort keys %comments;
my $sequence = join '', map "$_ -> $sequence{$_};\n", sort keys %sequence;
my $return = join '', map "$_ -> $return{$_};\n", sort keys %return;
for $i (sort keys %called) {$called .= join('', map("$i -> $_\n$_ [URL=\"$_.svg\"]", split(' ', $called{$i})))};
for $i (sort keys %used) {$used .=  join('', map("$i -> $_\n", split(' ', $used{$i})))};
for $i (sort keys %goto) {$goto .=  join('', map("$i -> $_\n", split(' ', $goto{$i})))};
for $i (sort keys %label) {$label .=  join('', map("$_ -> $i\n", split(' ', $label{$i})))};

sub fold {
	return $_[0] if $_ eq 'b1';
	local $_ = $_[0];
	s/ *\\n$//;
	s/ {2,}/ /g;
	s/ (\S{3,})/\\n$1/g;
	return $_;
}

# assemble dot commands into complete file with styling

print <<EOF;
digraph draw {
	
#callers
node [shape=rectangle style=filled fillcolor=gold]
$sub [penwidth=2 URL="../../subroutines/#subroutines$sub"]
$callers

#comments
node [fillcolor=white penwidth=0]
$sub -> b1;
$comments

#called
node [fillcolor=gold penwidth=1]
$called

#used
node [fillcolor=lightgray]
$used

#goto
node [shape=circle fillcolor=lightgray penwidth=0]
$goto

#label
$label

#sequence
$sequence

#return
$return

}
EOF
