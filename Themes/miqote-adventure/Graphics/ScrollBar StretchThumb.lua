local t = Def.ActorFrame {}

t[#t+1] = Def.ActorFrame {
	Def.Quad {
		InitCommand=cmd(zoomto,32,1),
		OnCommand=cmd(diffuse,ThemeColor.Primary)
	}
}

return t