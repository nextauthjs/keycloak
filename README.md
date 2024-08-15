<p align="center">
   <br/>
   <a href="https://authjs.dev" target="_blank"><img width="150px" src="https://authjs.dev/img/logo-sm.png" /></a>
   <h3 align="center">Auth.js 3rd Party Backend</a></h3>
   <h4 align="center">Authentication for the Web.</h4>
   <p align="center" style="align: center;">
      <a href="https://npm.im/next-auth">
        <img src="https://img.shields.io/badge/TypeScript-blue?style=flat-square" alt="TypeScript" />
      </a>
      <a href="https://npm.im/@auth/sveltekit">
        <img alt="npm" src="https://img.shields.io/npm/v/next-auth?color=green&label=next-auth&style=flat-square">
      </a>
      <a href="https://www.npmtrends.com/next-auth">
        <img src="https://img.shields.io/npm/dm/next-auth?label=%20downloads&style=flat-square" alt="Downloads" />
      </a>
      <a href="https://github.com/nextauthjs/next-auth/stargazers">
        <img src="https://img.shields.io/github/stars/nextauthjs/next-auth?style=flat-square" alt="Github Stars" />
      </a>
   </p>
</p>

Auth.js Keycloak is a Keycloak installation to support testing https://github.com/nextauthjs/next-auth.
It is deployed under https://keycloak.authjs.dev.

This docker image is self-contained and can be used just like `quay.io/keycloak/keycloak`.
The only difference is that some test-configuration is applied after the startup of keycloak using `kcadm.sh`.

Note: It is also possible to start up keycloak with seed configuration using a [realm import](https://www.keycloak.org/server/importExport).  
We opted for using `kcadm.sh`  commands and our custom script for the configuration, because it's easier to overview and maintain for us.
