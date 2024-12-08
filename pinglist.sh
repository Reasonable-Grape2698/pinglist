while read -r line
do
    export ping=$(ping -4 -qc1 $(echo $output | cut -d "#" -f 1) 2>&1 | awk -F'/' 'END{ print (/^rtt/? $5:"FAIL") }')
    echo $output":" $ping" ms"
    export total=$(echo "$total+$ping" | bc)
    export count=$(echo "$count+1" | bc)
done < <(cat list.txt| tail -n +4 | )

echo "Total: " $total
echo "Average: " $(echo "$total/$count" | bc)
