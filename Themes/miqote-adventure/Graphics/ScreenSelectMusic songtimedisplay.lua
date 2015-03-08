local pn = ...

local t = Def.ActorFrame {}

t[#t+1] = Def.ActorFrame {
	SetCommand=function(self)
		local c = self:GetChildren()

		local cost = 1
		local song = GAMESTATE:GetCurrentSong()

		if song == nil then
			self:playcommand("None");
			return
		end

		time = song:GetStepsSeconds()

		c.LengthText:settextf(SecondsToMSS(time))


		if song:IsLong() then
			self:playcommand("Long")
		elseif song:IsMarathon() then
			self:playcommand("Marathon")
		else
			self:playcommand("Normal")
		end
		
	end,
	CurrentSongChangedMessageCommand=cmd(playcommand,"Set"),
	CurrentCourseChangedMessageCommand=cmd(playcommand,"Set"),
	--
	LoadFont("Common Normal") .. {
		Name="LengthText",
		Text="!!",
		InitCommand=cmd(shadowlength,1),
	}
}

return t