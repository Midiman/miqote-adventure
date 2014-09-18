local function StepsDisplay(pn)
	local function set(self, player)
		self:SetFromGameState( player );
	end

	local t = Def.StepsDisplay {
		InitCommand=cmd(Load,"StepsDisplay",GAMESTATE:GetPlayerState(pn););
	};

	if pn == PLAYER_1 then
		t.CurrentStepsP1ChangedMessageCommand=function(self) set(self, pn); end;
		t.CurrentTrailP1ChangedMessageCommand=function(self) set(self, pn); end;
	else
		t.CurrentStepsP2ChangedMessageCommand=function(self) set(self, pn); end;
		t.CurrentTrailP2ChangedMessageCommand=function(self) set(self, pn); end;
	end

	return t;
end

local t = LoadFallbackB();

-- StepsDisplay
for pn in ivalues(PlayerNumber) do
	local MetricsName = "StepsDisplay" .. PlayerNumberToString(pn)

	t[#t+1] = StepsDisplay(pn) .. {
		InitCommand=function(self) 
			self:player(pn)
			self:name(MetricsName) 
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
		end,
		PlayerJoinedMessageCommand=function(self, params)
			if params.Player == pn then
				self:visible(true)
			end
		end,
		PlayerUnjoinedMessageCommand=function(self, params)
			if params.Player == pn then
				self:visible(false)
			end
		end,
	}
end

return t;