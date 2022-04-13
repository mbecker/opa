package app.iot

import future.keywords.in

has_iot_x := [key | data.iot[key]; input.user in data.iot[key]["owner"]]
has_iot_c := count(has_iot_x) < 100

# has_iot_owner[key] {
# 	some key, val in data.iot
#     input.user in val["owner"]
# }

# default has_iot_allowed = false
# has_iot_allowed {
# 	iots := has_iot
#     count(iots) < 10
# }

# number_iot = output {
#     output := count(has_iot)
# }