local t = LoadFallbackB()

-- LifeMeterBar
for i, pn in pairs(PlayerNumber) do
	if ShowStandardDecoration("LifeMeterBar" ..  ToEnumShortString(pn)) then
		t[#t+1] = LoadActor(THEME:GetPathG(Var "LoadingScreen","lifemeterbar"), pn) .. {
			InitCommand=function(self)
				self:name("LifeMeterBar" .. ToEnumShortString(pn))
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
			end
		}
	end
end

-- BPM
t[#t+1] = StandardDecorationFromFileOptional("BPM","BPM")

-- SongMeter
t[#t+1] = StandardDecorationFromFileOptional("SongMeter","SongMeter")

-- SongTitle
t[#t+1] = StandardDecorationFromFileOptional("SongTitle","SongTitle")

return t