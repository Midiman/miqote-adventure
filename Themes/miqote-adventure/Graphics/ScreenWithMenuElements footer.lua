local t = Def.ActorFrame {}

local system_height = 32
local footer_height = MENU_FOOTER_HEIGHT

t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(x,SCREEN_CENTER_X),
	-- MASK
	Def.Quad {
		InitCommand=cmd(vertalign,bottom;zoomto,SCREEN_WIDTH+8,footer_height),
		OnCommand=cmd(MaskSource)
	},
	--Fill
	Def.Quad {
		InitCommand=cmd(vertalign,bottom;zoomto,SCREEN_WIDTH+8,footer_height),
		OnCommand=cmd(diffuse,ThemeColor.Primary)
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