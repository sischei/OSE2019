for i  in $(seq 0 99)
do
  dd if=/dev/urandom of=input-data-${i} bs=1MB count=1
done
