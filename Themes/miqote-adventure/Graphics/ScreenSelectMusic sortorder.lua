return LoadFont("Common Normal") .. {
	Text="",
	BeginCommand=cmd(playcommand,"Set"),
	SortOrderChangedMessageCommand=cmd(playcommand,"Set"),
	SetCommand=function(self)
		local s = GAMESTATE:GetSortOrder()
		if s ~= nil then
			local s = SortOrderToLocalizedString( s )
			self:settext( s )
			self:playcommand("Tween")
		else
			return
		end
	end
}