local graph_width = THEME:GetMetric("GraphDisplay","BodyWidth")
local graph_height = THEME:GetMetric("GraphDisplay","BodyHeight")

return LoadFont("Common Normal") .. {
	Text="Barely!",
	InitCommand=cmd(),
	OnCommand=cmd(diffuse,ThemeColor.Secondary)
}