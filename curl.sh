curl -w "@curl-format.txt" -o /dev/null --location --request POST 'http://localhost:8181/v1/data/app/rbac/user_iot_owner?metrics' \
--header 'Content-Type: application/json' \
--data-raw '{
    "input": {
        "user": "mats",
        "iot": "1-2-3-4"
    }
}'
