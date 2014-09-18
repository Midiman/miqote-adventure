local t = Def.ActorFrame {}

t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(z,-128),
	OnCommand=cmd(diffuse,ThemeColor.Background),
	-- Underline
	LoadActor(THEME:GetPathG("","_white")) .. {
		InitCommand=cmd(zoomto,256,4)
	},
	LoadFont("Common Normal") .. {
		Text=":: SECTION 000 ::",
		InitCommand=cmd(y,-16)
	}
}
t[#t+1] = LoadActor("_ring thin") .. {
	InitCommand=cmd(z,-256),
	OnCommand=cmd(diffuse,ThemeColor.Background;diffusealpha,0.25;bob;effectmagnitude,0,0,-96;effectperiod,8)
}
t[#t+1] = LoadActor("_ring thin") .. {
	InitCommand=cmd(z,-128),
	OnCommand=cmd(diffuse,ThemeColor.Background;bob;effectmagnitude,0,0,-64;effectperiod,8)
}
t[#t+1] = LoadActor("_ring thin") .. {
	OnCommand=cmd(diffuse,ThemeColor.Background;glowshift;effectperiod,16)
}
t[#t+1] = LoadActor("_ring thin") .. {
	InitCommand=cmd(z,128),
	OnCommand=cmd(diffuse,ThemeColor.Background;bob;effectmagnitude,0,0,64;effectperiod,8)
}
t[#t+1] = LoadActor("_ring thin") .. {
	InitCommand=cmd(z,256),
	OnCommand=cmd(diffuse,ThemeColor.Background;diffusealpha,0.25;bob;effectmagnitude,0,0,96;effectperiod,8)
}

return t