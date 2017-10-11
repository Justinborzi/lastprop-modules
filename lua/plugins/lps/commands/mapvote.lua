-------------------------------------------------------------------------
--- mapvote
-------------------------------------------------------------------------
local command = {};
command.help		= "Starts a mapvote.";
command.command 	= "mapvote";
command.arguments = { "time" };
command.permissions	= "Mapvote";

function command:Execute(player, silent, arguments)
    MapVote:Start(tonumber(arguments[1]))
    serverguard.Notify(nil, SERVERGUARD.NOTIFY.GREEN, serverguard.player:GetName(player), SERVERGUARD.NOTIFY.WHITE, " started a mapvote.")
end;
plugin:AddCommand(command);

-------------------------------------------------------------------------
--- unmapvote
-------------------------------------------------------------------------
local command = {};
command.help		= "Stops a mapvote.";
command.command 	= "unmapvote";
command.permissions	= "Unmapvote";

function command:Execute(player, silent, arguments)
    MapVote:Stop()
    serverguard.Notify(nil, SERVERGUARD.NOTIFY.GREEN, serverguard.player:GetName(player), SERVERGUARD.NOTIFY.WHITE, " stopped the mapvote.")
end;
plugin:AddCommand(command);

-------------------------------------------------------------------------
--- rtvreset
-------------------------------------------------------------------------
local command = {};
command.help		= "Resets the RTV.";
command.command 	= "rtvreset";
command.permissions	= "RTV Reset";

function command:Execute(player, silent, arguments)
    serverguard.Notify(nil, SERVERGUARD.NOTIFY.GREEN, serverguard.player:GetName(player), SERVERGUARD.NOTIFY.WHITE, " reset the RTV.")
end;
plugin:AddCommand(command);