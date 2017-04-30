./versions.sh
for i in "${versions[@]}"
do
  ./r-builds/R-$i/bin/R -f code.R --args $i
done
