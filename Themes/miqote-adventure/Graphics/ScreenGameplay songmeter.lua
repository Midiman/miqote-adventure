local meter_width = (THEME:GetMetric(Var "LoadingScreen","PlayerP2OnePlayerOneSideX") - THEME:GetMetric(Var "LoadingScreen","PlayerP1OnePlayerOneSideX")) * 2 - 44
local meter_height = THEME:GetMetric( "SongMeterDisplay", 'StreamHeight' )
local meter_outline = 4

return Def.ActorFrame {
	-- Outline
	Def.Quad {
		InitCommand=cmd(zoomto,meter_width+meter_outline, meter_height+meter_outline),
	},
	-- Background
	Def.Quad {
		InitCommand=cmd(zoomto,meter_width, meter_height),
		OnCommand=cmd(diffuse,ThemeColor.BackgroundDark)
	},
	-- Fill
	Def.SongMeterDisplay {
		StreamWidth=meter_width,
		Stream=Def.Quad {
			InitCommand=cmd(),
			OnCommand=cmd(zoomy,meter_height;diffuse,ThemeColor.SecondaryDark)
		},
		Tip=Def.Quad {
			InitCommand=cmd(zoomto,8,meter_height;horizalign,right),
			OnCommand=cmd(fadeleft,1;diffuseramp;effectclock,'beat';effectcolor2,ThemeColor.Secondary;effectcolor1,ThemeColor.SecondaryDark)
		}
	}
}