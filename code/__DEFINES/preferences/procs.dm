//! flags for /copy_to_mob()
/// we're actually spawning roundstart
#define PREF_COPY_TO_FOR_ROUNDSTART (1<<0)
/// we're spawning latejoin
#define PREF_COPY_TO_FOR_LATEJOIN (1<<1)
/// we're spawning ghostrole (or otherwise anything that isn't really a job)
#define PREF_COPY_TO_FOR_GHOSTROLE (1<<2)
/// we're just doing it for some preview/visual reason
#define PREF_COPY_TO_FOR_RENDER (1<<3)
/// ignore species checks; you should check the species yourself!
#define PREF_COPY_TO_NO_CHECK_SPECIES (1<<4)
/// ignore most loadout restrictions, and spawn loadout. do not use in spawn procs, SSjob/SSticker will do it instead!
#define PREF_COPY_TO_UNRESTRICTED_LOADOUT (1<<5)

/// DO NOT update icons
#define PREF_COPY_TO_DO_NOT_RENDER (1<<23)

/// helper
#define PREF_COPYING_TO_CHECK_IS_SPAWNING(flags) (flags & (PREF_COPY_TO_FOR_ROUNDSTART | PREF_COPY_TO_FOR_LATEJOIN | PREF_COPY_TO_FOR_GHOSTROLE))

