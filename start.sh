sudo apt update || exit 1
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 10 || exit 1
sudo apt-get install -y python3-pip || exit 1
sudo update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1 || exit 1
pip install flask requests beautifulsoup4 pymongo || exit 1
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add - || exit 1
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list || exit 1
sudo apt update || exit 1
sudo apt install -y mongodb-org || exit 1
sudo service mongod start || exit 1
sudo iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 5000
sudo sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
sudo sed -i 's/#security:/security:\n  authorization: enabled/g' /etc/mongod.conf
sudo service mongod restart
