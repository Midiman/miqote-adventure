local function StepsDisplay(pn)
	local function set(self, player)
		self:SetFromGameState( player )
	end

	local t = Def.StepsDisplay {
		InitCommand=cmd(Load,"StepsDisplayEvaluation",pn;SetFromGameState,pn),
		UpdateNetEvalStatsMessageCommand=function(self, param)
			if GAMESTATE:IsPlayerEnabled(pn) then
				self:SetFromSteps(param.Steps)
			end
		end,
	}

	return t
end

local function GraphDisplay( pn )
	local t = Def.ActorFrame {
		Def.GraphDisplay {
			InitCommand=cmd(Load,"GraphDisplay"),
			BeginCommand=function(self)
				local ss = SCREENMAN:GetTopScreen():GetStageStats()
				self:Set( ss, ss:GetPlayerStageStats(pn) )
				self:player( pn )
			end
		}
	}
	return t
end

local function ComboGraph( pn )
	local t = Def.ActorFrame {
		Def.ComboGraph {
			InitCommand=cmd(Load,"ComboGraph"),
			BeginCommand=function(self)
				local ss = SCREENMAN:GetTopScreen():GetStageStats()
				self:Set( ss, ss:GetPlayerStageStats(pn) )
				self:player( pn )
			end
		}
	}
	return t
end

local t = LoadFallbackB()

-- StepsDisplay
for i, pn in pairs(PlayerNumber) do
	if ShowStandardDecoration("StepsDisplay" ..  ToEnumShortString(pn)) then
		t[#t+1] = StepsDisplay(pn) .. {
			InitCommand=function(self)
				self:name("StepsDisplay" .. ToEnumShortString(pn))
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
			end
		}
	end
end

-- GraphDisplay
for i, pn in pairs(GAMESTATE:GetHumanPlayers()) do
	t[#t+1] = StandardDecorationFromTable( "GraphDisplay" .. ToEnumShortString(pn), GraphDisplay(pn) )
end

-- ComboGraph
for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	t[#t+1] = StandardDecorationFromTable( "ComboGraph" .. ToEnumShortString(pn), ComboGraph(pn) )
end

-- Judgments
for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	t[#t+1] = LoadActor(THEME:GetPathG(Var "LoadingScreen","judgments"), pn) .. {
		InitCommand=function(self)
			self:name("Judgments" .. ToEnumShortString(pn))
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
		end
	}
end

-- ScorePanel
for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	t[#t+1] = LoadActor(THEME:GetPathG(Var "LoadingScreen","scorepanel"), pn) .. {
		InitCommand=function(self)
			self:name("ScorePanel" .. ToEnumShortString(pn))
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
		end
	}
end
-- SongTitle
t[#t+1] = StandardDecorationFromFileOptional("SongTitle","SongTitle")

return t