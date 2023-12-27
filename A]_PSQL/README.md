```bash
user, password = ayonssp, zboy@1x1
psql jwt_auth_system ayonssp
```
```bash
sudo service postgresql status
sudo service postgresql start
sudo service postgresql stop
sudo service postgresql restart
sudo service postgresql reload
psql --version
sudo passwd postgres

```
```bash
psql -U postgres # for linux root
```
```bash
sudo passwd postgres
sudo -u postgres psql
psql store_monitoring postgres
```
```psql
\l
\du
\dt - this shows all tables in the current schema
\password postgres
\q
SELECT * FROM pg_catalog.pg_tables; - list all tables
\c <dbnaem-toConnect>
\! clear
\d+ tablename - show table structure
```
[lisk to wsl connection](https://chloesun.medium.com/set-up-postgresql-on-wsl2-and-connect-to-postgresql-with-pgadmin-on-windows-ca7f0b7f38ab)

[initilising Pgadmin](https://itslinuxfoss.com/fix-psql-peer-authentication-failed-for-user/#:~:text=To%20fix%20%E2%80%9Cpsql%20Peer%20authentication,are%20explained%20with%20their%20applications.)

- Need to update pg_hba.conf file to allow local connections

you just have to change the line in pg_hba.conf file from peer to trust.

![image](https://user-images.githubusercontent.com/80549753/230084621-ef75600e-bdfc-4dc4-b266-53da31cc36f7.png)

```bash
cd /etc/postgresql/12/main
vi pg_hba.conf
esc :wq!
sudo su postgres
service postgresql restart
psql store_monitoring postgres
```
![image](https://user-images.githubusercontent.com/80549753/230105990-2b5ef2db-8d8b-4291-806a-ca0c1a3a1548.png)


The error message suggests that there might be another instance of PostgreSQL already running on the port 5432. You can try the following steps to resolve this issue:

Verify if there is another instance of PostgreSQL already running by running the command:
sudo lsof -i :5432

If this command returns any output, it means that some process is already listening on port 5432. You can then stop the process using the command sudo kill <process_id>, where <process_id> is the ID of the process returned by the previous command.

If there is no other instance of PostgreSQL running, then you can try to restart the PostgreSQL service by running the following command:
sudo systemctl restart postgresql

If the service still does not start, you can try to start the PostgreSQL server manually by running the following command:
sudo su postgres -c '/usr/lib/postgresql/12/bin/pg_ctl -D /var/lib/postgresql/12/main -l /var/log/postgresql/postgresql-12-main.log start'

This command starts the PostgreSQL server with the data directory /var/lib/postgresql/12/main and logs output to /var/log/postgresql/postgresql-12-main.log. If there are any errors, they should be visible in the log file. You can check the log file by running the command:
sudo tail -f /var/log/postgresql/postgresql-12-main.log

I hope this helps!



