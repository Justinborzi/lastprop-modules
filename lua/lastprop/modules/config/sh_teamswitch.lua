--[[---------------------------------------------------------
Example Limit Spectator:
------------------------------------------------------------

hook.Add('PlayerCanJoinTeam', 'ULX:PlayerCanJoinTeam', function(ply, teamID)
    local switches = {
        ['owner'] = true,
        ['co-owner'] = true,
        ['admin'] = true,
        ['moderator'] = true,
        ['trusted'] = true,
        ['donor'] = true,
    }

    if (teamID == TEAM.SPECTATORS and not switches[ply:GetUserGroup()]) then
        return false, 'You're not allowed to spectate!'
    end
end)

-------------------------------------------------------------
Example Team Switch Limit:
------------------------------------------------------------

This hook is called everytime a player request to switch to another team.

hook.Add('PlayerMaxTeamSwitch', 'ULX:PlayerMaxTeamSwitch', function(ply, teamID)

    if (table.HasValue({TEAM.SPECTATORS, TEAM.UNASSIGNED, TEAM.CONNECTING}, teamID)) then
        return 0 -- 0 means they can switch unlimited times, or to bypass the current switch
    end

    local switches = {
        ['owner'] = 0, --bypass
        ['co-owner'] = 0, --bypass
        ['admin'] = 10,
        ['moderator'] = 10,
        ['trusted'] = 5,
        ['donor'] = 4,
    }

    local amount = switches[ply:GetUserGroup()]

    if (amount) then
        if (amount > 0) then
            util.Notify(ply, NOTIFY.RED, string.format('You have %s more team switches available this game.', amount - ply:GetVar('teamChanges', 0)))
        end
        return amount
    end

    return 2 -- default

end)
---------------------------------------------------------]]--