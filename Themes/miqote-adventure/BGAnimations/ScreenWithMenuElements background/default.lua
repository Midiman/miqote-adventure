local t = Def.ActorFrame { FOV = 90 }

-- Fill
t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(Center),

	LoadActor("_cloud") .. {
		InitCommand=cmd(scaletoclipped,SCREEN_WIDTH,SCREEN_HEIGHT),
		OnCommand=cmd(diffuse,ThemeColor.BackgroundDark)
	}
}

-- Rings
t[#t+1] = LoadActor("rings") .. {
	InitCommand=cmd(Center;z,-32),
	OnCommand=cmd(rotationy,22.5;bob;effectmagnitude,0,0,32;effectperiod,8),
}

-- Grids
t[#t+1] = Def.ActorFrame {
	FOV=90,
	InitCommand=cmd(x,SCREEN_CENTER_X),
	--
	LoadActor(THEME:GetPathG("_texture","grid")) .. {
		InitCommand=cmd(y,MENU_TOP;rotationx,90*0.875;vertalign,top;scaletoclipped,(2048),128),
		OnCommand=cmd(diffuse,ThemeColor.PrimaryDark;customtexturerect,0,0,2048/32,128/32;texcoordvelocity,-1,0;fadebottom,1)
	},
	LoadActor(THEME:GetPathG("_texture","grid")) .. {
		InitCommand=cmd(y,MENU_BOTTOM;rotationx,-90*0.875;vertalign,bottom;scaletoclipped,(2048),128),
		OnCommand=cmd(diffuse,ThemeColor.PrimaryDark;customtexturerect,0,0,2048/32,128/32;texcoordvelocity,-1,0;fadetop,1)
	}
}

-- Scanline
t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(Center),
	LoadActor("_texture scanline") .. {
		InitCommand=cmd(SetTextureFiltering,true;zoomto,SCREEN_WIDTH,SCREEN_HEIGHT;customtexturerect,0,0,SCREEN_WIDTH/256,SCREEN_HEIGHT/256),
		OnCommand=cmd(diffuse,Color.Black;diffusealpha,0.25),
	}
}
--

return t