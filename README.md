# nifi-vagrant
Ubuntu vagrant for NiFi

## Versions

1. NiFI - 1.1.1
2. MSSQL JDBC Driver (optional) v6.0

## Usage

1. NiFi
  * <code>/usr/bin/nifi start</code> will start NiFi on port 8080.
  * <code>/usr/bin/nifi stop</code> will stop NiFi.
2. MSSQL JDBC
  * Driver location: <code>/usr/share/java/mssqljdbc42.jar</code>
  * Driver class: <code>com.microsoft.sqlserver.jdbc.SQLServerDriver</code>
  * Connection Url: <code>jdbc:sqlserver:/localhost:1422;DatabaseName=db</code>

## Notes

1. MSSQL Server JDBC driver is installed if located in /resources (included). Remove from there if you don't need it.
2. NiFi and Kafka will be downloaded if they don't exist in /resources. If you already have these downloads, you can save yourself some time by placing them in /resources.

