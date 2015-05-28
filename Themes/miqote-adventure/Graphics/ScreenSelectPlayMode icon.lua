local gc = Var("GameCommand")
local iconColor = GameColor.Mode[gc:GetName()]

local t = Def.ActorFrame {}

t[#t+1] = Def.Quad {
	InitCommand=cmd(zoomto,128,48),
	OnCommand=cmd(diffuse,iconColor)
}

t[#t+1] = LoadFont("Common Normal") .. {
    Text=gc:GetName(),
    InitCommand=cmd(shadowlength,1),
    OnCommand=cmd(strokecolor,Color.Outline)
}

t.GainFocusCommand=cmd(diffusealpha,1.0)
t.LoseFocusCommand=cmd(diffusealpha,0.5)

return t