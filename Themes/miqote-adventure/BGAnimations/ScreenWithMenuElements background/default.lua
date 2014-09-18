local t = Def.ActorFrame { FOV = 90 }

-- Fill
t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(Center),
	Def.Quad {
		InitCommand=cmd(scaletoclipped,SCREEN_WIDTH,SCREEN_HEIGHT),
		OnCommand=cmd(diffuse,ThemeColor.BackgroundDark)
	}
}

-- Rings
t[#t+1] = LoadActor("rings") .. {
	InitCommand=cmd(Center;z,-32),
	OnCommand=cmd(rotationy,22.5;bob;effectmagnitude,0,0,32;effectperiod,8),
}

-- Scanline
t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(Center;addy,0.5),
	LoadActor("_texture scanline") .. {
		InitCommand=cmd(SetTextureFiltering,false;zoomto,SCREEN_WIDTH,SCREEN_HEIGHT;customtexturerect,0,0,SCREEN_WIDTH/256,SCREEN_HEIGHT/1024),
		OnCommand=cmd(diffuse,ThemeColor.Background;diffusealpha,0.25),
	}
}
--

return t