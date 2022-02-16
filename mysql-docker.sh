# Backup
docker exec CONTAINER /usr/bin/mysqldump -u root --password=root DATABASE > backup.sql

# Restore
cat backup.sql | docker exec -i CONTAINER /usr/bin/mysql -u root --password=root DATABASE

# Rename host
sed -i 's/https:\/\/olddomain/https:\/\/newdomain/g' backup.sql

#Fix ssl errors

echo "define('FORCE_SSL_ADMIN', true);
if (!empty($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] === 'https') {
	$_SERVER['HTTPS'] = 'on';
}" >> /wordpress/wp-config.php
