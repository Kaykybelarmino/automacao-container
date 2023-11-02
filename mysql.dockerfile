FROM mysql:8.0
ENV MYSQL_ROOT_PASSWORD=segredo
ENV MYSQL_DATABASE=marvel
ENV MYSQL_USER=medconnect
ENV MYSQL_PASSWORD=medconnect123

COPY script_formatadoV1.sql /docker-entrypoint-initdb.d/
RUN 