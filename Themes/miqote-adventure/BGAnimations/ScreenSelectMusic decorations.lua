local function StepsDisplay(pn)
	local function set(self, player)
		self:SetFromGameState( player )
	end

	local t = Def.StepsDisplay {
		InitCommand=cmd(Load,"StepsDisplay",GAMESTATE:GetPlayerState(pn))
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

-- TextBanner
t[#t+1] = StandardDecorationFromFileOptional("TextBanner", "TextBanner")

-- BPM
t[#t+1] = StandardDecorationFromFileOptional("BPM", "BPM")

-- SortOrder
t[#t+1] = StandardDecorationFromFileOptional("SortOrder", "SortOrder")

-- DifficultyDisplay
t[#t+1] = StandardDecorationFromFileOptional("DifficultyDisplay","DifficultyDisplay")

-- SongCost
t[#t+1] = StandardDecorationFromFileOptional("SongCost","SongCost")

-- PaneDisplay
for i, pn in pairs(PlayerNumber) do
	if ShowStandardDecoration("PaneDisplay" ..  ToEnumShortString(pn)) then
		t[#t+1] = LoadActor(THEME:GetPathG(Var "LoadingScreen","PaneDisplay"), pn) .. {
			InitCommand=function(self)
				self:name("PaneDisplay" .. ToEnumShortString(pn))
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
			end
		}
	end
end

-- SongOptions transition
t[#t+1] = StandardDecorationFromFileOptional("OptionsTransition","OptionsTransition")

return t