local t = Def.ActorFrame {}

local header_height = 80
local header_bottom_height = 16
local header_seperator_height = 3
local header_seperator_margin_x = 64

-- Background
t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(x,SCREEN_CENTER_X),
	-- MASK
	Def.Quad {
		InitCommand=cmd(vertalign,top;zoomto,SCREEN_WIDTH+8,header_height-header_bottom_height),
		OnCommand=cmd(MaskSource)
	},
	-- Black top
	Def.Quad {
		InitCommand=cmd(vertalign,top;zoomto,SCREEN_WIDTH+8,(header_height-header_bottom_height)),
		OnCommand=cmd(diffuse,Color.Black;diffusealpha,0.925)
	},
	-- Big Grid
	LoadActor(THEME:GetPathG("_texture","grid")) .. {
		InitCommand=cmd(vertalign,top;zoomto,SCREEN_WIDTH+8,(header_height-header_bottom_height)),
		OnCommand=cmd(visible,false;skewx,-8/SCREEN_WIDTH	;diffuse,ThemeColor.Primary;diffusealpha,0.5;texcoordvelocity,-0.125,0;customtexturerect,0,0,(SCREEN_WIDTH+8)/32,(header_height-header_bottom_height)/32)
	},
	-- Fade To Top
	Def.Quad {
		InitCommand=cmd(vertalign,top;zoomto,SCREEN_WIDTH+8,(header_height-header_bottom_height)),
		OnCommand=cmd(diffuse,ThemeColor.Primary;fadetop,1)
	},
	-- Fade To Bottom
	Def.Quad {
		InitCommand=cmd(vertalign,top;y,(header_height-header_bottom_height);zoomto,SCREEN_WIDTH+8,header_bottom_height),
		OnCommand=cmd(diffuse,ThemeColor.Primary;fadebottom,1)
	},
	-- Seperator
	Def.Quad {
		InitCommand=cmd(vertalign,top;y,(header_height-header_bottom_height);zoomto,SCREEN_WIDTH - header_seperator_margin_x,header_seperator_height),
		OnCommand=cmd(diffuse,ThemeColor.Primary;glowramp;effectclock,'beat';effectperiod,2;effectcolor1,color("#ffffff77");effectcolor2,color("#ffffffFF"))
	},
}

-- Content
t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(y,SCREEN_TOP+36),
	-- Underline
	Def.Quad {
		InitCommand=cmd(x,SCREEN_LEFT+32;y,8;horizalign,left),
		OnCommand=cmd(zoomto,640,2;shadowlength,1)
	},
	-- Header
	LoadFont("Common Header") .. {
		Text=THEME:GetString(Var "LoadingScreen", "HeaderText"),
		InitCommand=cmd(x,SCREEN_LEFT+32;y,-8;horizalign,left),
		OnCommand=cmd(shadowlength,1;skewx,-0.25)
	},
	-- Subtitle
	LoadFont("Common Normal") .. {
		Text="// MUSIC LIVE FROM THE FIRST INTERNATIONAL GROOVE STATION.",
		InitCommand=cmd(x,SCREEN_LEFT+32;y,18;horizalign,left),
		OnCommand=cmd(shadowlength,1;zoom,0.5;diffuse,ThemeColor.TextDark)
	}
}


return t