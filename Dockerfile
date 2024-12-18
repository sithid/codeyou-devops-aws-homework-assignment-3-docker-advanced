FROM bitnami/postgresql:15
COPY init.sql /docker-entrypoint-initdb.d/
VOLUME ["/postgresql"]
EXPOSE 5432
ENTRYPOINT ["/opt/bitnami/scripts/postgresql/entrypoint.sh"]
CMD ["/opt/bitnami/scripts/postgresql/run.sh"]

ENV POSTGRESQL_LOG_CONNECTIONS=true \
    POSTGRESQL_LOG_DISCONNECTIONS=true \
    POSTGRESQL_MAX_CONNECTIONS=5
    # POSTGRESQL_PASSWORD