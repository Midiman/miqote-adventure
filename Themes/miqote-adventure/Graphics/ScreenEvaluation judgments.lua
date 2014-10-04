local pn = ...

local section_width = 256
local section_height = 24
local section_margin = 4
local section_y_spacing = 6
local value_format = "%04i"

local function GetTapNoteScore( tns )
	local stats = STATSMAN:GetPlayedStageStats(1):GetPlayerStageStats(pn)
	return stats:GetTapNoteScores(tns)
end

local function GetMaxCombo()
	local stats = STATSMAN:GetPlayedStageStats(1):GetPlayerStageStats(pn)
	return stats:MaxCombo()
end

local JudgmentLineMapping = {
	JudgmentLine_W1 = GetTapNoteScore("TapNoteScore_W1"),
	JudgmentLine_W2 = GetTapNoteScore("TapNoteScore_W2"),
	JudgmentLine_W3 = GetTapNoteScore("TapNoteScore_W3"),
	JudgmentLine_W4 = GetTapNoteScore("TapNoteScore_W4"),
	JudgmentLine_W5 = GetTapNoteScore("TapNoteScore_W5"),
	JudgmentLine_Miss = GetTapNoteScore("TapNoteScore_Miss"),
	JudgmentLine_Held = GetTapNoteScore("TapNoteScore_CheckpointHit"),
	JudgmentLine_MaxCombo = GetMaxCombo(),
}

local t = Def.ActorFrame {}

for i, jl in pairs(JudgmentLine) do 
	t[#t+1] = Def.ActorFrame {
		InitCommand=cmd(y,(i-1)*(section_height+section_y_spacing)),
		OnCommand=cmd(playcommand,"Set"),
		SetCommand=function(self)
			local c = self:GetChildren()

			c.JudgmentValue:settextf(value_format,JudgmentLineMapping[jl])
		end,
		--
		Def.Quad {
			Name="Background",
			InitCommand=cmd(zoomto,section_width,section_height),
			OnCommand=cmd(diffuse,ThemeColor.Background)
		},
		LoadFont("Common Normal") .. {
			Name="JudgmentName",
			Text=JudgmentLineToLocalizedString(jl),
			InitCommand=cmd(x,-(section_width/2)+section_margin;horizalign,left),
			OnCommand=cmd(diffuse,JudgmentLineToColor(jl);zoom,0.75;shadowlength,1)
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