docker run --rm --name opadebug --volume $(pwd)/policy:/policy openpolicyagent/opa:0.40.0-dev-debug build policy --bundle --optimize=999999 --output=/policy/bundle.tar.gz --entrypoint=app/rbac/user_is_admin
