--[[---------------------------------------------------------
Scoreboard Hooks:
------------------------------------------------------------

hook.Add('GetPlayerScoreboardIconText', 'ULX:GetPlayerScoreboardIconText', function(ply)
    local text = {
        ['owner'] = 'Owner',
        ['co-owner'] = 'Co Owner',
        ['admin'] = 'Admin',
        ['moderator'] = 'Moderator',
        ['trusted'] = 'Trusted',
        ['donor'] = 'Donor',
    }

    if (text[ply:GetUserGroup()]) then
        return text[ply:GetUserGroup()]
    end
end)

hook.Add('GetPlayerScoreboardIcon', 'ULX:GetPlayerScoreboardIcon', function(ply)
    local icons = {
        ['owner'] = 'icon16/shield.png',
        ['co-owner'] = 'icon16/shield.png',
        ['admin'] = 'icon16/shield.png',
        ['moderator'] = 'icon16/.png',
        ['trusted'] = 'icon16/heart.png',
        ['donor'] = 'icon16/heart.png',
    }

    if (icons[ply:GetUserGroup()]) then
        return icons[ply:GetUserGroup()]
    end
end)

hook.Add('GetPlayerScoreboardColor', 'ULX:GetPlayerScoreboardColor', function(ply)
    if (ply:IsAdmin()) then
        return util.Rainbow(nil, nil, 180)
    end
end)
---------------------------------------------------------]]--