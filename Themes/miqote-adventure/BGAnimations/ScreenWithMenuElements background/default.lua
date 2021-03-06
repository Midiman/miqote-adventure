local t = Def.ActorFrame { FOV = 90 }

-- Fill
t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(Center),

	LoadActor(THEME:GetPathB("","_cloud")) .. {
		InitCommand=cmd(scaletoclipped,SCREEN_WIDTH,SCREEN_HEIGHT),
		OnCommand=cmd(diffuse,ThemeColor.BackgroundDark)
	}
}

-- Rings
t[#t+1] = LoadActor("rings") .. {
	InitCommand=cmd(Center;z,-32;visible,false),
	OnCommand=cmd(rotationy,22.5;bob;effectmagnitude,0,0,32;effectperiod,8),
}

-- Scanline
t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(Center),
	LoadActor(THEME:GetPathG("_texture","scanline")) .. {
		InitCommand=cmd(SetTextureFiltering,true;zoomto,SCREEN_WIDTH,SCREEN_HEIGHT;customtexturerect,0,0,SCREEN_WIDTH/256,SCREEN_HEIGHT/256),
		OnCommand=cmd(diffuse,Color.Black;diffusealpha,0.25),
	}
}
--

return t
