local t = Def.ActorFrame {}

t[#t+1] = Def.ActorFrame {
	SetCommand=function(self)
		local c = self:GetChildren()

		local style = GAMESTATE:GetCurrentStyle() or nil
		if style == nil then return end

		local steps_type = style:GetStepsType()
		if steps_type == nil then return end

		c.StyleType:settextf( ToEnumShortString( steps_type ) )
	end,
	ScreenChangedMessageCommand=cmd(playcommand,"Set"),
	OnCommand=cmd(playcommand,"Set"),
	--
	LoadFont("Common Normal") .. {
		Name="StyleType",
		OnCommand=cmd(zoom,0.5;shadowlength,1),
	}
}

return t