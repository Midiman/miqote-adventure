local section_width = 384
local section_height = 28
local section_margin = 4
local section_y_spacing = 4

local meter_width = 256
local meter_height = 22

local value_format = "%04i"

local t = Def.ActorFrame {}

for i, rc in pairs(RadarCategory) do
	if i < 6 then
		t[#t+1] = Def.ActorFrame {
			InitCommand=cmd(y,(i-1)*(section_height+section_y_spacing)),
			--
			Def.Quad {
				Name="Background",
				InitCommand=cmd(zoomto,section_width,section_height),
				OnCommand=cmd(diffuse,ThemeColor.Background)
			},
			LoadFont("Common Normal") .. {
				Name="RadarCategoryName",
				Text=RadarCategoryToLocalizedString(rc),
				InitCommand=cmd(x,-(section_width/2)+section_margin;horizalign,left),
				OnCommand=cmd(diffuse,ThemeColor.Text;zoom,0.75;shadowlength,1)
			},
			Def.Quad {
				Name="RadarCategoryMeterBackground",
				InitCommand=cmd(x,(section_width/2)-section_margin;zoomto,meter_width,meter_height;horizalign,right),
				OnCommand=cmd(diffuse,ThemeColor.BackgroundDark)
			},
			Def.Quad {
				Name="RadarCategoryMeterFill",
				InitCommand=cmd(x,((section_width/2)-section_margin)-meter_width+2;zoomto,(meter_width/2)-2,(meter_height)-2;horizalign,left),
				OnCommand=cmd(diffuse,ThemeColor.Secondary)
			},
		}
	end
end

return t