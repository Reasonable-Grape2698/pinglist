cat list.txt| tail -n +4 |  while read output
do
    echo $output":" && ping -qc1 $(echo $output | cut -d "#" -f 1) 2>&1 | awk -F'/' 'END{ print (/^rtt/? $5" ms":"FAIL") }'
done
