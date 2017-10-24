lps = lps or {}

function lps:Reboot()
    util.Notify(nil, 'UPDATE RECEIVED FROM GIT: Mapvote starting to refresh gamemode!')
    if (#player.GetAll() > 1) then
        if (GAMEMODE:InGame()) then
            hook.Add("CanStartRound", "Reboot:CanStartRound", function() return false end)
            hook.Add("OnRoundEnd", "Reboot:OnRoundEnd", function() lps.mapvote:Start() end)
        else
            lps.mapvote:Start()
        end
    else
        local maps = {}
        for k, map in RandomPairs(file.Find("maps/*.bsp", "GAME")) do
            for k, v in pairs({"cs_", "ph_"}) do
                if (string.find(map, "^"..v)) then
                   maps[#maps + 1] = map:sub(1, -5)
                    break
                end
            end
        end
        RunConsoleCommand("changelevel", table.Random(maps))
    end
end