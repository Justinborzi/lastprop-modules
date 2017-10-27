function ulx.endround(calling_ply)
    if (GAMEMODE:InRound()) then
        GAMEMODE:RoundEnd(ROUND.DRAW)
        ulx.fancyLogAdmin(calling_ply, "#A ended the round!")
    end
end

function ulx.endgame(calling_ply)
    if (GAMEMODE:InGame()) then
        hook.Add('CanStartNextRound', 'ulx:endround', function()
            timer.Simple(0.5, function() GAMEMODE:EndGame() end)
            return false
        end)
    else
        GAMEMODE:EndGame()
    end
    ulx.fancyLogAdmin(calling_ply, "#A ended the game!")
end

function ulx.setroundtime(calling_ply, time)
    if (GAMEMODE:InRound()) then
        GAMEMODE:SetRoundTime(time)
        ulx.fancyLogAdmin(calling_ply, "#A set round time to #s!", time)
    end
end

function ulx.addroundtime(calling_ply, time)
    if (GAMEMODE:InRound()) then
        GAMEMODE:AddRoundTime(time)
        ulx.fancyLogAdmin(calling_ply, "#A added #s time to the round!", time)
    end
end

function ulx.undisguise(calling_ply, target_ply)
    if (not target_ply:IsDisguised()) then
        ULib.tsayError( calling_ply, "#T is not disguised!",  target_ply)
        return
    end

    target_ply:UnDisguise()

    if target_ply:IsStuck() then
        target_ply:UnStick()
    end

    ulx.fancyLogAdmin(calling_ply, "#A made #T undisguise!", target_ply)
end

function ulx.kliner( calling_ply, target_ply )
    if (not target_ply:Team() ~= TEAM.PROPS) then
        ULib.tsayError(calling_ply, "#T is not a prop!", target_ply)
        return
    end
    target_ply:Disguise()
    if target_ply:IsStuck() then
        target_ply:UnStick()
    end
    ulx.fancyLogAdmin( calling_ply, "#A has forced #T to become a kliner.", target_ply )
end

function ulx.taunt(calling_ply, target_ply, taunt, pack)
    if (taunt) then
        target_ply:PlayTaunt(taunt, pack)
    else
        target_ply:RandomTaunt()
    end
    ulx.fancyLogAdmin( calling_ply, "#A made #T taunt!", target_ply )
end

function ulx.fspec(calling_ply, opposite)
    if (not opposite and target_ply:Team() == TEAM.SPECTATORS) then
        ULib.tsayError(calling_ply, "#T is already a spectator!", target_ply)
        return
    elseif (opposite and target_ply:Team() ~= TEAM.SPECTATORS) then
        ULib.tsayError(calling_ply, "#T is not spectating!", target_ply)
        return
    end
    GAMEMODE:PlayerSetTeam(target_ply, opposite and team.BestAutoJoinTeam() or TEAM.SPECTATORS)
    ulx.fancyLogAdmin( calling_ply, opposite and "#A forced #T to spectators!" or "#A forced #T to join the game!", target_ply )
end

function ulx.forceswap( calling_ply, target_ply )
    GAMEMODE:PlayerSetTeam(target_ply, target_ply:Team() == TEAM.PROPS and TEAM.HUNTERS or TEAM.PROPS)
    ulx.fancyLogAdmin( calling_ply, "#A has forced #T to switch teams.", target_ply )
end
