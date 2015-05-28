pn = ...

local score_format = "%02.2f%%"
local combo_format = "%03i"

local t = Def.ActorFrame {
	LoadFont("Common Normal") .. {
		Name="Score",
		Text=pn,
		BeginCommand=cmd(playcommand,"Set"),
		SetCommand=function(self)
			local percent = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetPercentDancePoints()
			self:settextf(score_format, percent * 100)
		end,
		-- Find out why ScoreChangedMessage doesn't work
		JudgmentMessageCommand=function(self, params)
			if params.Player == pn then
				self:playcommand("Set")
			else
				return
			end
		end
	},
	LoadFont("Common Normal") .. {
		Name="MaxCombo",
		Text=pn,
		OnCommand=cmd(y,32),
		BeginCommand=cmd(playcommand,"Set"),
		SetCommand=function(self)
			local combo = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):MaxCombo()
			self:settextf(combo_format, combo)
		end,
		-- Find out why ScoreChangedMessage doesn't work
		JudgmentMessageCommand=function(self, params)
			if params.Player == pn then
				self:playcommand("Set")
			else
				return
			end
		end
	},
}

return t
