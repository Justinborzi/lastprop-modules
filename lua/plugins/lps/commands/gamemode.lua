-------------------------------------------------------------------------
--- endround
-------------------------------------------------------------------------
local command = {}
command.help		= "Ends the round."
command.command 	= "endround"
command.permissions	= "EndRound"

function command:Execute(player, silent, arguments)
    if (GAMEMODE:InRound()) then
        GAMEMODE:RoundEnd(ROUND.DRAW)

        serverguard.Notify(nil,
        SERVERGUARD.NOTIFY.GREEN, serverguard.player:GetName(player),
        SERVERGUARD.NOTIFY.WHITE, " ended the round!")
    end
end
plugin:AddCommand(command)

-------------------------------------------------------------------------
--- endgame
-------------------------------------------------------------------------
local command = {}
command.help		= "Ends game."
command.command 	= "endgame"
command.permissions	= "EndGame"

function command:Execute(player, silent, arguments)
    if (GAMEMODE:InGame()) then
        hook.Add('CanStartNextRound', 'ulx:endround', function()
            timer.Simple(0.5, function() GAMEMODE:EndGame() end)
            return false
        end)
    else
        GAMEMODE:EndGame()
    end

    serverguard.Notify(nil,
    SERVERGUARD.NOTIFY.GREEN, serverguard.player:GetName(player),
    SERVERGUARD.NOTIFY.WHITE, " ended the game!")
end
plugin:AddCommand(command)

-------------------------------------------------------------------------
--- addroundtime
-------------------------------------------------------------------------
local command = {}
command.help		= "Adds time to round."
command.command 	= "addroundtime"
command.arguments = { "time" }
command.permissions	= "AddRoundTime"

function command:Execute(player, silent, arguments)
    local time = tonumber(arguments[1] or 0 )
    if (GAMEMODE:InRound()) then
        GAMEMODE:AddRoundTime(time)
        serverguard.Notify(nil,
        SERVERGUARD.NOTIFY.GREEN, serverguard.player:GetName(player),
        SERVERGUARD.NOTIFY.WHITE, " added ",
        SERVERGUARD.NOTIFY.RED, time,
        SERVERGUARD.NOTIFY.WHITE, "time to the round!")
    end
end
plugin:AddCommand(command)

-------------------------------------------------------------------------
--- setroundtime
-------------------------------------------------------------------------
local command = {}
command.help		= "Sets round time."
command.command 	= "setroundtime"
command.arguments = { "time" }
command.permissions	= "SetRoundTime"

function command:Execute(player, silent, arguments)
    local time = tonumber(arguments[1] or 30 )
    if (GAMEMODE:InRound()) then
        GAMEMODE:SetRoundTime(time)
        serverguard.Notify(nil,
        SERVERGUARD.NOTIFY.GREEN, serverguard.player:GetName(player),
        SERVERGUARD.NOTIFY.WHITE, " set round time to ",
        SERVERGUARD.NOTIFY.RED, time,
        SERVERGUARD.NOTIFY.WHITE, "!")
    end
end
plugin:AddCommand(command)

-------------------------------------------------------------------------
--- undisguise
-------------------------------------------------------------------------
local command = {}
command.help		= "Undisguises a player."
command.command 	= "undisguise"
command.arguments = { "player" }
command.permissions	= "Undisguise"

function command:Execute(player, silent, arguments)
    local target = util.FindPlayer(arguments[1], player)

    if (serverguard.player:GetImmunity(target) > serverguard.player:GetImmunity(player)) then
        serverguard.Notify(player, SERVERGUARD.NOTIFY.RED, "This player has a higher immunity than you.");
        return;
    end;

    if (target:IsDisguised()) then
        target:UnDisguise()

        if target:IsStuck() then
            target:UnStick()
        end
        serverguard.Notify(nil,
        SERVERGUARD.NOTIFY.GREEN, serverguard.player:GetName(player),
        SERVERGUARD.NOTIFY.WHITE, " made ",
        SERVERGUARD.NOTIFY.RED, serverguard.player:GetName(target),
        SERVERGUARD.NOTIFY.WHITE, " undisguise!")
    else
        serverguard.Notify(player, SERVERGUARD.NOTIFY.RED, serverguard.player:GetName(player), " is not disguised!")
    end
end
plugin:AddCommand(command)

-------------------------------------------------------------------------
--- taunt
-------------------------------------------------------------------------
local command = {}
command.help		= "Makes player taunt."
command.command 	= "taunt"
command.arguments	= {"player"}
command.optionalArguments = {"taunt"}
command.permissions	= "Taunt"

function command:Execute(player, silent, arguments)
    local target = util.FindPlayer(arguments[1], player)
    local taunt = arguments[2]

    if (serverguard.player:GetImmunity(target) > serverguard.player:GetImmunity(player)) then
        serverguard.Notify(player, SERVERGUARD.NOTIFY.RED, "This player has a higher immunity than you.");
        return;
    end;

    if (taunt) then
        target_ply:PlayTaunt(taunt)
    else
        target_ply:RandomTaunt()
    end

    serverguard.Notify(nil,
    SERVERGUARD.NOTIFY.GREEN, serverguard.player:GetName(player),
    SERVERGUARD.NOTIFY.WHITE, " made ",
    SERVERGUARD.NOTIFY.RED, serverguard.player:GetName(target),
    SERVERGUARD.NOTIFY.WHITE, " taunt!")
end
plugin:AddCommand(command)