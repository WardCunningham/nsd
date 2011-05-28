echo $0
mkdir -p data/info
perl -i -n -e 'if ($. >= 70 and $. <= 94) {print stderr} else {print}' data/records/subroutines/MAIN 2>data/info/errors
perl -i -n -e 'if ($. >= 47 and $. <= 69) {print stderr} else {print}' data/records/subroutines/MAIN 2>data/info/limitations
perl -i -n -e 'if ($. >= 26 and $. <= 46) {print stderr} else {print}' data/records/subroutines/MAIN 2>data/info/library
perl -i -n -e 'if ($. >= 6 and $. <= 25) {print stderr} else {print}' data/records/subroutines/MAIN 2>data/info/conventions
