npm ci
mysql -u root -p -e "CREATE DATABASE dustinsblog;"
mysql -u root -p dustinsblog < dustinsblogdata.sql
touch .env
echo "DB_PASS=[Your root password]" > .env
echo "Setup complete!"