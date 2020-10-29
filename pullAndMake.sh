rm -r build
git stash
 
rm -r build
git pull origin master
mkdir build
 
cd build && qmake ../ && make 
