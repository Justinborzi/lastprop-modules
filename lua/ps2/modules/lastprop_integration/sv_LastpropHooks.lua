Pointshop2.PropHunt = {}

local S = function( id )
	return Pointshop2.GetSetting( "Last Prop Integration", id )
end

function Pointshop2.PropHunt.PreRoundStart( num )
	if team.NumPlayers( TEAM.PROPS ) == 0 or team.NumPlayers( TEAM.HUNTERS ) == 0 then return end
	GAMEMODE.ps2TeamPlayers = GAMEMODE.ps2TeamPlayers or {
		[TEAM.PROPS] = {},
		[TEAM.HUNTERS] = {}
	}

	for k, v in pairs( player.GetAll( ) ) do
		GAMEMODE.ps2TeamPlayers[v:Team()] = GAMEMODE.ps2TeamPlayers[v:Team()] or {}
		table.insert( GAMEMODE.ps2TeamPlayers[v:Team()],  v )
	end

	if #player.GetAll( ) > S('RoundWin.MinimumPlayers') then
		GAMEMODE.Jackpot = #player.GetAll( ) * S('RoundWin.TimeJackpotPerPlayer')
		for k, v in pairs( player.GetAll( ) ) do
			if v:Team() == TEAM.HUNTERS then
				v:PS2_DisplayInformation( "Round started. Points pot is at " .. GAMEMODE.Jackpot .. " points. It decreases by " .. math.floor( GAMEMODE.Jackpot / ( GAMEMODE:GetConfig('round_time') / 60 ) ) .. " points every minute, kill the Props quickly for maximum reward!" )
			end
		end
		GAMEMODE.PS2_NoPoints = false
	else
		GAMEMODE.PS2_NoPoints = true
		Pointshop2.BroadcastInfo( "No points will be given this round. Minimum of " .. S('RoundWin.MinimumPlayers') .. " players required" )
	end
end
hook.Add( "OnPreRoundStart", "PS2:OnPreRoundStart", Pointshop2.PropHunt.PreRoundStart )


function Pointshop2.PropHunt.PreRoundStart( num )
	if team.NumPlayers( TEAM.PROPS ) == 0 or team.NumPlayers( TEAM.HUNTERS ) == 0 then return end
	GAMEMODE.ps2TeamPlayers = GAMEMODE.ps2TeamPlayers or {
		[TEAM.PROPS] = {},
		[TEAM.HUNTERS] = {}
	}

	for k, v in pairs( player.GetAll( ) ) do
		GAMEMODE.ps2TeamPlayers[v:Team()] = GAMEMODE.ps2TeamPlayers[v:Team()] or {}
		table.insert( GAMEMODE.ps2TeamPlayers[v:Team()],  v )
	end

	if #player.GetAll( ) > S('RoundWin.MinimumPlayers') then
		GAMEMODE.Jackpot = #player.GetAll( ) * S('RoundWin.TimeJackpotPerPlayer')
		for k, v in pairs(team.GetPlayers(TEAM.HUNTERS)) do
			v:PS2_DisplayInformation( "Round started. Points pot is at " .. GAMEMODE.Jackpot .. " points. It decreases by " .. math.floor( GAMEMODE.Jackpot / ( GAMEMODE:GetConfig('round_time') / 60 ) ) .. " points every minute, kill the Props quickly for maximum reward!" )
		end
		GAMEMODE.PS2_NoPoints = false
	else
		GAMEMODE.PS2_NoPoints = true
		Pointshop2.BroadcastInfo( "No points will be given this round. Minimum of " .. S('RoundWin.MinimumPlayers') .. " players required" )
	end
end
hook.Add( "OnPreRoundStart", "PS2:OnPreRoundStart", Pointshop2.PropHunt.PreRoundStart )

