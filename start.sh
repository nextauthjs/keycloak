#!/usr/bin/env bash
/opt/keycloak/bin/kc.sh start --optimized --hostname localhost &
pid=$!
sleep 10 # TODO: healthcheck?

/opt/keycloak/bin/kcadm.sh config credentials --server http://localhost:8080 --realm master --user admin --password $KEYCLOAK_ADMIN_PASSWORD
/opt/keycloak/bin/kcadm.sh create clients -r master -f - << EOF
 {
  "id" : "d440425d-6475-47d7-854b-59ff6cb1893f",
  "clientId" : "authjs",
  "name" : "",
  "description" : "",
  "rootUrl" : "",
  "adminUrl" : "",
  "baseUrl" : "",
  "surrogateAuthRequired" : false,
  "enabled" : true,
  "alwaysDisplayInConsole" : false,
  "clientAuthenticatorType" : "client-secret",
  "redirectUris" : [ "http://localhost:3000/auth/callback/keycloak", "https://examples-proxy.authjs.dev/api/auth/callback/keycloak" ],
  "webOrigins" : [ "+" ],
  "notBefore" : 0,
  "bearerOnly" : false,
  "consentRequired" : false,
  "standardFlowEnabled" : true,
  "implicitFlowEnabled" : false,
  "directAccessGrantsEnabled" : true,
  "serviceAccountsEnabled" : false,
  "publicClient" : true,
  "frontchannelLogout" : true,
  "protocol" : "openid-connect",
  "attributes" : {
    "oidc.ciba.grant.enabled" : "false",
    "oauth2.device.authorization.grant.enabled" : "false",
    "backchannel.logout.session.required" : "true",
    "backchannel.logout.revoke.offline.tokens" : "false"
  },
  "authenticationFlowBindingOverrides" : { },
  "fullScopeAllowed" : true,
  "nodeReRegistrationTimeout" : -1,
  "defaultClientScopes" : [ "web-origins", "acr", "profile", "roles", "email" ],
  "optionalClientScopes" : [ "address", "phone", "offline_access", "microprofile-jwt" ],
  "access" : {
    "view" : true,
    "configure" : true,
    "manage" : true
  }
} 
EOF
/opt/keycloak/bin/kcadm.sh create users -r master -s username=bob -s enabled=true
/opt/keycloak/bin/kcadm.sh set-password --username bob --new-password bob
wait $pid