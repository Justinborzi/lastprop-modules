local MODULE = {}

--Pointshop2 PH/lastprop integration
MODULE.Name = "Last Prop Integration"
MODULE.Author = "Nerdism"
MODULE.RestrictGamemodes = { "lastprop", "prop_hunt", "prophunt" } --Only load for lastprop/prop_hunt

MODULE.Blueprints = {}

MODULE.SettingButtons = {
	{
		label = "Point Rewards",
		icon = "pointshop2/hand129.png",
		control = "DLastPropConfigurator"
	}
}

MODULE.Settings = {}

--These are sent to the client on join
MODULE.Settings.Shared = { }

--These are not sent
MODULE.Settings.Server = {
	Kills = {
		info = {
			label = "Kill Rewards"
		},

		HunterKillsProp = {
			value = 100,
			label = "Hunter kills Prop",
			tooltip = "Points a hunter gets when killing a prop",
		},

		PropKillsHunter = {
			value = 150,
			label = "Prop kills Hunter",
			tooltip = "Points a prop gets when killing a hunter",
		},
	},
	RoundWin = {
		info = {
			label = "Round Win Rewards"
		},

		MinimumPlayers = {
			value = 3,
			label = "Minimum Players",
			tooltip = "Minimum amount of players online for round awards to be given"
		},

		PropsWin = {
			value = 100,
			label = "Props Win: Points given",
			tooltip = "Points given to each prop when props win."
		},

		TimeJackpotPerPlayer = {
			value = 130,
			label = "Hunters Win: Time Jackpot per Player",
			tooltip = "This amount is multiplied with the amount of players to get the time jackpot. The time jackpot decreases with each minute that passed. When hunters win the time jackpot is distributed to the hunters."
		},

		AliveBonus = {
			value = 100,
			label = "Alive Bonus",
			tooltip = "Points given to props/hunters that are still alive at the end of a round."
		},
	},

	LastMan = {
		info = {
			label = "Last Man Rewards"
		},

		PropLastMan = {
			value = 100,
			label = "Prop Last Man Bonus",
			tooltip = "Points given to a Prop that becomes the last man standing."
		},

		HunterLastMan = {
			value = 100,
			label = "Hunter Last Man Bonus",
			tooltip = "Points given to a Hunter that becomes the last man standing."
		},
	}

}

-- For Drops integration: Returns players that can get a drop once the round ends
function MODULE.GetPlayersForDrops( )
	local players = {}
	for k, v in pairs( player.GetAll( ) ) do
		if v:Team() ~= TEAM.SPECTATORS then
			table.insert( players, v )
		end
	end
	return players
end

Pointshop2.RegisterModule( MODULE )
Pointshop2.NotifyGamemodeModuleLoaded( "lastprop", MODULE )
Pointshop2.NotifyGamemodeModuleLoaded( "prop_hunt", MODULE )
Pointshop2.NotifyGamemodeModuleLoaded( "prophunt", MODULE )
