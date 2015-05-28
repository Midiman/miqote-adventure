local page_width = (MENU_RIGHT-128) - (MENU_LEFT+256)
local crop_width = (MENU_LEFT+384) - (MENU_LEFT+256 + 88)
return Def.ActorFrame {
	Def.Quad {
		InitCommand=cmd(y,32/2;zoomto,page_width,1),
		OnCommand=cmd(diffuse,ColorDarkTone(ThemeColor.Background))
	},
	Def.Quad {
		InitCommand=cmd(y,32/2;zoomto,page_width,1;cropright,(page_width-(128+32))/page_width),
		OnCommand=cmd(diffuse,ThemeColor.Primary;diffusealpha,0.5),
		GainFocusCommand=cmd(finishtweening;smooth,TIME_NORMAL;diffusealpha,1;cropright,0),
		LoseFocusCommand=cmd(finishtweening;smooth,TIME_NORMAL;diffusealpha,0.5;cropright,(page_width-(128+32))/page_width;faderight,0)
	}
}