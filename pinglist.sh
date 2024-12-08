export total=0
export count=0
export min=999
export max=0
while read output
do
    export ping=$(ping -4 -qc1 $(echo $output | cut -d "#" -f 1) 2>&1 | awk -F'/' 'END{ print (/^rtt/? $5:"FAIL") }')
    echo $output":" $ping" ms"
    export total=$(echo "$total+$ping" | bc)
    export count=$(echo "$count+1" | bc)
    if (( $(echo "$ping" != "FAIL" | bc -l) ))
    then
        if (( $(echo "$ping < $min" | bc -l) ))
        then
            min=$ping
        fi
        if (( $(echo "$ping > $max" | bc -l) ))
        then
            max=$ping
        fi
    fi
done < <(cat list.txt| tail -n +4)

echo "min/avg/max/total" $min"/"$(echo "$total/$count" | bc)""/""$max"/""$total"
