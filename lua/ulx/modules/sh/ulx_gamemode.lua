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
    if (target_ply:IsDisguised()) then
        target_ply:UnDisguise()
        ulx.fancyLogAdmin(calling_ply, "#A made #T undisguise!", target_ply)
    else
        ULib.tsayError( calling_ply, target_ply:Nick() .. " is not disguised!" )
    end
end

function ulx.taunt(calling_ply, target_ply, taunt)
    if (taunt) then
        target_ply:PlayTaunt(taunt)
    else
        target_ply:RandomTaunt()
    end
    ulx.fancyLogAdmin( calling_ply, "#A made #T taunt!", target_ply )
end