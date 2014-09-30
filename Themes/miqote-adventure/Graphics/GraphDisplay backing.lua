local graph_width = THEME:GetMetric("GraphDisplay","BodyWidth")
local graph_height = THEME:GetMetric("GraphDisplay","BodyHeight")

return Def.Quad {
	InitCommand=cmd(zoomto,graph_width,graph_height),
	OnCommand=cmd(diffuse,ThemeColor.Background)
}