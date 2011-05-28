echo $0
mkdir -p data/files
tr '\r' '\n' < ../artifacts/original.txt | csplit -f 'data/files/' - '/DATA/'
