KC_HOME=/home/mbecker/apps/keycloak-spi-dev/keycloakx
KC_IMAGE=quay.io/keycloak/keycloak:17.0.0
mkdir -p $KC_HOME/data cd $KC_HOME
docker run \
    -it \
    --rm \
    --name kcx \
    -e KEYCLOAK_ADMIN=admin \
    -e KEYCLOAK_ADMIN_PASSWORD=admin \
    -p 8080:8080 \
    -v $PWD/data:/opt/keycloak/data:z \
    $KC_IMAGE \
    start-dev