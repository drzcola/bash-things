# Backup de una tabla
mysqldump -u <user> -p <database> <tabla> > <archivo>.sql

# Restauración de una tabla
mysql -u root -p <database> < <archivo>.sql

# Backup completo
mysqldump -u <user> -p > <archivo>.sql
