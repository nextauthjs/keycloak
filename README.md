# Auth.js Keycloak

Auth.js Keycloak is a Keycloak installation to support testing https://github.com/nextauthjs/next-auth.
It is deployed under https://keycloak.authjs.dev.

## Deployment

Right now, auth.js keycloak is a simple docker deployment on ec2.

### Prerequisites

- External database
- SSL certificates (generated with certbot/letsencrypt, for example)

Then, the docker container is started like this:

```bash
export KEYCLOAK_DB_URL=<JDBC-URL>
export KEYCLOAK_ADMIN_PASSWORD=<Password>
export KEYCLOAK_HOSTNAME=keycloak.authjs.dev
export KEYCLOAK_DB_USERNAME=<DB-Username>
export KEYCLOAK_DB_PASSWORD=<DB-password>

docker run -d    --name authjs-keycloak   -v /path-to-letsencrypt-certificates:/certificates -p 443:443   -e KEYCLOAK_ADMIN=admin   -e KEYCLOAK_ADMIN_PASSWORD=$KEYCLOAK_ADMIN_PASSWORD   quay.io/keycloak/keycloak:latest   start   --features=token-exchange   --https-certificate-file=/certificates/fullchain.pem   --https-certificate-key-file=/certificates/privkey.pem   --hostname=$KEYCLOAK_HOSTNAME   --proxy=edge   --https-port=443   --db=postgres --db-url=$KEYCLOAK_DB_URL   --db-username=$KEYCLOAK_DB_USERNAME   --db-password=$KEYCLOAK_DB_PASSWORD
```
