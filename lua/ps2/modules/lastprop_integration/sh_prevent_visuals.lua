local function visuals(ply)
	if ply:IsSpec() or ply:IsDisguised() or not ply:Alive() then
		return false
	end
end

local function swep(ply)
	if ply:IsSpec() or not ply:Alive() or (ply:Team() == TEAM.PROPS and not ply:IsLastMan() and (GAMEMODE:InPreRound() or GAMEMODE:InRound())) then
		return false
	end
end

hook.Add( "PS2_VisualsShouldShow", "LPS:PS2_VisualsShouldShow", visuals )
hook.Add( "PS2_PlayermodelShouldShow", "LPS:PS2_PlayermodelShouldShow", visuals )
hook.Add( "PS2_WeaponShouldSpawn", "LPS:PS2_WeaponShouldSpawn", swep )
