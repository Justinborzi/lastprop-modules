local function hideOnProps(ply)
	if ply:IsSpec() or ply:IsDisguised() or not ply:Alive() then
		return false
	end
end
hook.Add( "PS2_VisualsShouldShow", "OnlyHunters", hideOnProps )
hook.Add( "PS2_PlayermodelShouldShow", "OnlyHunters", hideOnProps )
hook.Add( "PS2_WeaponShouldSpawn", "OnlyHunters", hideOnProps )
