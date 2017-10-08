local plugin = plugin;
 --Init
plugin:IncludeFile("plugin.lua", SERVERGUARD.STATE.SHARED);

 --Commands
local f, d = file.Find( "plugins/lps/commands/*.lua", "LUA" )
for _, file in pairs( f ) do
	plugin:IncludeFile("commands/" .. file, SERVERGUARD.STATE.SHARED);
end


