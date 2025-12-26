

CREATE USER 'kfs_user'@'%' IDENTIFIED BY '$KFS_PASSWORD';

CREATE DATABASE kfs_artifactory CHARACTER SET utf8 COLLATE utf8_bin;
GRANT ALL on kfs_artifactory.* TO 'kfs_user'@'%';

CREATE DATABASE kfs_xray CHARACTER SET utf8 COLLATE utf8_bin;
GRANT ALL on kfs_xray.* TO 'kfs_user'@'%';

CREATE DATABASE kfs_catalog CHARACTER SET utf8 COLLATE utf8_bin;
GRANT ALL on kfs_catalog.* TO 'kfs_user'@'%';

FLUSH PRIVILEGES;
