/obj/item/kevlarupgrade
	name = "kevlar upgrade kit"
	desc = "A kit for reinforcing standard jumpsuits with kevlar weave, upgrading their armour slightly."
	icon = 'icons/obj/clothing/modular_armor.dmi'	// NO LONGER A PLACEHOLDER
	icon_state = "kevlar_upgrade"	// RIP PLACEHOLDERS WOOO

/obj/item/kevlarupgrade/afterattack(atom/target, mob/user, proximity_flag)
	if(!proximity_flag)
		return ..()

	if(istype(target, /obj/item/clothing/under))
		var/obj/item/clothing/under/C = target
		if(C.fetch_armor().is_atleast(list(
			ARMOR_MELEE = 40,
			ARMOR_BULLET = 20,
			ARMOR_LASER = 20,
		)))
			to_chat(user, "This item cannot be upgraded any further!")
			return CLICKCHAIN_DO_NOT_PROPAGATE
		C.set_armor(C.fetch_armor().boosted(list(
			ARMOR_MELEE = 40,
			ARMOR_BULLET = 20,
			ARMOR_LASER = 20,
		)))

		to_chat(user, "Armor upgrade successful!")
		qdel(src)
		return CLICKCHAIN_DO_NOT_PROPAGATE
	return ..()
