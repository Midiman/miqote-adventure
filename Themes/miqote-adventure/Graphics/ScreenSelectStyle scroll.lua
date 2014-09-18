local gc = Var("GameCommand")
local iconColor = ThemeColor.Background

local t = Def.ActorFrame {}

t[#t+1] = Def.Quad {
	InitCommand=cmd(zoomto,640,192),
	OnCommand=cmd(diffuse,iconColor)
}

t[#t+1] = LoadFont("Common Normal") .. {
    Text=gc:GetName(),
    InitCommand=cmd(shadowlength,1),
    OnCommand=cmd(strokecolor,Color.Outline)
}

t.GainFocusCommand=cmd(visible,true)
t.LoseFocusCommand=cmd(visible,false)

return t