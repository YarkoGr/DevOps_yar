
ROOT_PASS="yarkogr2402"
DB_HOST="192.168.56.10"
DB_NAME="moodledb"
DB_USER="admindb"
DB_PASS="yar2402"
DB_PORT=3306
WEB_DIR="/var/www/html"
MOODLE_DATA="/var/moodledata"
MOODLE_USER="Admin"
MOODLE_PASS="YarkoGR2402"
MOODLE_IP="192.168.56.11"

#apache
sudo yum -y update

sudo yum -y install httpd
sudo systemctl start httpd.service
sudo systemctl enable httpd.service

sudo yum -y install epel-release
sudo yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
sudo yum-config-manager --enable remi-php72
sudo yum -y update
sudo yum -y install php php-mysql php-common php-curl php-ldap php-apc php-dom php-xml php-xmlrpc php-gd php-intl php-mbstring php-soap php-zip php-opcache php-cli
sudo systemctl restart httpd.service

#moodle
sudo yum install wget -y
sudo mkdir /temp
cd /temp
sudo wget https://download.moodle.org/download.php/direct/stable35/moodle-latest-35.tgz -O moodle-latest.tgz
sudo rm -rf ${WEB_DIR}
sudo setsebool httpd_can_network_connect true
sudo tar -zxvf moodle-latest.tgz -C /temp
sudo mv /temp/moodle ${WEB_DIR}


sudo mkdir ${MOODLE_DATA}
sudo chown -R apache:apache ${MOODLE_DATA}
sudo systemctl restart httpd
cat <<EOF | sudo tee -a /etc/httpd/conf.d/moodle.conf
<VirtualHost *:80>
ServerAdmin admin@ss-test.com
DocumentRoot ${WEB_DIR}
ServerName moodle.ss-test.com
ServerAlias www.moodle.ss-test.com
<Directory ${WEB_DIR}>
Options FollowSymLinks
AllowOverride All
Order allow,deny
allow from all
</Directory>
ErrorLog /var/log/httpd/moodle-error_log
CustomLog /var/log/httpd/moodle-access_log common
</VirtualHost>
EOF

#Cofigure SElinux for Moodle
sudo yum install -y policycoreutils policycoreutils-python -y
sudo chcon -R -t httpd_sys_rw_content_t ${MOODLE_DATA}
sudo chcon -R -t httpd_sys_rw_content_t ${WEB_DIR}
sudo setsebool httpd_can_network_connect true

#Install Moodle CLI
sudo chown -R apache:apache ${WEB_DIR}
sudo -u apache /usr/bin/php ${WEB_DIR}/admin/cli/install.php \
--lang=uk \
--chmod=2777 \
--wwwroot=http://${MOODLE_IP}:80 \
--dataroot=${MOODLE_DATA} \
--dbtype=mariadb \
--dbhost=${DB_HOST} \
--dbport=${DB_PORT} \
--dbname=${DB_NAME} \
--dbuser=${DB_USER} \
--dbpass=${DB_PASS} \
--fullname=Moodle \
--shortname=MD \
--summary=Moodle \
--adminuser=${MOODLE_USER} \
--adminpass=${MOODLE_PASS} \
--non-interactive \
--agree-license

sudo systemctl restart httpd

echo "###"
echo "Moodle Host IP:    ${MOODLE_IP}"
echo "Moodle Login:      ${MOODLE_USER}"
echo "Moodle Pass:       ${MOODLE_PASS}"
echo "###"
echo "Data Base Host IP: ${DB_HOST}"
echo "Data Base Port:    ${DB_PORT}"
echo "Data Base Name:    ${DB_NAME}"
echo "Data Base Login:   ${DB_USER}"
echo "Data Base Pass:    ${DB_PASS}"
echo "###"