for dir in */;
do
    echo "$dir"
    cd $dir
    flutter pub get;
    cd ..
done