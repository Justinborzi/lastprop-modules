--[[---------------------------------------------------------
Example Taunt Pack:
------------------------------------------------------------
 - name, a unique name for the taunt, no spaces, best to use the filename.
 - label, the human readable name for the taunt, (shows up in the taunt menu)
 - file, the mp3 or wav file for the taunt.
 - length, how long the taunt is in seconds. It can be a float value for example, 1.5 is ok.

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
