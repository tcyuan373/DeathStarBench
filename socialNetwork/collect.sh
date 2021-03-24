#!/bin/bash

start=`date +%s`

for R in $(seq 10k 11k 12k 13k 14k 15k 16k 17k 18k 19k 20k)
do
	./wrk2/wrk -D exp -t 64 -c 128 -d 10s -L -s ./scripts/social-network/read-home-timeline.lua http://localhost:8080/wrk2-api/home-timeline/read -R $R 
done


for R in $(seq 10k 11k 12k 13k 14k 15k 16k 17k 18k 19k 20k)
do
	./wrk2/wrk -D exp -t 64 -c 128 -d 10s -L -s ./scripts/social-network/read-user-timeline.lua http://localhost:8080/wrk2-api/user-timeline/read -R $R 
done


end=`date +%s`
runtime=$((end-start))
python query_csv_all.py http://localhost:9090 $runtime | gzip > output/$(date +"%Y_%m_%d_%I_%M_%S_%p")_metrics.gz