local PANEL = {}

function PANEL:Init( )
	self:SetSkin( Pointshop2.Config.DermaSkin )
	self:SetTitle( "Last Prop Reward Settings" )
	self:SetSize( 300, 600 )

	self:AutoAddSettingsTable( Pointshop2.GetModule( "Last Prop Integration" ).Settings.Server, self )
end

function PANEL:DoSave( )
	Pointshop2View:getInstance( ):saveSettings( self.mod, "Server", self.settings )
end

derma.DefineControl( "DLastPropConfigurator", "", PANEL, "DSettingsEditor" )
