
-------------------------------------------------------------------------
--- Add XP
-------------------------------------------------------------------------
local command = {};
command.help		= "Adds XP to player.";
command.command 	= "addxp";
command.arguments = {"player", "ammount"};
command.permissions	= "Add XP";

function command:Execute(player, silent, arguments)
    local target = util.FindPlayer(arguments[1], player);
    local ammount = tonumber(arguments[2])
    if (IsValid(target)) then
        if (serverguard.player:GetImmunity(target) > serverguard.player:GetImmunity(player)) then
            serverguard.Notify(player, SERVERGUARD.NOTIFY.RED, "This player has a higher immunity than you.");
            return;
        end;

        target:addXP(amount, true)

        if (!silent) then
            serverguard.Notify(nil, 
            SERVERGUARD.NOTIFY.GREEN, serverguard.player:GetName(player), 
            SERVERGUARD.NOTIFY.WHITE, " gave ", 
            SERVERGUARD.NOTIFY.RED, serverguard.player:GetName(target), 
            SERVERGUARD.NOTIFY.WHITE, " " .. amount .. " XP.");
        end;
    end
end;
plugin:AddCommand(command); 


-------------------------------------------------------------------------
--- Set Level
-------------------------------------------------------------------------
local command = {};
command.help		= "Set's a players level.";
command.command 	= "setlevel";
command.arguments = {"player", "level"};
command.permissions	= "Set Level";

function command:Execute(player, silent, arguments)
    local target = util.FindPlayer(arguments[1], player);
    local level = tonumber(arguments[2])
    if (IsValid(target)) then
        if (serverguard.player:GetImmunity(target) > serverguard.player:GetImmunity(player)) then
            serverguard.Notify(player, SERVERGUARD.NOTIFY.RED, "This player has a higher immunity than you.");
            return;
        end;
        
        if target.DarkRPUnInitialized then 
            serverguard.Notify(player, SERVERGUARD.NOTIFY.RED, "This player has not been initialized.");
            return 
        end

	    DarkRP.storeXPData( target, level, 0)
        target:setDarkRPVar('level', level)
        target:setDarkRPVar('xp', 0)

        if (!silent) then
            serverguard.Notify(nil, 
            SERVERGUARD.NOTIFY.GREEN, serverguard.player:GetName(player), 
            SERVERGUARD.NOTIFY.WHITE, " set ", 
            SERVERGUARD.NOTIFY.RED, serverguard.player:GetName(target), 
            SERVERGUARD.NOTIFY.WHITE, " level to " .. level);
        end;
    end
end;
plugin:AddCommand(command); 

-------------------------------------------------------------------------
--- Arrest
-------------------------------------------------------------------------
local command = {};
command.help		= "Arrest a player.";
command.command 	= "arrest";
command.arguments = {"player"};
command.optionalArguments	= {"minutes"};
command.permissions	= "Arrest";

function command:Execute(player, silent, arguments)
    local target = util.FindPlayer(arguments[1], player);
    local time = tonumber(arguments[2] or 1) * 60
    if (IsValid(target)) then
        if (serverguard.player:GetImmunity(target) > serverguard.player:GetImmunity(player)) then
            serverguard.Notify(player, SERVERGUARD.NOTIFY.RED, "This player has a higher immunity than you.");
            return;
        end;
        
        if (target:RHC_IsArrested()) then
            serverguard.Notify(player, SERVERGUARD.NOTIFY.RED, "This player is already arrested.");
            return;
        end

        target:RHC_Arrest(time, player)

        if (!silent) then
            serverguard.Notify(nil, 
            SERVERGUARD.NOTIFY.GREEN, serverguard.player:GetName(player), 
            SERVERGUARD.NOTIFY.WHITE, " arrested ", 
            SERVERGUARD.NOTIFY.RED, serverguard.player:GetName(target), 
            SERVERGUARD.NOTIFY.WHITE, ".");
        end;
    end
end;
plugin:AddCommand(command); 


-------------------------------------------------------------------------
--- Unarrest
-------------------------------------------------------------------------
local command = {};
command.help		= "Unarrest a player.";
command.command 	= "unarrest";
command.arguments = {"player"};
command.permissions	= "Unarrest";

function command:Execute(player, silent, arguments)
    local target = util.FindPlayer(arguments[1], player);
    if (IsValid(target)) then
        if (serverguard.player:GetImmunity(target) > serverguard.player:GetImmunity(player)) then
            serverguard.Notify(player, SERVERGUARD.NOTIFY.RED, "This player has a higher immunity than you.");
            return;
        end;

        if not target:RHC_IsArrested() then
            serverguard.Notify(player, SERVERGUARD.NOTIFY.RED, "This player is not arrested.");
            return;
        end

        target:RHC_UnArrest(true)

         if (!silent) then
            serverguard.Notify(nil, 
            SERVERGUARD.NOTIFY.GREEN, serverguard.player:GetName(player), 
            SERVERGUARD.NOTIFY.WHITE, " released ", 
            SERVERGUARD.NOTIFY.RED, serverguard.player:GetName(target), 
            SERVERGUARD.NOTIFY.WHITE, " from jail.");
        end;
    end
