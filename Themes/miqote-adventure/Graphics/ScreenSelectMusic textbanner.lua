local t = Def.ActorFrame {}
--
t[#t+1] = Def.ActorFrame {
	SetCommand=function(self)
		local c = self:GetChildren()

		local song = GAMESTATE:GetCurrentSong() or nil
		if song == nil then
			self:playcommand("TweenOff")

			c.Title:settext("-")
			c.Artist:settext("-")
			c.Genre:settext("-")
			return 
		end

		genre = song:GetGenre() or "Unknown"
		disp_genre = (genre ~= "") and genre or "None"

		self:playcommand("TweenOn")
		c.Title:settext( song:GetDisplayFullTitle() )
		c.Artist:settext( song:GetDisplayArtist() )
		c.Genre:settext( disp_genre )
	end,
	CurrentSongChangedMessageCommand=cmd(playcommand,"Set"),
	DisplayLanguageChangedMessageCommand=cmd(playcommand,"Set"),
	--
	Def.Quad {
		Name="Underline",
		InitCommand=cmd(y,36;horizalign,right),
		OnCommand=cmd(zoomto,512,4)
	},
	--
	LoadFont("Common Normal") .. {
		Name="Title",
		Text="SongName",
		InitCommand=cmd(y,-12;horizalign,right),
		OnCommand=cmd(shadowlength,1;diffusebottomedge,ThemeColor.TextDark)
	},
		LoadFont("Common Normal") .. {
		Name="Artist",
		Text="SongName",
		InitCommand=cmd(y,16;horizalign,right),
		OnCommand=cmd(shadowlength,1)
	},
	LoadFont("Common Normal") .. {
		Name="Genre",
		Text="SongName",
		InitCommand=cmd(y,-32;horizalign,right),
		OnCommand=cmd(shadowlength,1;zoom,0.5)
	},
}

--

return t