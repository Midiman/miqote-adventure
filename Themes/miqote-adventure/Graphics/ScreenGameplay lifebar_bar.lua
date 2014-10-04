local pn = ...
local life_meter_width = 512
local life_meter_height = 56
local life_meter_outline = 4

local t = Def.ActorFrame {}

t[#t+1] = Def.ActorFrame {
	HealthStateChangedMessageCommand=function(self,param)
		local c = self:GetChildren()

		if param.PlayerNumber == pn then
			if param.HealthState ~= param.OldHealthState then
				local state_name = ToEnumShortString(param.HealthState)
				self:playcommand(state_name)
			end
		end
	end,
	LifeChangedMessageCommand=function(self,param)
		local c = self:GetChildren()
		if param.Player == pn then
			local life = param.LifeMeter:GetLife()
			c.Fill:zoomtowidth( life_meter_width * life )
		end
	end,
	-- Outline
	Def.Quad {
		Name="Outline",
		InitCommand=cmd(zoomto,life_meter_width+life_meter_outline,life_meter_height+life_meter_outline),
		OnCommand=cmd()
	},
	-- Background 
	Def.Quad {
		Name="Background",
		InitCommand=cmd(zoomto,life_meter_width,life_meter_height),
		OnCommand=cmd(diffuse,ThemeColor.Background),
		--
		AliveCommand=cmd(stopeffect;diffuse,ThemeColor.BackgroundDark),
		DangerCommand=cmd(diffuseshift;effectcolor2,ColorMidTone(Color.Red);effectcolor1,ColorDarkTone(Color.Red)),
		DeadCommand=cmd(stopeffect;diffuse,ThemeColor.BackgroundDark),
	},
	Def.Quad {
		Name="Fill",
		InitCommand=cmd(x,-life_meter_width/2;zoomto,life_meter_width,life_meter_height;horizalign,left),
		OnCommand=cmd(diffuse,PlayerColor(pn)),
		--
		HotCommand=cmd(glowshift;effectclock,'beat'),
		AliveCommand=cmd(stopeffect),
		DangerCommand=cmd(diffuseshift;effectclock,'beat';effectcolor1,PlayerColor(pn);effectcolor2,PlayerDarkColor(pn)),
		DeadCommand=cmd(stopeffect)
	},
	Def.ActorFrame {
		Name="SeperatorHolder",
	}
}

return t