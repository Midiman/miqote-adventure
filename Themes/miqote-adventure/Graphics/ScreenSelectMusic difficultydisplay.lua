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

local cell_width = 96
local x_spacing = cell_width + 26

local difficulty_frame = Def.ActorFrame {}

for i,diff in pairs(Difficulty) do
	local x_pos = (i-1) * x_spacing
	local iconColor = GameColor.Difficulty[diff]
	
	local iconColorDark = ColorDarkTone( iconColor )
	--
	difficulty_frame[#difficulty_frame+1] = Def.ActorFrame {
		InitCommand=cmd(x,x_pos),
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

			self:playcommand("Enabled")
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
		LoadActor(THEME:GetPathG("_difficultyDisplay","cell")) .. {
			Name="Background",
			InitCommand=cmd(),
			AppealCommand=cmd(diffuseshift;effectcolor1,iconColorDark;effectcolor2,iconColor;effecttiming,0.125,0,0.375,1.5;effectoffset,1 - i*0.1;effectclock,'timerglobal'),
			EnabledCommand=cmd(stoptweening;decelerate,TIME_SHORT;diffuse,iconColorDark),
			DisabledCommand=cmd(stoptweening;stopeffect;linear,TIME_NORMAL;diffuse,ThemeColor.Background),
			OffCommand=cmd(finishtweening)
		},
		Def.RollingNumbers {
			Name="Meter",
			File=THEME:GetPathF("Common","Large"),
			Text="-",
			InitCommand=cmd(shadowlength,1;Load,"RollingNumbersPaneDisplayMeter"),
			OnCommand=cmd(horizalign,right;x,cell_width/2 - 2;skewx,-0.125),
			EnabledCommand=cmd(diffuse,iconColor),
			DisabledCommand=cmd(diffuse,color("#7C7C7C")),
			OffCommand=cmd(finishtweening)
		},
		LoadFont("Common Normal") .. {
			Name="Description",
			Text=ToEnumShortString(diff),
			InitCommand=cmd(zoom,0.5;shadowlength,1;x,-cell_width/2 + 2;y,12),
			OnCommand=cmd(horizalign,left),
			EnabledCommand=cmd(diffuse,iconColor;textglowmode,'TextGlowMode_Inner';glow,color("1,1,1,0.875")),
			DisabledCommand=cmd(diffuse,color("#7C7C7C")),
			OffCommand=cmd(finishtweening)
		}
	}
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
t[#t+1] = cursor_frame
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