end;
plugin:AddCommand(command); 


-------------------------------------------------------------------------
--- End Hit
-------------------------------------------------------------------------
local command = {};
command.help		= "End a hit on a player.";
command.command 	= "endhit";
command.arguments   = {"player"};
command.permissions	= "End Hit";

function command:Execute(player, silent, arguments)
    local target = util.FindPlayer(arguments[1], player);
    local level = tonumber(arguments[2])
    if (IsValid(target)) then
        if (serverguard.player:GetImmunity(target) > serverguard.player:GetImmunity(player)) then
            serverguard.Notify(player, SERVERGUARD.NOTIFY.RED, "This player has a higher immunity than you.");
            return;
        end;
        

        if ( not target:hasHit() ) then
            serverguard.Notify(player, SERVERGUARD.NOTIFY.RED, "This player doesn't have a hit on him.");
            return;
        end

        target:finishHit()

        if (!silent) then
            serverguard.Notify(nil, 
            SERVERGUARD.NOTIFY.GREEN, serverguard.player:GetName(player), 
            SERVERGUARD.NOTIFY.WHITE, " removed the hit on ", 
            SERVERGUARD.NOTIFY.RED, serverguard.player:GetName(target), 
            SERVERGUARD.NOTIFY.WHITE, ".");
        end;
    end
end;
plugin:AddCommand(command); 

-------------------------------------------------------------------------
--- Set Money
-------------------------------------------------------------------------
local command = {};
command.help		= "Set's a players money.";
command.command 	= "setmoney";
command.arguments = {"player", "money"};
command.permissions	= "Set Money";

function command:Execute(player, silent, arguments)
    local target = util.FindPlayer(arguments[1], player);
    local amount = tonumber(arguments[2])
    if (IsValid(target)) then
        if (serverguard.player:GetImmunity(target) > serverguard.player:GetImmunity(player)) then
            serverguard.Notify(player, SERVERGUARD.NOTIFY.RED, "This player has a higher immunity than you.");
            return;
        end;
        
        DarkRP.storeMoney(target, amount)
        target:setDarkRPVar("money", amount)

        if (!silent) then
            serverguard.Notify(nil, 
            SERVERGUARD.NOTIFY.GREEN, serverguard.player:GetName(player), 
            SERVERGUARD.NOTIFY.WHITE, " set ", 
            SERVERGUARD.NOTIFY.RED, serverguard.player:GetName(target), 
            SERVERGUARD.NOTIFY.WHITE, " money to " .. amount);
        end;
    end
end;
plugin:AddCommand(command); 

-------------------------------------------------------------------------
--- Take Money
-------------------------------------------------------------------------
local command = {};
command.help		= "Takes money to a player.";
command.command 	= "takemoney";
command.arguments = {"player", "money"};
command.permissions	= "Take Money";

function command:Execute(player, silent, arguments)
    local target = util.FindPlayer(arguments[1], player);
    local amount = math.floor(tonumber(arguments[2])) 
    if (IsValid(target)) then
        if (serverguard.player:GetImmunity(target) > serverguard.player:GetImmunity(player)) then
            serverguard.Notify(player, SERVERGUARD.NOTIFY.RED, "This player has a higher immunity than you.");
            return;
        end;
        
        target:addMoney(-amount)

        if (!silent) then
            serverguard.Notify(nil, 
            SERVERGUARD.NOTIFY.GREEN, serverguard.player:GetName(player), 
            SERVERGUARD.NOTIFY.WHITE, " took $" .. amount .. " from " , 
            SERVERGUARD.NOTIFY.RED, serverguard.player:GetName(target));
        end;
    end
end;
plugin:AddCommand(command); 

-------------------------------------------------------------------------
--- Add Money
-------------------------------------------------------------------------
local command = {};
command.help		= "Adds money to a player.";
command.command 	= "addmoney";
command.arguments = {"player", "money"};
command.permissions	= "Add Money";

