local t = Def.ActorFrame {}

local arrows = LoadActor(THEME:GetPathB("_menu","arrows")) 

t[#t+1] = arrows .. {
	InitCommand=cmd(y,MENU_CENTER_Y-36)
}

return t
