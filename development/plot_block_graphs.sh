mkdir -p data/graphs/blocks ../exhibits/graphs/blocks
cd data/records/subroutines
for i in *
do echo $i
	perl ../../../block_graph.pl $i |
	tee ../../../data/graphs/blocks/$i.dot |
	/usr/local/bin/dot -Tsvg -o ../../../../exhibits/graphs/blocks/$i.svg
done

# try /usr/local/bin/dot or /usr/bin/dot