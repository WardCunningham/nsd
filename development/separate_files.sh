mkdir -p ../exhibits/files
tr '\r' '\n' < ../artifacts/original.txt | csplit -f '../exhibits/files/' - '/DATA/'
