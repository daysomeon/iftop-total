#!/bin/bash
mkdir iftop_data 2>/dev/null
while :
do
	now_time=$(date +%s)
	iftop -i eth0 -t  -nN  -s 40 -u bytes -B > iftop_data/$now_time
	awk -v t=${now_time} '{if($0~/Total send rate:/)if($6~/KB/){printf("%d:%s\n",$6*1024,t)}else if($6~/MB/){printf("%d:%s\n",$6*1024*1024,t)}else{printf("%d:%s\n",$6,t)}}' iftop_data/$now_time >> send_rate.data
	
	awk -v t=${now_time} '{if($0~/Total receive rate:/)if($6~/KB/){printf("%d:%s\n",$6*1024,t)}else if($6~/MB/){printf("%d:%s\n",$6*1024*1024,t)}else{printf("%d:%s\n",$6,t)}}' iftop_data/$now_time  >> recv_rate.data
	
	awk -v t=${now_time} '{if($0~/Peak rate /)if($4~/KB/){printf("%d:%s\n",$4*1024,t)}else if($4~/MB/){printf("%d:%s\n",$4*1024*1024,t)}else{printf("%d:%s\n",$4,t)}}' iftop_data/$now_time >> send_peak.data
	
	awk -v t=${now_time} '{if($0~/Peak rate /)if($5~/KB/){printf("%d:%s\n",$5*1024,t)}else if($5~/MB/){printf("%d:%s\n",$5*1024*1024,t)}else{printf("%d:%s\n",$5,t)}}' iftop_data/$now_time >> recv_peak.data
done
