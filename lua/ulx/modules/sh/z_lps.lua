local commands = {
    -------------------------------------------------------------------------
    --- Gamemode
    -------------------------------------------------------------------------

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
            { type=ULib.cmds.NumArg, min=15, default=20, max=60, ULib.cmds.optional, hint="Votetime" },
            { type=ULib.cmds.BoolArg, invisible=true },
        },
        opposite    = {
            command = "ulx unmapvote",
            args    =  { _, _, true },
            say     = {"!unmapvote"}
        }
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