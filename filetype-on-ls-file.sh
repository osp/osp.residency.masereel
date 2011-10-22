for i in $(grep  '\:$' ls -lhR  | sed 's/://' | sed 's/ /:/g')
do echo -n "${i} " && ls /home/pierreh/"${i//:/ }" | wc -w
done

echo 