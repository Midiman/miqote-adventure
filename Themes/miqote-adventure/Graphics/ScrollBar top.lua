return Def.ActorFrame {
	Def.Quad {
		InitCommand=cmd(zoomto,32,32),
		OnCommand=cmd(diffuse,ThemeColor.BackgroundDark)
	},
	LoadActor(THEME:GetPathG("_common","arrow")) .. {
		InitCommand=cmd(zoom,0.5)
	}
}