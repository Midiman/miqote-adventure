local t = Def.ActorFrame {}

local header_height = MENU_HEADER_HEIGHT

local wisp_width = 320

-- Background
local header_background = Def.ActorFrame {
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
	-- Color Multiply
	Def.Quad {
		InitCommand=cmd(vertalign,top;zoomto,SCREEN_WIDTH+8,(header_height)),
		OnCommand=cmd(diffuse,ThemeColor.PrimaryDark;blend,Blend.Multiply)
	},
	-- Color Fill
	Def.Quad {
		InitCommand=cmd(vertalign,top;zoomto,SCREEN_WIDTH+8,(header_height)),
		OnCommand=cmd(diffuse,ThemeColor.Primary;diffusealpha,0.5)
	},
	-- Color Wisp Frame
	Def.ActorFrame {
		OnCommand=cmd(queuecommand,"Appeal"),
		OffCommand=cmd(finishtweening),
		AppealCommand=cmd(stoptweening;x,-MENU_CENTER_X-(wisp_width/2);linear,4;x,MENU_CENTER_X+(wisp_width/2);sleep,4;queuecommand,"Appeal"),
		-- Fill
		Def.Quad {
			InitCommand=cmd(vertalign,top;zoomto,320,(header_height)),
			OnCommand=cmd(diffuse,ThemeColor.Primary;fadeleft,1;faderight,0.125)
			
		},
		-- Additive
		Def.Quad {
			InitCommand=cmd(vertalign,top;zoomto,320,(header_height)),
			OnCommand=cmd(diffuse,ThemeColor.Primary;diffusealpha,0.5;fadeleft,1;faderight,0.125;blend,Blend.Add)
		},
	}
}
-- Overhang
local header_overlay = Def.ActorFrame {
	InitCommand=cmd(x,SCREEN_CENTER_X;y,35),
	--
	LoadActor("_seperator fill") .. {
		OnCommand=cmd(diffuse,ThemeColor.DecorationDark)
	},
	LoadActor("_seperator frame") .. {
		OnCommand=cmd(diffuse,ThemeColor.Decoration)
	}
}
-- Content
local header_text = Def.ActorFrame {
	InitCommand=cmd(y,MENU_HEADER_HEIGHT/2),
	-- Header
	LoadFont("Common Header") .. {
		Text=string.upper(THEME:GetString(Var "LoadingScreen", "HeaderText")),
		InitCommand=cmd(x,SCREEN_LEFT+112;horizalign,left),
		OnCommand=cmd(diffuse,ThemeColor.Secondary;strokecolor,Color.Outline;diffusebottomedge,ThemeColor.SecondaryDark;shadowlength,1)
	},
	-- Subtitle
	LoadFont("Common Normal") .. {
		Text="// MUSIC LIVE FROM THE FIRST INTERNATIONAL GROOVE STATION.",
		InitCommand=cmd(x,SCREEN_LEFT+32;y,18;horizalign,left),
		OnCommand=cmd(visible,false;shadowlength,1;zoom,0.5;diffuse,ThemeColor.TextDark)
	}
}

local header_temp = Def.ActorFrame {
	InitCommand=cmd(x,SCREEN_CENTER_X;y,MENU_HEADER_HEIGHT/2),
	--
	Def.Quad {
		InitCommand=cmd(zoomto,SCREEN_WIDTH,MENU_HEADER_HEIGHT),
		OnCommand=cmd(diffuse,ThemeColor.PrimaryDark)
	}
}

t[#t+1] = header_temp
t[#t+1] = header_text

return t