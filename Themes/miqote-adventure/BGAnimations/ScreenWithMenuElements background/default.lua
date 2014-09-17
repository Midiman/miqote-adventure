local t = Def.ActorFrame {};

-- Fill
t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(Center),
	Def.Quad {
		InitCommand=cmd(scaletoclipped,SCREEN_WIDTH,SCREEN_HEIGHT),
		OnCommand=cmd(diffuse,ThemeColor.BackgroundDark)
	}
}

-- Scanline
t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(Center;addy,0.5),
	LoadActor("_texture scanline") .. {
		InitCommand=cmd(SetTextureFiltering,false;scaletoclipped,16,16;customtexturerect,0,0,4/4,4/4),
		OnCommand=cmd(diffuse,ThemeColor.Background),
	}
}
--

return t