FROM quay.io/keycloak/keycloak:latest

ENV KEYCLOAK_ADMIN=admin
ENV KC_DB=postgres
ENV KC_DB_USERNAME=postgres
ENV KC_HOSTNAME=localhost

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start-dev"]
