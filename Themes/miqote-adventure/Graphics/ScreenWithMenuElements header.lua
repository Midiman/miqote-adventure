local t = Def.ActorFrame {}

local header_height = MENU_HEADER_HEIGHT

-- Background
t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(x,SCREEN_CENTER_X),
	-- MASK
	Def.Quad {
		InitCommand=cmd(vertalign,top;zoomto,SCREEN_WIDTH+8,header_height),
		OnCommand=cmd(MaskSource)
	},
	-- Big Grid
	LoadActor(THEME:GetPathG("_texture","grid")) .. {
		InitCommand=cmd(vertalign,top;zoomto,SCREEN_WIDTH+8,(header_height)),
		OnCommand=cmd(visible,false;skewx,-8/SCREEN_WIDTH;diffuse,ThemeColor.Primary;diffusealpha,0.5;texcoordvelocity,-0.125,0;customtexturerect,0,0,(SCREEN_WIDTH+8)/32,(header_height)/32)
	},
	-- Color Fill
	Def.Quad {
		InitCommand=cmd(vertalign,top;zoomto,SCREEN_WIDTH+8,(header_height)),
		OnCommand=cmd(diffuse,ThemeColor.Primary)
	}
}

-- Content
t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(y,MENU_HEADER_HEIGHT/2),
	-- Header
	LoadFont("Common Header") .. {
		Text=THEME:GetString(Var "LoadingScreen", "HeaderText"),
		InitCommand=cmd(x,SCREEN_LEFT+32;horizalign,left),
		OnCommand=cmd(diffuse,ThemeColor.Text;shadowlength,1)
	},
	-- Subtitle
	LoadFont("Common Normal") .. {
		Text="// MUSIC LIVE FROM THE FIRST INTERNATIONAL GROOVE STATION.",
		InitCommand=cmd(x,SCREEN_LEFT+32;y,18;horizalign,left),
		OnCommand=cmd(visible,false;shadowlength,1;zoom,0.5;diffuse,ThemeColor.TextDark)
	}
}


return t