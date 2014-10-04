local t = Def.ActorFrame {}

-- Background
t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(x,SCREEN_CENTER_X),
	Def.Quad {
		InitCommand=cmd(vertalign,top;zoomto,SCREEN_WIDTH+8,80),
		OnCommand=cmd(diffuse,ThemeColor.Primary)
	},
	LoadActor(THEME:GetPathG("","_header")) .. {
		InitCommand=cmd(vertalign,top)
	}
}

-- Content
t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(y,SCREEN_TOP+36),
	-- Underline
	Def.Quad {
		InitCommand=cmd(x,SCREEN_LEFT+32;y,8;horizalign,left),
		OnCommand=cmd(zoomto,640,4;shadowlength,1)
	},
	-- Header
	LoadFont("Common Normal") .. {
		Text="SELECT MUSIC",
		InitCommand=cmd(x,SCREEN_LEFT+32;y,-8;horizalign,left),
		OnCommand=cmd(shadowlength,1)
	},
	-- Subtitle
	LoadFont("Common Normal") .. {
		Text="— MUSIC LIVE FROM THE FIRST INTERNATIONAL GROOVE STATION.",
		InitCommand=cmd(x,SCREEN_LEFT+32;y,20;horizalign,left),
		OnCommand=cmd(shadowlength,1;zoom,0.5;diffuse,ThemeColor.TextDark)
	}
}


return t