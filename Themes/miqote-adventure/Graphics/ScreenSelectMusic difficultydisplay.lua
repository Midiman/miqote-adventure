local t = Def.ActorFrame {};

local function NumEdit( in_Song, in_StepsType )
	if in_Song then
		local sSong = in_Song
		local sCurrentStyle = GAMESTATE:GetCurrentStyle()
		local sStepsType = in_StepsType
		local iNumEdits = 0
		if sSong:HasEdits( sStepsType ) then
			local tAllSteps = sSong:GetAllSteps()
			for i,Step in pairs(tAllSteps) do
				if Step:IsAnEdit() and Step:GetStepsType() == sStepsType then
					iNumEdits = iNumEdits + 1
				end
			end
			return iNumEdits
		else
			return iNumEdits
		end
	else
		return 0
	end
end

local cell_width = 82
local x_margin = 38
local x_spacing = cell_width + x_margin
local y_spacing = 30
local difficulty_num_slots = 14
local difficulty_slot_width = 36
local difficulty_slot_x = 60
local difficulty_slot_spacing = 40


local difficulty_frame = Def.ActorFrame {}

for i,diff in pairs(Difficulty) do
	local y_pos = (i-1) * y_spacing
	local y_offset = (i%2 == 0) and 16 or 0
	local iconColor = GameColor.Difficulty[diff]
	local iconColorMid = ColorMidTone( iconColor )
	local iconColorDark = ColorDarkTone( iconColor )
	--
	local base = Def.ActorFrame {
		InitCommand=cmd(y,y_pos),
		OnCommand=cmd(playcommand,"Set"),
		SetCommand=function(self)
			local c = self:GetChildren()

			local SongOrCourse, StepsOrTrail
			local IsCourse = GAMESTATE:IsCourseMode()
			if IsCourse then
				SongOrCourse = GAMESTATE:GetCurrentCourse()
				StepsOrTrail = GAMESTATE:GetCurrentTrail(GAMESTATE:GetMasterPlayerNumber())
			else
				SongOrCourse = GAMESTATE:GetCurrentSong()
				StepsOrTrail = GAMESTATE:GetCurrentSteps(GAMESTATE:GetMasterPlayerNumber())
			end

			if SongOrCourse == nil then
				c.Meter:targetnumber(0)
				if diff == "Difficulty_Edit" then
					c.Description:settext("Edit")
				end
				self:playcommand("Disabled")
				self:playcommand("TweenOff")
				return
			end

			if StepsOrTrail == nil then
				c.Meter:targetnumber(0)
				if diff == "Difficulty_Edit" then
					c.Description:settext("Edit")
				end
				self:playcommand("Disabled")
				self:playcommand("TweenOff")
				return
			end

			local style = StepsOrTrail:GetStepsType() or nil
			if style == nil then
				c.Meter:targetnumber(0)
				if diff == "Difficulty_Edit" then
					c.Description:settext("Edit")
				end
				self:playcommand("Disabled")
				self:playcommand("TweenOff")
				return
			end

			if IsCourse then
				step = nil
				local all_trials = SongOrCourse:GetAllTrails()
				for i=1,#all_trials do
					local trial_difficulty = all_trials[i]:GetDifficulty()
					if trial_difficulty == diff then
						step = all_trials[i]
					end
				end
			else
				step = SongOrCourse:GetOneSteps( style, diff ) or nil
			end	

			if step == nil then
				c.Meter:targetnumber(0)
				if diff == "Difficulty_Edit" then
					c.Description:settext("Edit")
				end
				self:playcommand("Disabled")
				self:playcommand("TweenOff")
				return
			end
			
			local id = Enum.Reverse(Difficulty)[diff]
			
			c.Meter:targetnumber(step:GetMeter())

			self:playcommand("Enabled",{ Meter=step:GetMeter(), Difficulty=diff})
			self:playcommand("TweenOn")

			if not IsCourse then
				if diff == "Difficulty_Edit" and SongOrCourse:GetOneSteps( style, "Difficulty_Edit" ) then
					local num_edits = NumEdit( SongOrCourse, GAMESTATE:GetCurrentStyle():GetStepsType() )
					local edit_desc = (num_edits == 1) and "Edit" or "Edits"
					c.Meter:targetnumber(num_edits)
					c.Description:settextf(edit_desc)
				end
			end
		end,
		CurrentSongChangedMessageCommand=cmd(playcommand,"Set"),
		CurrentCourseChangedMessageCommand=cmd(playcommand,"Set"),
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Set"),
		CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"Set"),
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"Set"),
		CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"Set"),
		--
		Def.ActorFrame { 
			Name="Background",
			Def.Quad {
				InitCommand=cmd(x,-cell_width/2 - 23;zoomto,320,26),
				OnCommand=cmd(horizalign,left;faderight,1),
				AppealCommand=cmd(),
				EnabledCommand=cmd(diffuse,iconColorDark),
				DisabledCommand=cmd(diffuse,ThemeColor.DecorationBackground),
				OffCommand=(finishtweening)
			}
			--[[
			LoadActor(THEME:GetPathB("_frame","3x3"),"ascent marker",cell_width,8) .. {
				Name="NameFrameOverlay",
				InitCommand=cmd(),
				AppealCommand=cmd(glowshift;effectcolor1,color("1,1,1,0");effectcolor2,color("1,1,1,0.5");effecttiming,0.125,0,0.375,1.5;effectoffset,1 - i*0.1;effectclock,'timerglobal'),
				EnabledCommand=cmd(stoptweening;decelerate,TIME_SHORT;diffuse,iconColor;queuecommand,"Appeal"),
				DisabledCommand=cmd(stoptweening;stopeffect;linear,TIME_NORMAL;diffuse,ThemeColor.DecorationBackground),
				OffCommand=cmd(finishtweening)
			}
			]]
		},
		Def.RollingNumbers {
			Name="Meter",
			File=THEME:GetPathF("Common","Large"),
			Text="-",
			InitCommand=cmd(horizalign,right;x,cell_width/2 + (x_margin/4);y,1;shadowlength,1;Load,"RollingNumbersPaneDisplayMeter"),
			OnCommand=cmd(skewx,-0.125;zoom,0.75;maxwidth,36/0.75),
			EnabledCommand=cmd(diffuse,iconColor),
			DisabledCommand=cmd(diffuse,ThemeColor.DecorationBackground),
			OffCommand=cmd(finishtweening)
		},
		LoadFont("Common Normal") .. {
			Name="Description",
			Text=ToEnumShortString(diff),
			InitCommand=cmd(zoom,0.5;x,-cell_width/2),
			OnCommand=cmd(horizalign,left;maxwidth,56/0.5),
			EnabledCommand=cmd(diffuse,iconColor),
			DisabledCommand=cmd(diffuse,ThemeColor.DecorationBackground),
			OffCommand=cmd(finishtweening)
		},
	}
	for j=1,#base do
		for k=1,difficulty_num_slots do
			base[#base+1] = Def.Quad {
				InitCommand=cmd(x,difficulty_slot_x + (difficulty_slot_spacing * k);zoomto,difficulty_slot_width,24),
				OnCommand=cmd(),
				AppealCommand=cmd(glowshift;effectcolor1,color("1,1,1,0");effectcolor2,color("1,1,1,0.5");effecttiming,0.125,0,0.375,1.5;effectoffset,1 - (j+k)*0.1;effectclock,'timerglobal'),
				EnabledCommand=function(self, params)
					local isVisible = (k <= params.Meter)
					if isVisible then
						self:diffuse(isVisible and iconColor or ThemeColor.DecorationBackground)
						self:finishtweening()
						self:queuecommand("Appeal")
					else
						self:stopeffect()
						self:finishtweening()
					end
				end,
				DisabledCommand=cmd(stopeffect;diffuse,ThemeColor.DecorationBackground)
			}
		end
	end
	difficulty_frame[#difficulty_frame+1] = base
end

local y_offset = -40
local cursor_frame = Def.ActorFrame {}

for i,pn in pairs(PlayerNumber) do
	local pn_mod = (pn == PLAYER_1) and 1 or -1
	local pn_y_offset = (pn == PLAYER_1) and 0 or 80

	cursor_frame[#cursor_frame+1] = Def.ActorFrame {
		InitCommand=cmd(y,y_offset + pn_y_offset),
		BeginCommand=function(self)
			self:visible( GAMESTATE:IsHumanPlayer(pn) )
		end,
		--
		SetCommand=function(self)
			local c = self:GetChildren()

			local steps = GAMESTATE:GetCurrentSteps( pn ) or nil
			if steps == nil then return end

			local diff = steps:GetDifficulty() or nil
			if diff == nil then return end
			
			local id = Enum.Reverse(Difficulty)[diff]
			c.Cursor:playcommand("Tween")
			c.Cursor:x((id * x_spacing))
		end,
		CurrentSongChangedMessageCommand=cmd(playcommand,"Set"),
		CurrentCourseChangedMessageCommand=cmd(playcommand,"Set"),
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Set"),
		CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"Set"),
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"Set"),
		CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"Set"),
		--
		PlayerJoinedMessageCommand=function(self, params)
			if params.Player == pn then
				self:visible(true)
				self:playcommand("TweenOn")
			end
		end,
		PlayerUnjoinedMessageCommand=function(self, params)
			if params.Player == pn then
				self:visible(false)
				self:playcommand("TweenOff")
			end
		end,
		--

		Def.ActorFrame {
			Name="Cursor",
			TweenCommand=function(self)
				self:stoptweening()
				self:smooth( TIME_SHORT )
			end,
			LoadActor(THEME:GetPathG("_common","arrow")) .. {
				InitCommand=cmd(y,18 * pn_mod;x,-24 * pn_mod),
				OnCommand=cmd(diffuse,PlayerColor(pn);zoom,0.5;zoomy,0.5 * -pn_mod)
			},
			Def.Quad {
				InitCommand=cmd(zoomto,cell_width,24),
				OnCommand=cmd(diffuse,PlayerColor(pn))
			},
			LoadFont("Common Normal") .. {
				Text=ToEnumShortString(pn),
				InitCommand=cmd(shadowlength,1),
				OnCommand=cmd(zoom,0.75),
			},
		}
	}
