local graph_width = THEME:GetMetric("GraphDisplay","BodyWidth")
local graph_height = THEME:GetMetric("GraphDisplay","BodyHeight")

return Def.Quad {
	InitCommand=cmd(zoomto,4,graph_height),
	OnCommand=cmd(diffuse,ThemeColor.Secondary)
}