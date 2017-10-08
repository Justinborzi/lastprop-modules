spawns = spawns or {} 
hook.Add("InitPostEntity", "SpawnSphereInit", function()
    for id, teamData in pairs(team.GetAllTeams()) do
        if(not teamData.Joinable) then continue end
        for i, ent in pairs(team.GetSpawnPoints(id)) do
            if (ent:IsValid()) then
                if (not spawns[id]) then spawns[id] = {} end
                table.insert(spawns[id], {class = ent:GetClass(), pos = ent:GetPos()})
            end
        end
    end
end)

hook.Add("PlayerInitialSpawn", "SpawnSphereSpawn", function(ply)
     lps.net.Start( nil, "SpawnSpheres", spawns )
end)