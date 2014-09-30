local section_width = 256
local section_height = 32
local section_margin = 4
local section_y_spacing = 4
local value_format = "%04i"

local t = Def.ActorFrame {}

for i, jl in pairs(JudgmentLine) do 
	t[#t+1] = Def.ActorFrame {
		InitCommand=cmd(y,(i-1)*section_height),
		--
		Def.Quad {
			Name="Background",
			InitCommand=cmd(zoomto,section_width,section_height),
			OnCommand=cmd(diffuse,JudgmentLineToColor(jl))
		},
		LoadFont("Common Normal") .. {
			Name="JudgmentName",
			Text=JudgmentLineToLocalizedString(jl),
			InitCommand=cmd(x,-(section_width/2)+section_margin;horizalign,left),
			OnCommand=cmd(diffuse,ThemeColor.Text;shadowlength,1)
		},
		LoadFont("Common Normal") .. {
			Name="JudgmentValue",
			Text=string.format(value_format,0),
			InitCommand=cmd(x,(section_width/2)-section_margin;horizalign,right),
			OnCommand=cmd(diffuse,ThemeColor.TextDark;shadowlength,1)
		},
	}
end

return t