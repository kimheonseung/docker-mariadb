## Description
- MariaDB 10.4.15 container with Alpine Linux 3.12 base.
- Environment Variables are set in ./scripts/ files.
- Execution may not be guaranteed depending on the Alpine repository update ...
  
## Build
- Execute build.sh or build_windows.bat (docker build --tag mariadb-alpine:1.0 .)
- mariadb-alpine:1.0 build
- Build with Dockerfile  
  
  
  
## Start Container
- Execute startup.sh or startup_windows.bat (docker-compose up -d)
- Start with docker-compose.yml
  
  
  
## Environment Variables
- MYSQL_DATABASE　:　create database
- MYSQL_CHARSET　:　set character set
- MYSQL_COLLATION　:　set collation
- MYSQL_USER　:　create user with all privileges
- MYSQL_PASSWORD　:　set password for user
- MYSQL_ROOT_PASSWORD　:　set passowrd for root
- SKIP_INNODB　:　Settings are memorized when linking a specific volume
  
```console
$ docker run -it --rm --name=db \
	-v /foo/bar:/var/lib/mysql \
	-e MYSQL_USER=foo \
	-e MYSQL_DATABASE=bar \
	-e MYSQL_PASSWORD=baz \
	{container}
```
  
  
  
## Link to Configuration Files.
```console
$ docker run -it --rm --name=db \
         -v $(pwd)/config/my.cnf:/etc/my.cnf.d/my.cnf \
         {container}
```
  
  
  
## Execute specific Sql Script when service starts.
mysql_install_db script starts when first run.  
(script is not initialize when database not exists.)  
we can use our custom sql script using /docker-entrypoint-initdb.d  
  
target : init/mydatabase.sql  

```console
$ docker run -it --rm -e SKIP_INNODB=1 -v db:/var/lib/mysql \
	-v $(pwd)/init:/docker-entrypoint-initdb.d \
	{container}
  
> init: installing mysql client
> init: updating system tables
> init: executing /docker-entrypoint-initdb.d/custom.sh
> 	Hello from script
> init: adding /docker-entrypoint-initdb.d/mydatabase.sql
> init: removing mysql client
```
  