end

t[#t+1] = difficulty_frame
t[#t+1] = LoadFont("Common Normal") .. {
	InitCommand=cmd(x,x_spacing * 2.5;y,40),
	BeginCommand=function(self)
		local b = THEME:GetMetric("Common","AutoSetStyle")
		self:visible(b)
	end,
	SetCommand=function(self)
		local steps = GAMESTATE:GetCurrentSteps( GAMESTATE:GetMasterPlayerNumber() ) or nil
		if steps == nil then return end

		style = steps:GetStepsType()
		autogen = steps:IsAutogen()

		local str = THEME:GetString("StepsType", ToEnumShortString(style)) or "Unknown"
		self:settext(str)
		self:playcommand( autogen and "Autogen" or "Normal")
	end,
	AutogenCommand=cmd(diffuseshift;effectcolor1,ThemeColor.Text;effectcolor2,Color.Green),
	NormalCommand=cmd(stopeffect),
	--
	CurrentSongChangedMessageCommand=cmd(playcommand,"Set"),
	CurrentCourseChangedMessageCommand=cmd(playcommand,"Set"),
	CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Set"),
	CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"Set"),
	CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"Set"),
	CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"Set"),
	OnCommand=cmd(shadowlength,1;zoom,0.75;diffuse,ThemeColor.Secondary)
}

return t
