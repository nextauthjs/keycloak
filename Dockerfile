FROM quay.io/keycloak/keycloak:latest
ADD start.sh /start.sh
ENV KEYCLOAK_ADMIN=admin
ENV PORT=${PORT:-8080}
EXPOSE $PORT
ENTRYPOINT ["/start.sh"]
