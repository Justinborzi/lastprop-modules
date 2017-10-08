
CreateClientConVar( "showspawns", "0", true, true )

spawns = spawns or {} 
hook.Add("PostDrawTranslucentRenderables", "SpawnSphere", function()
    if (not LocalPlayer():IsAdmin() or not GetConVar("showspawns"):GetBool()) then return end

    for id, info in pairs(spawns) do
        for i, data in pairs(info) do
            
            local color = team.GetColor(id)

            if (not IsColor(color)) then
                color = Color(0,0,0)
            end

            render.SetColorMaterial()
            render.DrawSphere(data.pos, 50, 15, 15, util.SetAlpha(color, 50))

            local pos = data.pos + Vector(0, 0, 20)
            local ang = (LocalPlayer():EyePos() - pos):Angle()

            ang.p = 0
            ang:RotateAroundAxis(ang:Right(), 90)
            ang:RotateAroundAxis(ang:Up(), 90)
            ang:RotateAroundAxis(ang:Forward(), 180)

            cam.Start3D2D(pos, ang, 0.04)
                surface.SetFont("LPS80")
                local w, h = surface.GetTextSize(data.class)
                draw.SimpleText(data.class, "LPS80", 0, 0, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
            cam.End3D2D()
        end
    end
end)

lps.net.Hook( "SpawnSpheres", function( data )
    spawns = data
end)