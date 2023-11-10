FROM mysql:8.0

COPY script_formatadoV1.sql /docker-entrypoint-initdb.d/