local pn = ...

local section_width = 384
local section_height = 96
local section_margin = 4
local section_y_spacing = 4

local meter_width = 256
local meter_height = 22

local value_format = "%04i"

local t = Def.ActorFrame {}

local background = Def.ActorFrame {
	Def.Quad {
		InitCommand=cmd(zoomto,section_width,section_height),
		OnCommand=cmd(diffuse,ThemeColor.Background)
	},
}

local score = Def.ActorFrame {
	OnCommand=cmd(playcommand,"Set"),
	SetCommand=function(self)
		local c = self:GetChildren()

		local stats = STATSMAN:GetPlayedStageStats(1):GetPlayerStageStats(pn)
		
		local score = stats:GetPercentDancePoints()

		c.Score:settextf("%02.2f%%", score * 100)
	end,
	--
	LoadFont("Common Large") .. {
		Name="Score",
		Text="Test",
		InitCommand=cmd(shadowlength,1;diffuse,PlayerColor(pn))
	}
}

--[[
for i, rc in pairs(RadarCategory) do
	if i < 6 then
		t[#t+1] = Def.ActorFrame {
			InitCommand=cmd(y,(i-1)*(section_height+section_y_spacing)),
			OnCommand=cmd(playcommand,"Set"),
			SetCommand=function(self)
				local c = self:GetChildren()

				local stats = STATSMAN:GetPlayedStageStats(1):GetPlayerStageStats(pn)
				
				local possible = stats:GetRadarPossible():GetValue(rc)
				local actual = stats:GetRadarActual():GetValue(rc)
				local total_notes = stats:GetRadarPossible():GetValue("RadarCategory_TapsAndHolds")
				
				local display_possible = (possible * total_notes) / total_notes
				local display_actual = (actual * total_notes) / total_notes

				c.RadarCategoryMeterPossible:zoomtowidth(meter_width * display_possible)
				c.RadarCategoryMeterFill:zoomtowidth(meter_width * display_actual)
				
				c.RadarCategoryValues:settextf("(%i/%i) of %i", actual * total_notes, possible * total_notes, total_notes)
			end,
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
				Name="RadarCategoryMeterPossible",
				InitCommand=cmd(x,((section_width/2)-section_margin)-meter_width;zoomto,(meter_width/2)-2,(meter_height)-2;horizalign,left),
				OnCommand=cmd(diffuse,ThemeColor.SecondaryDark)
			},
			Def.Quad {
				Name="RadarCategoryMeterFill",
				InitCommand=cmd(x,((section_width/2)-section_margin)-meter_width;zoomto,(meter_width/2)-2,(meter_height)-2;horizalign,left),
				OnCommand=cmd(diffuse,PlayerColor(pn))
			},
			LoadFont("Common Normal") .. {
				Name="RadarCategoryValues",
				Text="0/0",
				InitCommand=cmd(x,((section_width/2)-section_margin)-meter_width;horizalign,left),
				OnCommand=cmd(diffuse,ThemeColor.Text;zoom,0.75;shadowlength,1)
			},
		}
	end
end
]]

--t[#t+1] = background
t[#t+1] = score
return t