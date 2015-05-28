local function StepsDisplay(pn)
	local function set(self, player)
		self:SetFromGameState( player )
	end

	local t = Def.StepsDisplay {
		InitCommand=cmd(Load,"StepsDisplayGameplay",GAMESTATE:GetPlayerState(pn))
	}

	if pn == PLAYER_1 then
		t.CurrentStepsP1ChangedMessageCommand=function(self) set(self, pn) end
		t.CurrentTrailP1ChangedMessageCommand=function(self) set(self, pn) end
	else
		t.CurrentStepsP2ChangedMessageCommand=function(self) set(self, pn) end
		t.CurrentTrailP2ChangedMessageCommand=function(self) set(self, pn) end
	end

	return t
end

local t = LoadFallbackB()

-- LifeMeterBar
for i, pn in pairs(PlayerNumber) do
	if ShowStandardDecoration("LifeMeterBar" ..  ToEnumShortString(pn)) then
		local life_type = GAMESTATE:GetPlayerState(pn):GetPlayerOptions("ModsLevel_Song"):LifeSetting()
		t[#t+1] = LoadActor(THEME:GetPathG(Var "LoadingScreen", "lifebar_" .. ToEnumShortString(life_type)), pn) .. {
			InitCommand=function(self)
				self:name("LifeMeterBar" .. ToEnumShortString(pn))
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
			end
		}
	end
end

-- Bonus
for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	t[#t+1] = LoadActor(THEME:GetPathG(Var "LoadingScreen","ScoringTest"), pn) .. {
		InitCommand=function(self)
			self:name("ScoringTest" .. ToEnumShortString(pn))
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
		end
	}
end

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

-- BPM
t[#t+1] = StandardDecorationFromFileOptional("BPMDisplay","BPMDisplay")

-- SongMeter
t[#t+1] = StandardDecorationFromFileOptional("SongMeter","SongMeter")

-- SongTitle
t[#t+1] = StandardDecorationFromFileOptional("SongTitle","SongTitle")

return t
