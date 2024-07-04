#!/usr/bin/env bash
ARGS="$@"
/opt/keycloak/bin/kc.sh start --optimized $ARGS &

KEYCLOAK_PID=$!

term_handler() {
    echo "Termination signal received, stopping Keycloak..."
    if [ $KEYCLOAK_PID -ne 0 ]; then
        kill -TERM "$KEYCLOAK_PID"
        wait "$KEYCLOAK_PID"
    fi
    exit 0
}

trap 'term_handler' SIGTERM SIGINT

until /opt/keycloak/bin/kcadm.sh config credentials --server http://localhost:8080 --realm master --user $KEYCLOAK_ADMIN --password $KEYCLOAK_ADMIN_PASSWORD; do
    >&2 echo "Keycloak is unavailable - sleeping"
    sleep 1
done

/opt/keycloak/bin/kcadm.sh config credentials --server http://localhost:8080 --realm master --user admin --password $KEYCLOAK_ADMIN_PASSWORD
/opt/keycloak/bin/kcadm.sh create clients --server http://localhost:8080  -r master -f - <<-EOF
{
  "clientId": "authjs-test",
  "name": "",
  "description": "",
  "rootUrl": "",
  "adminUrl": "",
  "baseUrl": "",
  "surrogateAuthRequired": false,
  "enabled": true,
  "alwaysDisplayInConsole": false,
  "clientAuthenticatorType": "client-secret",
  "secret": "${AUTHJS_TEST_CLIENT_SECRET}",
  "redirectUris": [
    "http://localhost:3000/auth/callback/keycloak",
    "https://examples-proxy.authjs.dev/api/callback/keycloak"
  ],
  "webOrigins": [
    "http://localhost:3000"
  ],
  "notBefore": 0,
  "bearerOnly": false,
  "consentRequired": false,
  "standardFlowEnabled": true,
  "implicitFlowEnabled": false,
  "directAccessGrantsEnabled": true,
  "serviceAccountsEnabled": false,
  "publicClient": false,
  "frontchannelLogout": true,
  "protocol": "openid-connect",
  "attributes": {
    "oidc.ciba.grant.enabled": "false",
    "backchannel.logout.session.required": "true",
    "client_credentials.use_refresh_token": "false",
    "tls.client.certificate.bound.access.tokens": "false",
    "require.pushed.authorization.requests": "false",
    "acr.loa.map": "{}",
    "display.on.consent.screen": "false",
    "oauth2.device.authorization.grant.enabled": "false",
    "backchannel.logout.revoke.offline.tokens": "false",
    "token.response.type.bearer.lower-case": "false",
    "use.refresh.tokens": "true"
  },
  "authenticationFlowBindingOverrides": {},
  "fullScopeAllowed": true,
  "nodeReRegistrationTimeout": -1,
  "defaultClientScopes": [
    "web-origins",
    "acr",
    "roles",
    "profile",
    "email"
  ],
  "optionalClientScopes": [
    "address",
    "phone",
    "offline_access",
    "microprofile-jwt"
  ],
  "access": {
    "view": true,
    "configure": true,
    "manage": true
  }
}
EOF
/opt/keycloak/bin/kcadm.sh create users  --server http://localhost:8080 -r master -s username=bob -s enabled=true
/opt/keycloak/bin/kcadm.sh set-password  --server http://localhost:8080 --username bob --new-password bob

wait $KEYCLOAK_PID
