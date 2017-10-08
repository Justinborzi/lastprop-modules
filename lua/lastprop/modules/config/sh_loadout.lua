--[[---------------------------------------------------------
Example Loadout:
------------------------------------------------------------
GM.loadouts = {
    [TEAM.PROPS] = {
        weapon_lastman = {},
    },
    [TEAM.HUNTERS] = {
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
    },
    Structure:
    [TEAM.ID] = {
        weapon_name = {
            primary = {'ammo_name', 1000 (Ammo amount)}, Primary ammo
            secondary = {'ammo_name', 1000 (Ammo amount)}, Secondary ammo
        }
    },
}
---------------------------------------------------------]]--
