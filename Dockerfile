FROM quay.io/keycloak/keycloak:latest as builder

ENV KC_HEALTH_ENABLED=true

WORKDIR /opt/keycloak

# for demonstration purposes only
RUN keytool -genkeypair -storepass password -storetype PKCS12 -keyalg RSA -keysize 2048 -dname "CN=server" -alias server -ext "SAN:c=DNS:localhost,IP:127.0.0.1" -keystore conf/server.keystore
RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:latest
COPY --from=builder /opt/keycloak/ /opt/keycloak/
ADD start.sh /start.sh

ENV PORT=${PORT:-8080}
EXPOSE $PORT

ENV KEYCLOAK_ADMIN=admin

ENTRYPOINT ["/start.sh"]
