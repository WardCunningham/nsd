cd ../exhibits
mkdir -p graphs/blocks
mkdir -p graphs/blocks/dots
cd records/subroutines
for i in *
do echo $i
	perl ../../../development/scripts/block_graph.pl $i |
	tee ../../graphs/blocks/dots/$i.dot |
	dot -Tsvg -o ../../graphs/blocks/$i.svg
done

# try /usr/local/bin/dot or /usr/bin/dot