local pn = ...

local life_meter_width = 512
local life_meter_num_segments = 48
local life_meter_height = 56
local life_meter_tip_width = 2
local life_meter_tip_gap = 64
local life_meter_outline = 4

local color_normal	= Color.Green
local color_hot		= Color.Blue
local color_danger	= Color.Red
local color_dead	= Color.Outline

local pn_offset = (pn == PLAYER_1) and 1 or -1
local name_offset_x = -life_meter_width/2

local function getPlayersName(pn)
	local s = PROFILEMAN:GetPlayerName(pn)
	if s == "" then
		return PlayerNumberToString(pn)
	end
	return s
end

local function MakeSeperators()
	local function x_pos(i)
		return (-life_meter_width/2) + (i/life_meter_num_segments)* life_meter_width
	end
	local a = Def.Quad {
		InitCommand=cmd(zoomto,2,life_meter_height),
		OnCommand=cmd(diffuse,Color.Black;diffusealpha,0.25)
	}
	local t = Def.ActorFrame {}
	for i=1, life_meter_num_segments do
		t[#t+1] = Def.ActorFrame { InitCommand=cmd(x,x_pos(i)); a }
	end
	return t
end

local t = Def.ActorFrame {}

local function updateFunc(self)
	local c = self:GetChildren();
	local beat = self:GetSecsIntoEffect() % 1
	local _beat = self.life == 1.00 and 0 or beat
	local _fillWidth = (life_meter_width * self.life - _beat * life_meter_tip_gap) / life_meter_width
	local _clampedWidth = math.round(_fillWidth * life_meter_num_segments) 
	local _tipPosition = (life_meter_width * self.life ) / life_meter_width
	local _tipClamped = math.round( _tipPosition * life_meter_num_segments )
	c.Fill:zoomtowidth( math.max(0,(_clampedWidth/life_meter_num_segments) * life_meter_width) )
	--c.Fill:zoomtowidth( (life_meter_width * self.life) - beat * life_meter_tip_gap)
	c.Tip:x( clamp(-life_meter_tip_width/2 + scale((_tipClamped/life_meter_num_segments) * life_meter_width,0,life_meter_width, -life_meter_width/2, life_meter_width/2),0, life_meter_width) ) 
	c.Health:settextf("%03i%%", self.life * 100 )
end

t[#t+1] = Def.ActorFrame {
	InitCommand=function(self)
		self:SetUpdateFunction(updateFunc)
		self.life = 0
	end,
	OnCommand=cmd(spin;effectclock,'beat';effectperiod,1;effectmagnitude,0,0,0),
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
			self.life = param.LifeMeter:GetLife()
			c.Fill:zoomtowidth( (life_meter_width) * self.life )
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
		OnCommand=cmd(diffuse,Color.Green),
		--
		HotCommand=cmd(diffuse,Color.Blue;glowshift;effectclock,'beat'),
		AliveCommand=cmd(diffuse,Color.Green;stopeffect),
		DangerCommand=cmd(diffuse,Color.Red;diffuseshift;effectclock,'beat';effectcolor1,PlayerColor(pn);effectcolor2,PlayerDarkColor(pn)),
		DeadCommand=cmd(diffuse,Color.Red;stopeffect)
	},
	MakeSeperators(),
	Def.Quad {
		Name="Tip",
		InitCommand=cmd(basezoomx,life_meter_tip_width;basezoomy,life_meter_height),
		--
		OnCommand=cmd(diffuse,Color.Green),
		--
		HotCommand=cmd(diffuse,Color.Blue;glowshift;effectclock,'beat'),
		AliveCommand=cmd(diffuse,Color.Green;stopeffect),
		DangerCommand=cmd(diffuse,Color.Red;diffuseshift;effectclock,'beat';effectcolor1,PlayerColor(pn);effectcolor2,PlayerDarkColor(pn)),
		DeadCommand=cmd(diffuse,Color.Red;stopeffect)
	},
	LoadFont("Common Large") .. {
		Name="Health",
		Text="100%",
		InitCommand=cmd(x,-life_meter_width/2;y,8;horizalign,pn == PLAYER_1 and left or right),
		OnCommand=cmd(zoomx,pn_offset;shadowlength,1)
	}
}

return t