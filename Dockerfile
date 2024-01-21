FROM quay.io/keycloak/keycloak:latest
ADD start.sh /start.sh
ENV KEYCLOAK_ADMIN=admin

ENTRYPOINT ["/start.sh"]
