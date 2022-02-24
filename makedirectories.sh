mkdir -p ./volumes/app/mattermost/{config,data,logs,plugins,client/plugins,bleve-indexes}
mkdir -p ./volumes/db/var/lib/mysql
sudo chown -R 2000:2000 ./volumes/app/mattermost
sudo chown -R 2000:2000 ./volumes/db