local t = Def.ActorFrame {}


t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(x,SCREEN_CENTER_X),
	Def.Quad {
		InitCommand=cmd(vertalign,bottom;zoomto,SCREEN_WIDTH,72),
		OnCommand=cmd(diffuse,ThemeColor.Primary)
	}
}

-- System
t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(x,SCREEN_CENTER_X),
	Def.Quad {
		InitCommand=cmd(vertalign,bottom;zoomto,SCREEN_WIDTH,32),
		OnCommand=cmd(diffuse,Color.Black)
	}
}


return t