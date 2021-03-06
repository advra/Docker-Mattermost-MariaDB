# Mattermost Docker Setup For MariaDB

Note: This is a PR of the original mattermost docker project (https://github.com/mattermost/docker). This config specifically is for mariadb motivated through the lack of documentation.

## Quick Start Notes
1. start containers with up.sh
2. create directories for mounting volumes makedirectories.sh
3. Go into mariadb container and create `mattermost` database, create `mmuser` user and give permissions
4. Restart containers
5. Go to http://localhost:8065 in a browser


Some notes ref mysql for mariadb: https://docs.mattermost.com/install/trouble_mysql.html


## Notes Detailed
1. Start containers
```
#add settings to container scripts
sudo chmod 755 up.sh
sudo chmod 755 down.sh

# Start mattermost/mariadb container
# Note: up.sh and down.sh contain the nginx and non-nginx variaints
./up.sh
```
2. create directories for mounting volumes makedirectories.sh
```
./makedirectories.sh
```
3. Go into mariadb container and create `mattermost` database, create `mmuser` user and give permissions
```
# Note: Now we need to create the mattermost DB and create users. This is done the first time: 
bash> docker ps -a
# run mysql as root
bash> docker exec -it mariadb_mattermost mysql -u root -p
# if using default passwords in config pass is r00t
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
create user ???mmuser???@???%??? identified by ???{mmuser-password}???;
MariaDB [(none)]> create user 'mmuser'@'%'identified by 'password123'; 

# grant permission to mmuser (This can be tweaked for more security)
grant all privileges on mattermost.* to 'mmuser'@'%';

exit
```

4. Restart containers
```
./down.sh
./up.sh
```
## Other Thoughts
- May consider forwarding firewall check out https://mariadb.com/kb/en/configuring-mariadb-for-remote-client-access/
- Disabling Https for internal orgs without need of SSL check out https://github.com/mattermost/docker/issues/87
- LDAP is enterprise edition but can opt for gitlab for SSO

# Debuging 
- use `docker logs containername` ex. docker logs mattermost
- if container restarts constantly go into it and check config settings with `docker run -it mattermost/mattermost-team-edition:6.5 /bin/sh`
