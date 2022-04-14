package app.teams

import future.keywords.in

# Team roles for a specific teamid
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

# Roles for a specific teamid
roles["owner"] = is_owner
roles["member"] = is_member


# Team assignments overall
is_in_teams_owner := [key | input.user in data.teams[key]["owner"]]
is_in_teams_member := [key | input.user in data.teams[key]["member"]]

all_teams := { "owner": is_in_teams_owner, "member": is_in_teams_member}

# Permissions for teamid
default is_allowed_read = false
is_allowed_read {
  is_owner
}
is_allowed_read {
  is_member
}

default is_allowed_update = false
is_allowed_update = is_owner