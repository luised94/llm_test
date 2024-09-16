# Installing dependencies
sudo apt-get update
sudo apt-get install libx11-dev
sudo apt-get install magick # I forgot which one but it was required for magick R package.

./configure --with-x --x-includes=/usr/include/X11 --x-libraries=/usr/lib/X11
make
sudo make install