function command:Execute(player, silent, arguments)
    local target = util.FindPlayer(arguments[1], player);
    local amount = math.floor(tonumber(arguments[2])) 
    if (IsValid(target)) then
        if (serverguard.player:GetImmunity(target) > serverguard.player:GetImmunity(player)) then
            serverguard.Notify(player, SERVERGUARD.NOTIFY.RED, "This player has a higher immunity than you.");
            return;
        end;
        
        target:addMoney(amount)

        if (!silent) then
            serverguard.Notify(nil, 
            SERVERGUARD.NOTIFY.GREEN, serverguard.player:GetName(player), 
            SERVERGUARD.NOTIFY.WHITE, " gave $" .. amount .. " to " , 
            SERVERGUARD.NOTIFY.RED, serverguard.player:GetName(target));
        end;
    end
end;
plugin:AddCommand(command); 

-------------------------------------------------------------------------
--- Set Name
-------------------------------------------------------------------------
local command = {};
command.help		= "Set's a players name.";
command.command 	= "setname";
command.arguments = {"player", "name"};
command.permissions	= "Set Name";

function command:Execute(player, silent, arguments)
    local target = util.FindPlayer(arguments[1], player);
    local name = table.concat(arguments, " ", 2);

    if (IsValid(target)) then
        if (serverguard.player:GetImmunity(target) > serverguard.player:GetImmunity(player)) then
            serverguard.Notify(player, SERVERGUARD.NOTIFY.RED, "This player has a higher immunity than you.");
            return;
        end;
        
        target:setRPName(name)

        if (!silent) then
            serverguard.Notify(nil, 
            SERVERGUARD.NOTIFY.GREEN, serverguard.player:GetName(player), 
            SERVERGUARD.NOTIFY.WHITE, " set ", 
            SERVERGUARD.NOTIFY.RED, serverguard.player:GetName(target), 
            SERVERGUARD.NOTIFY.WHITE, " name to " .. name);
        end;
    end
end;
plugin:AddCommand(command); 

-------------------------------------------------------------------------
--- RP Vito
-------------------------------------------------------------------------
local command = {};
command.help		= "Vito current vote";
command.command 	= "vito";
command.permissions	= "Vito";

function command:Execute(player, silent, arguments)
    DarkRP.destroyLastVote()
    if (!silent) then
        serverguard.Notify(nil, 
        SERVERGUARD.NOTIFY.GREEN, serverguard.player:GetName(player), 
        SERVERGUARD.NOTIFY.WHITE, " vitoed the last vote.");
    end;
end;
plugin:AddCommand(command); 

-------------------------------------------------------------------------
--- Lockdown
-------------------------------------------------------------------------
local command = {};
command.help		= "Toggles lockdown state.";
command.command 	= "lockdown";
command.permissions	= "Lockdown";

function command:Execute(player, silent, arguments)
    if tobool(GetConVarNumber("DarkRP_Lockdown")) then
		RunConsoleCommand("rp_unlockdown")
		if (!silent) then
            serverguard.Notify(nil, 
            SERVERGUARD.NOTIFY.GREEN, serverguard.player:GetName(player), 
            SERVERGUARD.NOTIFY.WHITE, " ended the lockdown.");
        end;
	else
		RunConsoleCommand("rp_lockdown")
        if (!silent) then
            serverguard.Notify(nil, 
            SERVERGUARD.NOTIFY.GREEN, serverguard.player:GetName(player), 
            SERVERGUARD.NOTIFY.WHITE, " started a lockdown.");
        end;
	end
end;
plugin:AddCommand(command); 

-------------------------------------------------------------------------
--- Set Job
-------------------------------------------------------------------------
local command = {};
command.help		= "Set's a players job.";
command.command 	= "setjob";
command.arguments = {"player", "job"};
command.permissions	= "Set Job";

function command:Execute(player, silent, arguments)
    local target = util.FindPlayer(arguments[1], player);
    local jobname = arguments[2]
    if (IsValid(target)) then
        if (serverguard.player:GetImmunity(target) > serverguard.player:GetImmunity(player)) then
            serverguard.Notify(player, SERVERGUARD.NOTIFY.RED, "This player has a higher immunity than you.");
            return;
        end;
        
        local job, index = DarkRP.getJobByCommand(jobname)

        if (not job) then
            serverguard.Notify(player, SERVERGUARD.NOTIFY.RED, "Can't find that job!");
            return;
        end;

        target:changeTeam(index, true, true)

        if (!silent) then
            serverguard.Notify(nil, 
            SERVERGUARD.NOTIFY.GREEN, serverguard.player:GetName(player), 
            SERVERGUARD.NOTIFY.WHITE, " set ", 
            SERVERGUARD.NOTIFY.RED, serverguard.player:GetName(target), 
            SERVERGUARD.NOTIFY.WHITE, " job to " .. job.name );
        end;
    end
end;
plugin:AddCommand(command); 

