local transition_time = THEME:GetMetric(Var "LoadingScreen","ShowOptionsMessageSeconds")

local t = Def.ActorFrame {}
--
t[#t+1] = Def.ActorFrame {
	Def.Quad {
		InitCommand=cmd(x,MENU_CENTER_X;y,MENU_CENTER_Y;zoomto,SCREEN_WIDTH,MENU_HEIGHT),
		OnCommand=cmd(diffuse,Color.Black;visible,false),
		--
		ShowPressStartForOptionsCommand=cmd(visible,true;diffusealpha,0.5),
		ShowEnteringOptionsCommand=cmd(visible,true;diffuse,Color.Green;diffusealpha,0.5),
		HidePressStartForOptionsCommand=cmd(visible,true;diffuse,Color.Red;diffusealpha,0.5),
	}
}

--
return t