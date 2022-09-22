/// Updates a mob's action keybinding text that shows on its maptext
/datum/element/keybinding_update

/// Activates the functionality defined by the element on the given target datum
/datum/element/keybinding_update/Attach(datum/target)
	. = ..()
	if(!ismob(target))
		return ELEMENT_INCOMPATIBLE
	RegisterSignal(target, COMSIG_MOB_KEYBINDINGS_UPDATED, .proc/on_keybinding_change)

/datum/element/keybinding_update/Detach(datum/source, force)
	UnregisterSignal(source, COMSIG_MOB_KEYBINDINGS_UPDATED)
	. = ..()

/datum/element/proc/on_keybinding_change(mob/current_mob, datum/keybinding/changed_bind)
	SIGNAL_HANDLER
	if(!changed_bind)
		return
	if(!current_mob)
		CRASH("/datum/element/keybinding_update received a mob signal without a mob tied to it")
	if(!current_mob.actions)
		return
	if(!current_mob.client)
		return
	var/client/binder_client = current_mob.client
	for(var/datum/action/user_action AS in current_mob.actions)
		if(user_action.keybind_signal == changed_bind.keybind_signal)
			user_action.update_map_text(changed_bind.get_keys_formatted())
			break

