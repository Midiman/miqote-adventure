return LoadFont("ScreenGameplay","SongTitle") .. {
	BeginCommand=cmd(playcommand,"Set"),
	SetCommand=function(self)
		local song = GAMESTATE:GetCurrentSong();
		local course = GAMESTATE:GetCurrentCourse();
		local s = ""
		if song then
			s = string.format("%s - %s", song:GetDisplayArtist(), song:GetDisplayFullTitle())
		end
		if course then
			s = string.format("%s - %s", course:GetDisplayFullTitle(), song:GetDisplayFullTitle())
		end
		self:settext( s )
		self:playcommand( "On" )
	end
}