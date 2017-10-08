CreateClientConVar( "showplayers", "0", true, true )

hook.Add( "PreDrawHalos", "ShowPlayers", function()

    if ( not LocalPlayer():IsAdmin() or not GetConVar( "showplayers" ):GetBool() ) then return end

    local props = {}
    for _, v in pairs( team.GetPlayers( TEAM.PROPS ) ) do
        if ( v:Alive() ) then
            if ( v:IsDisguised() ) then
                local disguise = v:GetDisguise()
                if (IsValid(disguise)) then
                    table.insert(props, disguise)
                end
            else
                if (IsValid( v ) ) then
                    table.insert( props, v )
                end
            end
        end
    end

    if ( table.Count( props ) >= 1 ) then
        halo.Add( props, team.GetColor( TEAM.PROPS ), 2, 2, 2, true, true )
    end

    local hunters = {}
    for _, v in pairs( team.GetPlayers( TEAM.HUNTERS ) ) do
        if ( v:Alive() and IsValid( v ) ) then
            table.insert( hunters, v )
        end
    end

    if ( table.Count( hunters ) >= 1 ) then
        halo.Add( hunters, team.GetColor( TEAM.HUNTERS ), 2, 2, 2, true, true )
    end

end)
