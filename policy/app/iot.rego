package app.iot

import future.keywords.in

# has_iot_x := [key | data.iot[key]; input.user in data.iot[key]["owner"]]
# has_iot_c := count(has_iot_x) < 100

default iot_x = []
iot_x = data.users[input.user]["iot"]
iot_n := count(iot_x)
iot_p := iot_n > 101

iot_t := {"msg": sprintf("number iot: %d", [iot_n]), "isAllowed": iot_p}

# iot_t = msg {
#   iot_p
#   output := sprintf("number iot: %d", [iot_n])
#   msg := {"msg": output, "isAllowed": iot_p}
# }

# iot_t = msg {
#   not iot_p
#   output := sprintf("number iot: %d", [iot_n])
#   msg := {"msg": output, "isAllowed": iot_p}
# }

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
default is_owner = false
is_owner = input.user in data.teams[input.teamid]["owner"]

default is_member = false
is_member {
  input.user in data.teams[input.teamid]["member"]
}
is_member {
  is_owner
}
# is_member = input.user in data.teams[input.teamid]["member"]
# is_member = is_owner

is_owner_x["owner"] = is_owner
is_owner_x["member"] = is_member