local t = Def.ActorFrame {}

t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y),
	--
	Def.Quad {
		InitCommand=cmd(zoomto,SCREEN_WIDTH,SCREEN_HEIGHT;visible,false),
		OnCommand=cmd(visible,true;diffuse,Color.Red;diffusealpha,0;linear,TIME_INSTANT;diffuse,Color.Black)
	}
}

return t