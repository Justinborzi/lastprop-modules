--If player is in spec and has no model equipped use a Combine as preview
hook.Add( "PS2_GetPreviewModel", "LPS:Default", function( )
	if ((LocalPlayer():Team() == TEAM.PROPS and LocalPlayer():IsDisguised()) or LocalPlayer():IsSpec()) then
		return {
			model = 'models/player/group01/male_01.mdl',
			bodygroups = "0",
			skin = 0
		}
	end
end )
