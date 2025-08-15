

# guide - https://jfrog.com/help/r/artifactory-how-to-unlock-a-user-s-who-is-locked-out-of-artifactory-and-recover-admin-account/non-admin-user-recovery

# cd $JFROG_HOME/artifactory/var/etc/access

# e.g.
# cd ./k3s-data-dir/storage/pvc-xxx-artifactory...
# cd var/etc/access

# cat << EOF > bootstrap.creds
# admin@*=password
# admin1@*=password
# EOF

# or

# vi bootstrap.creds
# admin@*=password
# admin1@*=password

# chmod 600 bootstrap.creds
# chown 1030:1030 bootstrap.creds

# ./restart-art.sh

