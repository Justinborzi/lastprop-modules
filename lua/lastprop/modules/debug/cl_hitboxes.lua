CreateClientConVar( "hitboxes", "0", true, true )

hook.Add("PostDrawOpaqueRenderables", "HitboxRender", function()
	
    if ( not LocalPlayer():IsAdmin() or not GetConVar( "hitboxes" ):GetBool() ) then return end

	for _, ent in pairs( ents.FindInSphere( LocalPlayer():GetPos(), 500 ) ) do
		if ( IsValid( ent ) ) and (ent ~= LocalPlayer()) and ( ent:IsPlayer() or ent:IsRagdoll() or ent:IsNPC() or ent:IsValidDisguise() or table.HasValue( {"prop_physics", "prop_physics_multiplayer", "disguise" } , ent:GetClass() ) ) then
			if ent:GetHitBoxGroupCount() ~= nil then
				for group = 0, ent:GetHitBoxGroupCount() - 1 do
					for hitbox = 0, ent:GetHitBoxCount( group ) - 1 do
						local pos, ang =  ent:GetBonePosition( ent:GetHitBoxBone( hitbox, group ) )
						local mins, maxs = ent:GetHitBoxBounds( hitbox, group )
						render.DrawWireframeBox( pos, ang, mins, maxs, Color( 51, 204, 255, 255 ), true )
					end
				end
				render.DrawWireframeBox( ent:GetPos(), Angle( 0, 0, 0 ), ent:OBBMins(), ent:OBBMaxs(), Color( 255, 204, 51, 255 ), true )
			end
		end
	end
	
end )