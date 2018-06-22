#!/bin/sh -e
# create a laravel project
create laravel project using composer 
echo Enter laravel project name 
read projectName
echo setting up laravel project
# create laravel project using composer 
composer create-project --prefer-dist laravel/laravel $projectName
# change directory to be able to edit the .env file
echo changing directory to $projectName
cd test
composer dump-autoload 
echo create database
echo database name
read databaseName
echo database username
read databaseUserName
echo database password
read databasePassword
# create database 
# while database name exist, ask for a valid name.
while ! echo "create database $databaseName;" | mysql -u "$databaseUserName" -p "$databasePassword";
 do
	echo "database already exist enter a valid name"
	read databaseName
done
echo database created
# change .env variables 
sed -i "s/DB_DATABASE=homestead/DB_DATABASE=$databaseName/g" ".env"
sed -i "s/DB_USERNAME=homestead/DB_USERNAME=$databaseUserName/g" ".env"
sed -i "s/DB_PASSWORD=secret/DB_PASSWORD=$databaseUserName/g" ".env"
sed -i "s/CACHE_DRIVER=file/CACHE_DRIVER=array/g" ".env"
# end .env edit 

echo laravel setup done



