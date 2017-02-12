# nifi-vagrant
Ubuntu vagrant for NiFi/Kafka

## Notes

1. MSSQL Server JDBC driver is installed to /usr/share/java.
2. NiFi is installed to /usr/share and startup script linked to /usr/bin/nifi.
3. Kafka is installed to /usr/share. Startup is not linked, since kafka expects things to run from a certain subdirectory (BAD).
