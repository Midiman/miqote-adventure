local gc = Var("GameCommand")

local t = Def.ActorFrame {}

--
t[#t+1] = LoadFont("Common Normal") .. {
    Text=gc:GetName(),
    InitCommand=cmd(shadowlength,1),
    GainFocusCommand=cmd(diffuse,ThemeColor.Secondary),
    LoseFocusCommand=cmd(diffuse,ThemeColor.Text),
    DisabledCommand=cmd(diffuse,Color.Red)
}

return t;