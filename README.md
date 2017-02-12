### nifi-vagrant
Ubuntu vagrant for NiFi/Kafka

## Versions

1. NiFI - 1.1.1
2. Kafka 2_11-0.10.1.1
3. Zookeeper (current from apt repo)

## Notes

1. MSSQL Server JDBC driver is installed to /usr/share/java if located in /resources.
2. NiFi is installed to /usr/share and startup script linked to /usr/bin/nifi.
3. Kafka is installed to /usr/share. Startup is not linked, since kafka expects things to run from a certain subdirectory (BAD).
4. NiFi and Kafka will be downloaded if they don't exist in /resources. If you already have these downloads, you can save yourself some time by placing them in /resources.
