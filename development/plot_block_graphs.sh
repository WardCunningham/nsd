echo $0
mkdir -p data/graphs/blocks ../exhibits/graphs/blocks
cd data/records/subroutines
for i in *
do
	perl ../../../block_graph.pl $i |
	tee ../../../data/graphs/blocks/$i.dot |
	dot -Tsvg -o ../../../../exhibits/graphs/blocks/$i.svg
done
