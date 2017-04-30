./versions.sh
for i in "${versions[@]}"
do
  ./installR.sh $i
done
