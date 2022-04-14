package app.teams

import future.keywords.in

default is_owner = false
is_owner = input.user in data.teams[input.teamid]["owner"]

default is_member = false
# The following partial rules show a "LOGICAL OR"
# is_member {
#   input.user in data.teams[input.teamid]["member"]
# }
# is_member {
#   is_owner
# }
is_member = input.user in data.teams[input.teamid]["member"]

roles["owner"] = is_owner
roles["member"] = is_member