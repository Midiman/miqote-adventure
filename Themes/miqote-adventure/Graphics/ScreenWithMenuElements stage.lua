local t = Def.ActorFrame {}

t[#t+1] = Def.ActorFrame {
	SetCommand=function(self)
		local c = self:GetChildren()
		local stage = GAMESTATE:GetCurrentStage()

		c.Stage:settextf("%s",StageToLocalizedString(stage))
	end,
	OnCommand=cmd(playcommand,"Set"),
	CurrentSongChangedMessageCommand=cmd(playcommand,"Set"),
	LoadFont("Common Normal") .. {
		Name="Stage",
		OnCommand=cmd(diffuse,ThemeColor.Text;shadowlength,1)
	}
}

return t