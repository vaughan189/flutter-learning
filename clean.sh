for dir in */;
do
    echo "Cleaning $dir"
    cd $dir
    flutter clean;
    cd ..
done
