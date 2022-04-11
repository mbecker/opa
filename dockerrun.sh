# Start in Dev Mode
KC_IMAGE=quay.io/keycloak/keycloak:17.0.0
docker run \
-it \
--rm \
--name kcx \
-e KEYCLOAK_ADMIN=admin \
-e KEYCLOAK_ADMIN_PASSWORD=admin \
-p 8080:8080 \
-v /home/mbecker/apps/keycloak-spi-dev/data/keycloakx:/opt/keycloak/data:z \
$KC_IMAGE \
start-dev