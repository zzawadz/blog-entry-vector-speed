RBUILDDIR=r-builds
RSOURCES=r-sources

VERSION=$1
MAINVERSION=${1:0:1}
LINK=https://cran.r-project.org/src/base/R-$MAINVERSION/R-$VERSION.tar.gz

echo "Trying $LINK"
[ -d $RSOURCES ] || mkdir $RSOURCES
wget -P $RSOURCES $LINK


[ -d $RBUILDDIR ] || mkdir $RBUILDDIR
tar -zxf $RSOURCES/R-$VERSION.tar.gz -C $RBUILDDIR/

cd $RBUILDDIR/R-$VERSION/

# Configure and build R
./configure
make

cd ../..
