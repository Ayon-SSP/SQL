# bash script to create 20 files with name 162338_Assignment_001.sql to 162338_Assignment_020.sql
# Run bash ./touch-assignment.sh

for i in {1..10}
do
  touch 162338_Assignment_$(printf "%03d" $i).sql
done