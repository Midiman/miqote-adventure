local t = Def.ActorFrame {};


local arrows_x = THEME:GetMetric(Var "LoadingScreen", "MusicWheelX")
local arrows_Y = THEME:GetMetric(Var "LoadingScreen", "MusicWheelY")
local arrow_timing_modifier = 2

local arrows = Def.ActorFrame {
	InitCommand=cmd(x,arrows_x-256),
	-- Top arrow
	LoadActor(THEME:GetPathG("_common","arrow")) .. {
		InitCommand=cmd(y,MENU_TOP+64),
		OnCommand=cmd(diffuse,ThemeColor.Secondary;queuecommand,"Appeal"),
		MenuInputCommand=cmd(zoom,1658),
		AppealCommand=cmd(bounce;effectmagnitude,0,-16,0;effecttiming,0.875*arrow_timing_modifier,0,0.125*arrow_timing_modifier,0;effectclock,'beat';)
	},
	-- Bottom arrow
	LoadActor(THEME:GetPathG("_common","arrow")) .. {
		InitCommand=cmd(y,MENU_BOTTOM-64),
		OnCommand=cmd(zoomy,-1;diffuse,ThemeColor.Secondary;queuecommand,"Appeal"),
		AppealCommand=cmd(bounce;effectmagnitude,0,16,0;effecttiming,0.875*arrow_timing_modifier,0,0.125*arrow_timing_modifier,0;effectclock,'beat';)
	}
}

t[#t+1] = arrows

return t