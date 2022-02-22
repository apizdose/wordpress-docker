#Generate ssl certs

sudo openssl req -x509 -nodes -days 365000 -newkey rsa:2048 -keyout ./nginx-selfsigned.key -out ./nginx-selfsigned.crt

# Backup
docker exec CONTAINER /usr/bin/mysqldump -u root --password=root DATABASE > backup.sql

# Restore
cat backup.sql | docker exec -i CONTAINER /usr/bin/mysql -u root --password=root DATABASE

# Rename host
sed -i 's/https:\/\/olddomain/https:\/\/newdomain/g' backup.sql

#Fix ssl errors

echo "define('FORCE_SSL_ADMIN', true);
if (strpos($_SERVER['HTTP_X_FORWARDED_PROTO'], 'https') !== false)
$_SERVER['HTTPS']='on';" >> wordpress/wp-config.php
