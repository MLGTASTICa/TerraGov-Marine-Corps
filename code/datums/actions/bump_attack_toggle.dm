// Toggle Bumpattacks
/datum/action/bump_attack_toggle
	name = "Toggle Bump Attacks"
	var/attacking = FALSE

/datum/action/bump_attack_toggle/update_button_icon()
	action_icon_state = attacking ? "bumpattack_off" : "bumpattack_on"
	return ..()

