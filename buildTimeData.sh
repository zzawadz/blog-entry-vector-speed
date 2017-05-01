versions=( 3.3.3 3.4.0 )
for i in "${versions[@]}"
do
  ./r-builds/R-$i/bin/R -f code.R --args $i
done
