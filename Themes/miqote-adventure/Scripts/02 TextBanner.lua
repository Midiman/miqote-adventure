local max_width = 480 - 32
local full_zoom = 1
local min_zoom = 0.75
local artist_base_zoom = 0.75

function TextBannerAfterSet(self,param)
	local Title = self:GetChild("Title")
	local Subtitle = self:GetChild("Subtitle")
	local Artist = self:GetChild("Artist")
	
	if Subtitle:GetText() == "" then
		Title:maxwidth(max_width)
		Title:y(-12)
		Title:zoom(full_zoom)

		-- hide so that the game skips drawing.
		Subtitle:visible(false)

		Artist:zoom(artist_base_zoom)
		Artist:maxwidth(max_width/artist_base_zoom)
		Artist:y(12)
	else
		Title:maxwidth(max_width/min_zoom)
		Title:y(-16)
		Title:zoom(min_zoom)
		
		-- subtitle below title
		Subtitle:visible(true)
		Subtitle:zoom(min_zoom * 0.75)
		Subtitle:y(1)
		Subtitle:maxwidth(max_width/min_zoom)
		
		Artist:visible(true)
		Artist:zoom(artist_base_zoom * 0.75)
		Artist:maxwidth(max_width/artist_base_zoom)
		Artist:y(16)
	end
end