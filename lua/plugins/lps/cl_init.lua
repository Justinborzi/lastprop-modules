 --Init
plugin:IncludeFile("plugin.lua", SERVERGUARD.STATE.CLIENT);

 --Commands
local f, d = file.Find( "plugins/lps/commands/*.lua", "LUA" )
for _, file in pairs( f ) do
	plugin:IncludeFile("commands/" .. file, SERVERGUARD.STATE.CLIENT);
end
