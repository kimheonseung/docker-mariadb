FROM alpine:3.12

COPY scripts/remove-unnecessary.sh /remove-unnecessary.sh
COPY scripts/resolveip.sh /usr/bin/resolveip
COPY scripts/mariadb-run.sh /mariadb-run.sh

RUN apk add --no-cache mariadb=10.4.15-r0 && \
  /bin/sh /remove-unnecessary.sh && \
  touch /usr/share/mariadb/mysql_test_db.sql && \
  sed -i -e 's/127.0.0.1/%/' /usr/share/mariadb/mysql_system_tables_data.sql && \
  mkdir /run/mysqld && \
  chown mysql:mysql /etc/my.cnf.d/ /run/mysqld /usr/share/mariadb/mysql_system_tables_data.sql

VOLUME ["/var/lib/mysql"]
ENTRYPOINT ["/mariadb-run.sh"]
EXPOSE 3306
