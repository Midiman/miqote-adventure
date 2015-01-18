local t = Def.ActorFrame {}

local footer_start = -32
local footer_height = 40
local footer_flare_height = 16
local footer_seperator_height = 3
local footer_seperator_margin_x = 64

t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(x,SCREEN_CENTER_X),
	-- MASK
	Def.Quad {
		InitCommand=cmd(vertalign,bottom,y,footer_start;zoomto,SCREEN_WIDTH+8,footer_height),
		OnCommand=cmd(MaskSource)
	},
	-- Color Bar
	Def.Quad {
		InitCommand=cmd(vertalign,bottom;y,footer_start;zoomto,SCREEN_WIDTH+8,footer_height),
		OnCommand=cmd(diffuse,ThemeColor.Primary)
	},
	-- Fade To Bottom
	Def.Quad {
		InitCommand=cmd(vertalign,bottom;y,footer_start-footer_height;zoomto,SCREEN_WIDTH+8,footer_flare_height),
		OnCommand=cmd(diffuse,ThemeColor.Primary;fadetop,1)
	},
	-- Seperator
	Def.Quad {
		InitCommand=cmd(vertalign,bottom;y,footer_start-footer_height;zoomto,SCREEN_WIDTH - footer_seperator_margin_x,footer_seperator_height),
		OnCommand=cmd(diffuse,ThemeColor.Primary;glowramp;effectclock,'beat';effectperiod,2;effectcolor1,color("#ffffff77");effectcolor2,color("#ffffffFF"))
	},
}

-- System
t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(x,SCREEN_CENTER_X),
	Def.Quad {
		InitCommand=cmd(vertalign,bottom;zoomto,SCREEN_WIDTH+8,32),
		OnCommand=cmd(diffuse,Color.Black)
	}
}


return t