# Mattermost Docker Setup For MariaDB

Note: This is a PR of the original mattermost docker project (https://github.com/mattermost/docker). This config specifically is for mariadb motivated through the lack of documentation.

## Quick Start Notes
1. start containers with up.sh
2. create directories for mounting volumes makedirectories.sh
3. Go into mariadb container and create `mattermost` database, create `mmuser` user and give permissions
4. Restart containers
5. Go to http://localhost:8065 in a browser

###################
https://docs.mattermost.com/install/trouble_mysql.html
```
#add settings to container scripts
sudo chmod 755 up.sh
sudo chmod 755 down.sh

# Start mattermost/mariadb container
./up

# Note: Now we need to create the mattermost DB and create users. This is done the first time: 
bash> docker ps -a
bash> docker exec --it {mariacontainer} mysql
# run mysql as root
bash> mysql -u root -p
mysql> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
5 rows in set (0.000 sec)
# if you dont see mattermost create it like so
mysql> create database mattermost;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mattermost         |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
5 rows in set (0.000 sec)

# now create mattermost user similar to our MM_USERNAME for the database
mysql> select User, Host from mysql.user;
+-------------+--------------+
| User        | Host         |
+-------------+--------------+
| root        | 127.0.0.1    |
| root        | ::1          |
| root        | ca8c68cd337c |
| mariadb.sys | localhost    |
| root        | localhost    |
+-------------+--------------+
5 rows in set (0.001 sec)

# now add permissions to that user
create user ‘mmuser’@’%’ identified by ‘{mmuser-password}’;.
MariaDB [(none)]> create user 'mmuser'@'%'identified by 'password123'; 

# grant permission to mmuser
grant all privileges on mattermost.* to 'mmuser'@'%';

exit
```
Other notes: May consider forwarding firewall
https://mariadb.com/kb/en/configuring-mariadb-for-remote-client-access/