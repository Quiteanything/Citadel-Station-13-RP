/**
 * ### Unobserved Actor
 *
 * Blocks certain actions while this mob is being observed by something.
 */
/datum/component/unobserved_actor
	/// Dictates what behaviour you're blocked from while observed
	var/unobserved_flags = NONE
	/// Cooldown to prevent message spam when holding a move button
	COOLDOWN_DECLARE(message_cooldown)


/datum/component/unobserved_actor/Initialize(unobserved_flags = NONE)
	. = ..()
	if (!isliving(parent))
		return ELEMENT_INCOMPATIBLE
	if (unobserved_flags == NONE)
		CRASH("No behaviour flags provided to unobserved actor element")
	src.unobserved_flags = unobserved_flags


/datum/component/unobserved_actor/RegisterWithParent()
	if (unobserved_flags & NO_OBSERVED_MOVEMENT)
		RegisterSignal(parent, COMSIG_MOVABLE_PRE_MOVE, PROC_REF(on_tried_move))
		RegisterSignal(parent, COMSIG_ATOM_PRE_DIR_CHANGE, PROC_REF(on_tried_turn))
	// if (unobserved_flags & NO_OBSERVED_ACTIONS)
	// 	RegisterSignal(parent, COMSIG_MOB_ABILITY_STARTED, PROC_REF(on_tried_ability))
	// 	RegisterSignal(parent, COMSIG_MOB_BEFORE_SPELL_CAST, PROC_REF(on_tried_spell))
	if (unobserved_flags & NO_OBSERVED_ATTACKS)
		RegisterSignal(parent, COMSIG_HOSTILE_PRE_ATTACKINGTARGET, PROC_REF(on_tried_attack))


/datum/component/unobserved_actor/UnregisterFromParent()
	UnregisterSignal(parent, list(
		COMSIG_MOVABLE_PRE_MOVE,
		COMSIG_ATOM_PRE_DIR_CHANGE,
		// COMSIG_MOB_ABILITY_STARTED,
		// COMSIG_MOB_BEFORE_SPELL_CAST,
		COMSIG_HOSTILE_PRE_ATTACKINGTARGET,
	))
	return ..()


/// Called when the mob tries to move
/datum/component/unobserved_actor/proc/on_tried_move(mob/living/source)
	SIGNAL_HANDLER
	if (!check_if_seen(source))
		return
	return COMPONENT_MOVABLE_BLOCK_PRE_MOVE


/// Called when the mob tries to change direction
/datum/component/unobserved_actor/proc/on_tried_turn(mob/living/source)
	SIGNAL_HANDLER
	if (!check_if_seen(source))
		return
	return COMPONENT_ATOM_BLOCK_DIR_CHANGE

/*
/// Called when the mob tries to use an ability
/datum/component/unobserved_actor/proc/on_tried_ability(mob/living/source)
	SIGNAL_HANDLER
	if (!check_if_seen(source))
		return
	return COMPONENT_BLOCK_ABILITY_START

/// Called when the mob tries to cast a spell
/datum/component/unobserved_actor/proc/on_tried_spell(mob/living/source)
	SIGNAL_HANDLER
	if (!check_if_seen(source))
		return
	return SPELL_CANCEL_CAST
*/


/// Called when the mob tries to attack
/datum/component/unobserved_actor/proc/on_tried_attack(mob/living/source)
	SIGNAL_HANDLER
	if (!check_if_seen(source))
		return
	return COMPONENT_HOSTILE_NO_ATTACK


/// Checks if the mob is visible to something else, and provides a balloon alert of feedback if appropriate.
/datum/component/unobserved_actor/proc/check_if_seen(mob/living/source)
	var/observed = can_be_seen(source)
	if (observed && COOLDOWN_FINISHED(src, message_cooldown))
		// source.balloon_alert(source, "something can see you!")
		to_chat(source, "something can see you!")
		COOLDOWN_START(src, message_cooldown, 1 SECONDS)
	return observed


/**
 * Returns true if you can be seen by something.
 * Not a very robust algorithm but it'll work in the majority of situations.
 */
/datum/component/unobserved_actor/proc/can_be_seen(mob/living/source)
	var/turf/my_turf = get_turf(source)
	// Check for darkness
	if(my_turf.lighting_overlay && my_turf.get_lumcount() < 0.1) // No one can see us in the darkness, right?
		return FALSE

	var/view_size
	if(source.client)
		view_size = source.client.view
	else
		view_size = world.view

	// We aren't in darkness, loop for viewers.
	for(var/mob/living/mob_target as anything in oviewers(my_turf, view_size)) // They probably cannot see us if we cannot see them... can they?
		if(mob_target.client && !mob_target.is_blind() && !mob_target.silicon_privileges && !HAS_TRAIT(mob_target, TRAIT_UNOBSERVANT))
			return TRUE
	for(var/obj/vehicle/vehicle_target in oview(my_turf, view_size))
		for(var/mob/vehicle_mob_target as anything in vehicle_target.occupants)
			if(vehicle_mob_target.client && !vehicle_mob_target.is_blind() && !HAS_TRAIT(vehicle_mob_target, TRAIT_UNOBSERVANT))
				return TRUE

	return FALSE
