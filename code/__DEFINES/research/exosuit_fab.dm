/// Module is compatible with Security Cyborg models
#define BORG_MODULE_SECURITY 		(1<<0)
/// Module is compatible with Miner Cyborg models
#define BORG_MODULE_MINER			(1<<1)
/// Module is compatible with Janitor Cyborg models
#define BORG_MODULE_JANITOR			(1<<2)
/// Module is compatible with Medical Cyborg models
#define BORG_MODULE_MEDICAL			(1<<3)
/// Module is compatible with Engineering Cyborg models
#define BORG_MODULE_ENGINEERING		(1<<4)

/// Module is compatible with Ripley Exosuit models
#define EXOSUIT_MODULE_RIPLEY		(1<<0)
/// Module is compatible with Odyseeus Exosuit models
#define EXOSUIT_MODULE_ODYSSEUS		(1<<1)
/// Module is compatible with Gygax Exosuit models
#define EXOSUIT_MODULE_GYGAX		(1<<2)
/// Module is compatible with Durand Exosuit models
#define EXOSUIT_MODULE_DURAND		(1<<3)
/// Module is compatible with Phazon Exosuit models
#define EXOSUIT_MODULE_PHAZON		(1<<4)
/// Module is compatible with Pinnace Fighter models
#define EXOSUIT_MODULE_PINNACE		(1<<5)

/// Module is compatible with "Working" Exosuit models - Ripley
#define EXOSUIT_MODULE_WORKING		EXOSUIT_MODULE_RIPLEY
/// Module is compatible with "Combat" Exosuit models - Gygax, Durand and Phazon
#define EXOSUIT_MODULE_COMBAT		EXOSUIT_MODULE_GYGAX  | EXOSUIT_MODULE_DURAND | EXOSUIT_MODULE_PHAZON
/// Module is compatible with "Medical" Exosuit models - Odysseus
#define EXOSUIT_MODULE_MEDICAL		EXOSUIT_MODULE_ODYSSEUS
/// Module is compatible with "Fighters" Fighter models - Pinnace
#define EXOSUIT_MODULE_FIGHTER		EXOSUIT_MODULE_PINNACE

// Defines for Exosuit components.

#define MECH_HULL		"Hull"
#define MECH_ACTUATOR	"Actuator"
#define MECH_ARMOR		"Plating"
#define MECH_GAS		"Life Support"
#define MECH_ELECTRIC	"Firmware"
