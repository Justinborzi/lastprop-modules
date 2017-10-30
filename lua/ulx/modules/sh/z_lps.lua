local commands = {
    -------------------------------------------------------------------------
    --- Gamemode
    -------------------------------------------------------------------------
    endround = {
        category    = "Lastprop",
        command     = "ulx endround",
        func        = ulx.endround,
        say         = { "!endround" },
        help        = "Ends the round.",
        access      = ULib.ACCESS_ADMIN,
    },
    endgame = {
        category    = "Lastprop",
        command     = "ulx endgame",
        func        = ulx.endgame,
        say         = { "!endgame" },
        help        = "Ends game.",
        access      = ULib.ACCESS_ADMIN,
    },
    setroundtime = {
        category    = "Lastprop",
        command     = "ulx setroundtime",
        func        = ulx.setroundtime,
        say         = { "!setroundtime" },
        help        = "Sets round time.",
        access      = ULib.ACCESS_ADMIN,
        params      = {
            { type=ULib.cmds.NumArg, min=5, default=30, max=1800, ULib.cmds.optional, hint="Round time" },
        },
    },
    addroundtime = {
        category    = "Lastprop",
        command     = "ulx addroundtime",
        func        = ulx.addroundtime,
        say         = { "!addroundtime" },
        help        = "Adds time to round.",
        access      = ULib.ACCESS_ADMIN,
        params      = {
            { type=ULib.cmds.NumArg, min=5, default=30, max=1800, ULib.cmds.optional, hint="Round time" },
        },
    },
    undisguise = {
        category    = "Lastprop",
        command     = "ulx undisguise",
        func        = ulx.undisguise,
        say         = { "!undisguise" },
        help        = "Undisguises a player.",
        access      = ULib.ACCESS_ADMIN,
        params      = {
            { type=ULib.cmds.PlayerArg }
        },
    },
    taunt = {
        category    = "Lastprop",
        command     = "ulx taunt",
        func        = ulx.taunt,
        say         = { "!taunt" },
        help        = "Makes player taunt.",
        access      = ULib.ACCESS_ADMIN,
        params      = {
            { type=ULib.cmds.PlayerArg },
            { type=ULib.cmds.StringArg, hint="Taunt" },
            { type=ULib.cmds.StringArg, hint="Pack" },
        },
    },
    forceswap = {
        category    = "Lastprop",
        command     = "ulx fswap",
        func        = ulx.forceswap,
        say         = { "!fswap" },
        help        = "Makes player join the opposite team.",
        access      = ULib.ACCESS_ADMIN,
        params      = {
            { type=ULib.cmds.PlayerArg },
        },
    },
    fspec = {
        category    = "Lastprop",
        command     = "ulx fspec",
        func        = ulx.fspec,
        say         = { "!fspec" },
        help        = "Makes player join spectators/leave team.",
        access      = ULib.ACCESS_ADMIN,
        params      = {
            { type=ULib.cmds.PlayerArg },
        },
        opposite    = {
            command = "ulx unspec",
            args    =  { _, _, true },
            say     = {"!unspec"},
        },
    },
    kliner = {
        category    = "Lastprop",
        command     = "ulx kliner",
        func        = ulx.kliner,
        say         = { "!kliner" },
        help        = "Makes player turn into a kliner.",
        access      = ULib.ACCESS_ADMIN,
        params      = {
            { type=ULib.cmds.PlayerArg },
        },
    },

    -------------------------------------------------------------------------
    --- mapvote
    -------------------------------------------------------------------------
    mapvote = {
        category    = "Mapvote",
        command     = "ulx mapvote",
        func        = ulx.mapvote,
        say         = { "!mapvote" },
        help        = "Starts/Stops a mapvote.",
        access      = ULib.ACCESS_ADMIN,
        params      = {
            { type=ULib.cmds.NumArg, min=15, default=20, max=60, ULib.cmds.optional, hint="Vote time" },
            { type=ULib.cmds.BoolArg, invisible=true },
        },
        opposite    = {
            command = "ulx unmapvote",
            args    =  { _, _, true },
            say     = {"!unmapvote"},
        },
    },
    rtvreset = {
        category    = "Mapvote",
        command     = "ulx rtvreset",
        func        = ulx.rtvreset,
        say         = {"!rtvreset"},
        help        = "Resets the RTV.",
        access      = ULib.ACCESS_ADMIN,
    },
}

local function addcommand( id, cmd )

    if ( SERVER ) then
        if ( cmd.addaccess ) then
            ULib.ucl.registerAccess( cmd.addaccess.name, cmd.addaccess.default, cmd.addaccess.info, cmd.addaccess.category )
        end
    end

    local ulx_cmd = ulx.command( cmd.category, cmd.command, cmd.func, cmd.say )
    if ( cmd.params ) then
        for _, v in pairs( cmd.params ) do
            ulx_cmd:addParam(v)
        end
    end
    if ( cmd.opposite ) then
        ulx_cmd:setOpposite( cmd.opposite.command, cmd.opposite.args, cmd.opposite.say )
    end
    if ( cmd.help ) then
        ulx_cmd:help( cmd.help )
    end
    if ( cmd.access ) then
        ulx_cmd:defaultAccess( cmd.access )
    end

    commands[id] = ulx_cmd
end

for id, v in pairs( commands ) do
    addcommand( id, v )
end