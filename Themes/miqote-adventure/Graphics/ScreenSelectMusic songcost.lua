local pn = ...

local length_format = "%i Stages"

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

		cost = song:GetStageCost()

		c.LengthText:settextf(length_format, cost)


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
		OnCommand=cmd(zoom,0.75),
		NoneCommand=cmd(finishtweening;visible,false),
		NormalCommand=cmd(finishtweening;visible,false),
		LongCommand=cmd(finishtweening;visible,true),
		MarathonCommand=cmd(finishtweening;visible,true),
	}
}

return t