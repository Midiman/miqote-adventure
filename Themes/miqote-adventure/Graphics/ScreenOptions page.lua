
return Def.ActorFrame {
	Def.Quad {
		InitCommand=cmd(zoomto,(MENU_RIGHT-128) - (MENU_LEFT+256),32*13),
		OnCommand=cmd(diffuse,ThemeColor.BackgroundDark)
	},
	Def.Quad {
		InitCommand=cmd(x,-SCREEN_CENTER_X+MENU_LEFT+256 +16;zoomto,128+32,32*13),
		OnCommand=cmd(diffuse,ColorMidTone(ThemeColor.BackgroundDark))
	}
}