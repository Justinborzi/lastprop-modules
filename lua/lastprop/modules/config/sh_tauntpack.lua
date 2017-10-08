--[[---------------------------------------------------------
Example Taunt Pack:
------------------------------------------------------------
hook.Add('Initialize', 'MyTauntPack', function()
	GAMEMODE:RegisterTauntPack('MyTauntPack', {
        hunter = {
            {name = 't_hunter_taunt', label = 'Hunter Taunt', file = 'mytaunts/hunter/hunter.mp3', length = 1},
        },
        prop = {
            {name = 't_prop_taunt', label = 'Prop Taunt', file = 'mytaunts/prop/prop.mp3', length = 1},
        },
        lastman = {
            {name = 't_lastman_taunt', file = 'mytaunts/lastman/lastman.mp3', length = 60},
        },
    })
end)
---------------------------------------------------------]]--