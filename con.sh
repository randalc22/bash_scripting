#! /bin/bash 

declare -A input

var=`awk '{print $0}' $1`

count=1


echo "Unsorted array:"

for i in $var; do

	input[${count}]=${i}

#	echo "Key ${count} -> ${input[${count}]}"

        echo -n "${input[${count}]} "

        count=$((${count}+1))

done

readarray -t sorted < <(printf '%s\n' "${input[@]}" | sort -n)

echo ""
echo "Sorted array:"
echo "${sorted[*]}"

start=${sorted[0]}

j=0

# Calculate length of array
length=${#sorted[@]}

echo ""
echo "Number of elements: ${length}"
echo ""
echo "Consolidated array:"

while [[ j -lt ${length} ]]; do

	delta=$((${sorted[$((${j}+1))]} - ${sorted[${j}]}))

if [[ ${delta} -eq 1 ]]; then

	j=$((${j}+1))	
else

	finish=${sorted[${j}]}

	if [[ ${start} -ne ${finish} ]]; then 

		echo -n "${start}-${finish} "

	else
		echo -n "${start} "

	fi

	start=${sorted[$((${j}+1))]}

	j=$((${j}+1))

fi

done

echo ""
