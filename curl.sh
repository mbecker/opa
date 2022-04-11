curl --location --request POST 'http://localhost:8181/v1/data/app/rbac/user_is_admin?metrics&partial' \
--header 'Content-Type: application/json' \
--data-raw '{
    "input": {
        "user": "robert",
        "action": "read",
        "object": "id123",
        "type": "dog",
        "iot": "1-2-3-4"
    }
}'
