return Def.SongMeterDisplay {
	StreamWidth=THEME:GetMetric( "SongMeterDisplay", 'StreamWidth' ),
	Stream=Def.Quad {
		InitCommand=cmd(),
		OnCommand=cmd(zoomy,32;diffuse,ThemeColor.BackgroundDark)
	},
	Tip=Def.Quad {
		InitCommand=cmd(zoom,32,32)
	}
}