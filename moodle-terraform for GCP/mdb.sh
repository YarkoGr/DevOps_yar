
ROOT_PASS="yarkogr2402"
DB_NAME="moodledb"
DB_USER="admindb"
DB_PASS="yar2402"
MOODLE_HOST="192.168.56.11"
MOODLE_USER="Admin"
MOODLE_PASS="YarkoGR2402"

sudo yum update -y

#Install MariaDB
cat <<EOF | sudo tee -a /etc/yum.repos.d/MariaDB.repo
# MariaDB 10.3 CentOS repository list - created 2019-02-24 10:16 UTC
# http://downloads.mariadb.org/mariadb/repositories/
[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/10.3/centos7-amd64
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1
EOF

sudo yum install MariaDB-server MariaDB-client -y
sudo systemctl start mariadb.service
sudo systemctl enable mariadb.service
sudo /etc/init.d/mysql restart
sudo /usr/bin/mysqladmin -u root password ${ROOT_PASS}
mysql -u root -p${ROOT_PASS} -e \
"CREATE DATABASE ${DB_NAME} DEFAULT CHARACTER SET UTF8 COLLATE utf8_unicode_ci;\
CREATE USER '${DB_USER}' IDENTIFIED BY '${DB_PASS}';\
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}' IDENTIFIED BY '${DB_PASS}' WITH GRANT OPTION;\
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${ROOT_PASS}' WITH GRANT OPTION;\
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}@${MOODLE_HOST}' IDENTIFIED BY '${DB_PASS}' WITH GRANT OPTION;;\
FLUSH PRIVILEGES;"

mysql -u root -p${ROOT_PASS} -e "DROP USER ''@'localhost';"
mysql -u root -p${ROOT_PASS} -e "DROP USER ''@'$(hostname)';"
mysql -u root -p${ROOT_PASS} -e "DROP DATABASE test;"

sudo /etc/init.d/mysql restart