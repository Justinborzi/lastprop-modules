--[[---------------------------------------------------------
Example Loadout:
------------------------------------------------------------
GM.loadouts['PREGAME'] = {
    weapon_lastman = {},
    weapon_shotgun = {
        primary = {'Buckshot', 64}
    },
    weapon_smg1 = {
        primary = {'SMG1', 255}
    },
    weapon_crossbow = {
        primary = {'XBowBolt', 32}
    },
    weapon_rpg = {
        primary = {'RPG_Round', 6}
    },
}

GM.loadouts['POSTROUND'] = {
    weapon_rpg = {
        primary = {'RPG_Round', 10}
    },
}

GM.loadouts[TEAM.PROPS] = {
    weapon_lastman = {},
    weapon_rpg = {
        primary = {'RPG_Round', 1}
    },
}

GM.loadouts[TEAM.HUNTERS] ={
    weapon_crowbar = {},
    weapon_shotgun = {
        primary = {'Buckshot', 64}
    },
    weapon_smg1 = {
        primary = {'SMG1', 255}
    },
    weapon_crossbow = {
        primary = {'XBowBolt', 32}
    }
}


Structure:
GM.loadouts[TEAM.ID] = {
    weapon_name = {
        primary = {'ammo_name', 1000 (Ammo amount)}, Primary ammo
        secondary = {'ammo_name', 1000 (Ammo amount)}, Secondary ammo
    }
},

---------------------------------------------------------]]--
