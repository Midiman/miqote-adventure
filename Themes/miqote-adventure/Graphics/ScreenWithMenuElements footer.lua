local t = Def.ActorFrame {}


t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(x,SCREEN_CENTER_X),
	Def.Quad {
		InitCommand=cmd(vertalign,bottom;zoomto,SCREEN_WIDTH+8,72),
		OnCommand=cmd(diffuse,ThemeColor.Primary)
	}
}

-- System
t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(x,SCREEN_CENTER_X),
	Def.Quad {
		InitCommand=cmd(vertalign,bottom;zoomto,SCREEN_WIDTH+8,32),
		OnCommand=cmd(diffuse,Color.Black)
	}
}


return t