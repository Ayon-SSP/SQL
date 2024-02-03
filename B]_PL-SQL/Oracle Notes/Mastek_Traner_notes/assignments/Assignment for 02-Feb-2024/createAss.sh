# bash script to create 20 files with name Assignment_001.sql to Assignment_020.sql
# Run bash ./createAss.sh

for i in {1..20}
do
  touch Assignment_$(printf "%03d" $i).sql
done