function Pointshop2.PropHunt.OnRoundEnd( teamID, num )
	if GAMEMODE.PS2_NoPoints then
		return
	end

	if teamID == ROUND.DRAW then
		return
	end

	GAMEMODE.ps2TeamPlayers = GAMEMODE.ps2TeamPlayers or {
		[TEAM.PROPS] = {},
		[TEAM.HUNTERS] = {}
	}

	Pointshop2.StandardPointsBatch:begin( )
	if (teamID == TEAM.PROPS or teamID == ROUND.TIMER) then
		for k, v in pairs( GAMEMODE.ps2TeamPlayers[TEAM.PROPS] ) do
			if not IsValid( v ) then
				return
			end
			if v:Alive() and v:Team( ) == TEAM.PROPS then
				v:PS2_AddStandardPoints( S('RoundWin.AliveBonus'), 'Alive Bonus', true )
			end
			v:PS2_AddStandardPoints( S('RoundWin.PropsWin'), 'Winning the round' )
		end
	end

	if (teamID == TEAM.HUNTERS) then
		local aliveHuntersCount = 0
		for k, v in pairs( GAMEMODE.ps2TeamPlayers[TEAM.HUNTERS] ) do
			if IsValid( v ) and v:Alive() and v:Team() == TEAM.HUNTERS then
				aliveHuntersCount = aliveHuntersCount + 1
			end
		end
		for k, v in pairs( GAMEMODE.ps2TeamPlayers[TEAM.HUNTERS] ) do
			if not IsValid( v ) then
				return
			end
			if v:Alive() and v:Team( ) == TEAM.HUNTERS then
				v:PS2_AddStandardPoints( S('RoundWin.AliveBonus'), 'Alive Bonus', true )
			end
			local timeElapsed = GAMEMODE:RoundEndTime() - CurTime()
			timeElapsed = timeElapsed > 0 and timeElapsed or GAMEMODE:GetConfig('round_time')
			local pot = GAMEMODE.Jackpot * ( 1 - timeElapsed / GAMEMODE:GetConfig('round_time') )
			v:PS2_AddStandardPoints( math.floor( pot / aliveHuntersCount ), 'Winning the round', true )
		end
	end
	Pointshop2.StandardPointsBatch:finish( )

	hook.Call( "Pointshop2GmIntegration_RoundEnded" )
end
hook.Add( "OnRoundEnd", "PS2:OnRoundEnd", Pointshop2.PropHunt.OnRoundEnd )

function Pointshop2.PropHunt.OnRoundLastMan( ply )
	if GAMEMODE.PS2_NoPoints then
		return
	end

	if (ply:Team() == TEAM.PROPS) then
		ply:PS2_AddStandardPoints( S("LastMan.PropLastMan"), "Becoming Last Prop Standing" )
	elseif (ply:Team() == TEAM.HUNTERS) then
		ply:PS2_AddStandardPoints( S("LastMan.HunterLastMan"), "Becoming Last Hunter Standing" )
	end
end
hook.Add( "OnRoundLastMan", "PS2:OnRoundLastMan", Pointshop2.PropHunt.OnRoundLastMan )

function Pointshop2.PropHunt.OnPropKilled( victim, inflictor, attacker )
	if (GAMEMODE.PS2_NoPoints or not GAMEMODE:InRound()) then
		return
	end

	if IsValid(attacker) and IsValid(victim) and victim:IsPlayer() and attacker:IsPlayer() and victim ~= attacker then
		if (victim:Team() == TEAM.HUNTERS and attacker:Team() == TEAM.PROPS) then
			attacker:PS2_AddStandardPoints( S("Kills.PropKillsHunter"), "Killed Hunter" )
		elseif (victim:Team() == TEAM.PROPS and attacker:Team() == TEAM.HUNTERS) then
			attacker:PS2_AddStandardPoints( S("Kills.HunterKillsProp"), "Killed Prop" )
		end
	end
end
hook.Add( "PlayerDeath", "PS2:PropKilled", Pointshop2.PropHunt.OnPropKilled )
