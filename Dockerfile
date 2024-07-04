FROM quay.io/keycloak/keycloak:latest
ADD start.sh /start.sh

ENV PORT=${PORT:-8080}
EXPOSE $PORT

ENV KEYCLOAK_ADMIN=admin

ENTRYPOINT ["/start.sh"]