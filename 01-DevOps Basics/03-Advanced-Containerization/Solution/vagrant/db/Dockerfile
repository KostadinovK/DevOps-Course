FROM mysql:5.7

# Load the user data (our data) into the database
ADD ./sql/init.sql /docker-entrypoint-initdb.d/init.sql
