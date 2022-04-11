# Role-based Access Control (RBAC)
# --------------------------------
#
# This example defines an RBAC model for a Pet Store API. The Pet Store API allows
# users to look at pets, adopt them, update their stats, and so on. The policy
# controls which users can perform actions on which resources. The policy implements
# a classic Role-based Access Control model where users are assigned to roles and
# roles are granted the ability to perform some action(s) on some type of resource.
#
# This example shows how to:
#
#	* Define an RBAC model in Rego that interprets role mappings represented in JSON.
#	* Iterate/search across JSON data structures (e.g., role mappings)
#
# For more information see:
#
#	* Rego comparison to other systems: https://www.openpolicyagent.org/docs/latest/comparison-to-other-systems/
#	* Rego Iteration: https://www.openpolicyagent.org/docs/latest/#iteration

package app.rbac

import future.keywords.in

# By default, deny requests.
default allow = false

# Allow admins to do anything.
allow {
	user_is_admin
}

allow {
	user_iot_is_owner
}

# Allow the action if the user is granted permission to perform the action.
allow {
	# Find grants for the user.
	some grant
	user_is_granted[grant]

	# Check if the grant permits the action.
	input.action == grant.action
	input.type == grant.type
}

# user_is_admin is true if...
user_is_admin {
	# "admin" is among the user's roles as per data.user_roles
	"admin" in data.user_roles[input.user]
}

user_iot_owner[resourceky] {
  # iterate over key/value pairs
  resourceval := data.iot[resourceky]
  input.user in resourceval["owner"]

  # some iotresource in data.iot
  # input.user in iotresource["owner"]
  # [iotresource]
}

user_iot_is_owner {
	input.user in data.iot[input.iot]["owner"]
}

user_iot_reader[resourceky] {
  # iterate over key/value pairs
  resourceval := data.iot[resourceky]
  input.user in resourceval["reader"]

  # some iotresource in data.iot
  # input.user in iotresource["owner"]
  # [iotresource]
}

# user_is_granted is a set of grants for the user identified in the request.
# The `grant` will be contained if the set `user_is_granted` for every...
user_is_granted[grant] {
	# `role` assigned an element of the user_roles for this user...
	some role in data.user_roles[input.user]

	# `grant` assigned a single grant from the grants list for 'role'...
	some grant in data.role_grants[role]
}

