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

		genre = GenreGen.GenerateFromSong( song)
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
	LoadFont("Common Large") .. {
		Name="Title",
		Text="SongName",
		InitCommand=cmd(y,-6;maxwidth,512;horizalign,right),
		OnCommand=cmd(shadowlength,1;skewx,-0.125;diffusebottomedge,ThemeColor.PrimaryDark),
		TweenOnCommand=cmd(finishtweening;diffusealpha,0;addx,-8;addy,-8;decelerate,TIME_SHORT;addx,8;addy,8;diffusealpha,1)
	},
	LoadFont("Common Normal") .. {
		Name="Artist",
		Text="SongArtist",
		InitCommand=cmd(y,22;horizalign,right),
		OnCommand=cmd(zoom,0.75;shadowlength,1),
		TweenOnCommand=cmd(finishtweening;diffusealpha,0;addx,8;addy,8;decelerate,TIME_SHORT;addx,-8;addy,-8;diffusealpha,1)
	},
	LoadFont("Common Normal") .. {
		Name="Genre",
		Text="SongGenre",
		InitCommand=cmd(y,-36;horizalign,right),
		OnCommand=cmd(zoom,0.75;shadowlength,1),
		TweenOnCommand=cmd(finishtweening;diffusealpha,0;addx,8;addy,-8;decelerate,TIME_SHORT;addx,-8;addy,8;diffusealpha,1)
	},
}

--

return t