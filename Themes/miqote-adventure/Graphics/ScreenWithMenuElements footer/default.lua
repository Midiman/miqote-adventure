local t = Def.ActorFrame {}

local system_height = 32
local footer_height = MENU_FOOTER_HEIGHT

local wisp_width = 320

t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(x,SCREEN_CENTER_X),
	-- MASK
	Def.Quad {
		InitCommand=cmd(vertalign,bottom;zoomto,SCREEN_WIDTH+8,footer_height),
		OnCommand=cmd(MaskSource)
	},
	-- Color Multiply
	Def.Quad {
		InitCommand=cmd(vertalign,bottom;zoomto,SCREEN_WIDTH+8,footer_height),
		OnCommand=cmd(diffuse,ThemeColor.PrimaryDark;blend,Blend.Multiply)
	},
	-- Color Fill
	Def.Quad {
		InitCommand=cmd(vertalign,bottom;zoomto,SCREEN_WIDTH+8,footer_height),
		OnCommand=cmd(diffuse,ThemeColor.Primary;diffusealpha,0.5)
	},
	-- Color Wisp Frame
	Def.ActorFrame {
		OnCommand=cmd(queuecommand,"Appeal"),
		OffCommand=cmd(finishtweening),
		AppealCommand=cmd(stoptweening;x,-MENU_CENTER_X-(wisp_width/2);linear,4;x,MENU_CENTER_X+(wisp_width/2);sleep,4;queuecommand,"Appeal"),
		-- Fill
		Def.Quad {
			InitCommand=cmd(vertalign,bottom;zoomto,320,(footer_height)),
			OnCommand=cmd(diffuse,ThemeColor.Primary;fadeleft,1;faderight,0.125),
		},
		-- Additive
		Def.Quad {
			InitCommand=cmd(vertalign,bottom;zoomto,320,(footer_height)),
			OnCommand=cmd(diffuse,ThemeColor.Primary;diffusealpha,0.5;fadeleft,1;faderight,0.125;blend,Blend.Add)
		},
	}
}

t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(x,SCREEN_CENTER_X;y,-footer_height+8),
	OnCommand=cmd(),
	--
	LoadActor("_seperator fill") .. {
		OnCommand=cmd(diffuse,ThemeColor.Decoration)
	},
	LoadActor("_seperator frame") .. {
	}
}

-- System
t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(x,SCREEN_CENTER_X),
	Def.Quad {
		InitCommand=cmd(vertalign,bottom;zoomto,SCREEN_WIDTH+8,system_height),
		OnCommand=cmd(diffuse,Color.Black)
	}
}


return t