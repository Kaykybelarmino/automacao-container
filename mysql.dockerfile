FROM mysql:8.0

COPY script_formatadoV2.sql /docker-entrypoint-initdb.d/