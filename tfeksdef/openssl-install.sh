#!/bin/bash
##### openssl v1.1.1k re-install #####
sudo yum remove openssl -y
wget https://www.openssl.org/source/openssl-1.1.1k.tar.gz
tar xvfz ./openssl-1.1.1k.tar.gz
cd ./openssl-1.1.1k
./config shared zlib
sudo yum -y install gcc zlib-devel
sudo make && sudo make install
echo "/usr/local/lib64/" | sudo tee -a /etc/ld.so.conf > /dev/null
sudo ldconfig -v
sudo ln -s /usr/local/bin/openssl /bin
sudo cp /usr/local/lib64/*.so.1.1 /usr/lib64/
openssl version

cat > ~/openssl.sh << EOF
export OPENSSL_PATH="/usr/local/bin/openssl"
export OPENSSL_ROOT_DIR="/usr/local/ssl"
export OPENSSL_LIBRARIES="/usr/local/lib/"
export OPENSSL_INCLUDE_DIR="/usr/local/include/openssl/"
PATH=$PATH:$OPENSSL_PATH
EOF

sudo mv ~/openssl.sh /etc/profile.d/openssl.sh
chmod 755 /etc/profile.d/openssl.sh
rm -rf /tmp/openssl-1.1.1k*