AddCSLuaFile('cl_init.lua')
AddCSLuaFile('sh_init.lua')

include('sh_init.lua')

function GM:RoundEndWithResult( result, resulttext ) end

hook.Add("OnRoundEnd", "PH:OnRoundEnd", function(teamID, num)
    if (teamID == ROUND.TIMER) then
        hook.Call( 'RoundEndWithResult', GAMEMODE, TEAM.PROPS, 'Round Over! ' .. team.GetName(TEAM.PROPS) .. ' Won!' )
    elseif (teamID ~= ROUND.DRAW) then
        hook.Call( 'RoundEndWithResult', GAMEMODE, teamID, 'Round Over! ' .. team.GetName(teamID) .. ' Won!' )
    else
        hook.Call( 'RoundEndWithResult', GAMEMODE, -1, 'Round Over! Nobody Won!' )
    end
end)