-------------------------------------------------------------------------
--- Ban Job
-------------------------------------------------------------------------
local command = {};
command.help		= "Bans a players from a job.";
command.command 	= "jobban";
command.arguments = {"player", "job"};
command.optionalArguments	= {"time"};
command.permissions	= "Job Ban";

function command:Execute(player, silent, arguments)
    local target = util.FindPlayer(arguments[1], player);
    local jobname = arguments[2]
    local time = tonumber(arguments[3] or 0 )
    if (IsValid(target)) then
        if (serverguard.player:GetImmunity(target) > serverguard.player:GetImmunity(player)) then
            serverguard.Notify(player, SERVERGUARD.NOTIFY.RED, "This player has a higher immunity than you.");
            return;
        end;
        
        local job, index = DarkRP.getJobByCommand(jobname)

        if (not job) then
            serverguard.Notify(player, SERVERGUARD.NOTIFY.RED, "Can't find that job!");
            return;
        end;

        target:teamBan( index, time )

        if (!silent) then
            local timestr = "forever"
            if (time > 0) then
               timestr = time .. "seconds"
            end
            serverguard.Notify(nil, 
            SERVERGUARD.NOTIFY.GREEN, serverguard.player:GetName(player), 
            SERVERGUARD.NOTIFY.WHITE, " banned ", 
            SERVERGUARD.NOTIFY.RED, serverguard.player:GetName(target), 
            SERVERGUARD.NOTIFY.WHITE, " from  " .. job.name .. " for " .. timestr);
        end;
    end
end;
plugin:AddCommand(command); 

-------------------------------------------------------------------------
--- Unban Job
-------------------------------------------------------------------------
local command = {};
command.help		= "Unbans a players from a job.";
command.command 	= "unbanjob";
command.arguments = {"player", "job"};
command.permissions	= "Unban Job";

function command:Execute(player, silent, arguments)
    local target = util.FindPlayer(arguments[1], player);
    local jobname = arguments[2]
    if (IsValid(target)) then
        if (serverguard.player:GetImmunity(target) > serverguard.player:GetImmunity(player)) then
            serverguard.Notify(player, SERVERGUARD.NOTIFY.RED, "This player has a higher immunity than you.");
            return;
        end;
        
        local job, index = DarkRP.getJobByCommand(jobname)

        if (not job) then
            serverguard.Notify(player, SERVERGUARD.NOTIFY.RED, "Can't find that job!");
            return;
        end;

        target:teamUnBan( index )

        if (!silent) then
            serverguard.Notify(nil, 
            SERVERGUARD.NOTIFY.GREEN, serverguard.player:GetName(player), 
            SERVERGUARD.NOTIFY.WHITE, " set ", 
            SERVERGUARD.NOTIFY.RED, serverguard.player:GetName(target), 
            SERVERGUARD.NOTIFY.WHITE, " level to " .. level);
        end;
    end
end;
plugin:AddCommand(command); 

-------------------------------------------------------------------------
--- Sell Door
-------------------------------------------------------------------------
local command = {};
command.help		= "Sells the doo your looking at.";
command.command 	= "selldoor";
command.permissions	= "Sell Door";

function command:Execute(player, silent, arguments)
    local trace = util.GetPlayerTrace( player )
    local traceRes = util.TraceLine( trace )
    local tEnt = traceRes.Entity
    if tEnt:isDoor() and tEnt:isKeysOwned() then
        tEnt:keysUnOwn( tEnt:getDoorOwner() )
        serverguard.Notify(player, SERVERGUARD.NOTIFY.GREEN, "Door Sold!");
    else
        serverguard.Notify(player, SERVERGUARD.NOTIFY.RED, "The Entity must be a door, and it must be owned!");
    end
end;
plugin:AddCommand(command); 

-------------------------------------------------------------------------
--- Sell All
-------------------------------------------------------------------------
local command = {};
command.help		= "Sells all doors owned by player.";
command.command 	= "sellall";
command.arguments = {"player"};
command.permissions	= "Sell All";

function command:Execute(player, silent, arguments)
    local target = util.FindPlayer(arguments[1], player);
    if (IsValid(target)) then
        if (serverguard.player:GetImmunity(target) > serverguard.player:GetImmunity(player)) then
            serverguard.Notify(player, SERVERGUARD.NOTIFY.RED, "This player has a higher immunity than you.");
            return;
        end;

        target:keysUnOwnAll()

        if (!silent) then
            serverguard.Notify(nil, 
            SERVERGUARD.NOTIFY.GREEN, serverguard.player:GetName(player), 
            SERVERGUARD.NOTIFY.WHITE, " sold all of ", 
            SERVERGUARD.NOTIFY.RED, serverguard.player:GetName(target), 
            SERVERGUARD.NOTIFY.WHITE, " doors.");
        end;
    end
end;
plugin:AddCommand(command);
