local pn = ...
local t = Def.ActorFrame {}

-- Background
local background = Def.ActorFrame {}
background[#background+1] = Def.ActorFrame {
	Name="PaneDisplayBackground",
	Def.Quad {
		Name="Background",
		InitCommand=cmd(zoomto,448,128),
		OnCommand=cmd(diffuse,ThemeColor.Background)
	},
	Def.Quad {
		Name="Header",
		InitCommand=cmd(zoomto,448-16,2;y,-40),
		OnCommand=cmd(diffuse,ThemeColor.BackgroundDark)
	},
}

-- Name
local player_name = Def.ActorFrame {}
player_name[#player_name+1] = Def.ActorFrame {
	Name="PlayerName",
	InitCommand=cmd(x,-(448-48)/2;y,-52),
	--
	LoadFont("Common Normal") .. {
		Text=PROFILEMAN:GetPlayerName(pn),
		InitCommand=cmd(x,-16;horizalign,left),
		OnCommand=cmd(zoom,0.75;diffuse,PlayerColor(pn))
	}
}

-- PlayerBest
local best_score = Def.ActorFrame {}
local best_score_x_start = -(448/24)/2 - 144
local best_score_y_start = -6
local best_score_y_spacing = 18

best_score[#best_score+1] = Def.ActorFrame {
	InitCommand=cmd(x,best_score_x_start;y,best_score_y_start),
	SetCommand=function(self)
		local c = self:GetChildren()

		local SongOrCourse, StepsOrTrail
		if GAMESTATE:IsCourseMode() then
			SongOrCourse = GAMESTATE:GetCurrentCourse()
			StepsOrTrail = GAMESTATE:GetCurrentTrail(pn)
		else
			SongOrCourse = GAMESTATE:GetCurrentSong()
			StepsOrTrail = GAMESTATE:GetCurrentSteps(pn)
		end

		local profile, scorelist
		local best_score = 0
		local best_grade = "Grade_Failed"
		if SongOrCourse and StepsOrTrail then
			local st = StepsOrTrail:GetStepsType()
			local diff = StepsOrTrail:GetDifficulty()
			local courseType = GAMESTATE:IsCourseMode() and SongOrCourse:GetCourseType() or nil
			local cd = GetCustomDifficulty(st, diff, courseType)
			--self:diffuse(CustomDifficultyToColor(cd))
			--self:shadowcolor(CustomDifficultyToDarkColor(cd))

			if PROFILEMAN:IsPersistentProfile(pn) then
				-- player profile
				profile = PROFILEMAN:GetProfile(pn);
			else
				-- machine profile
				profile = PROFILEMAN:GetMachineProfile();
			end;

			scorelist = profile:GetHighScoreList(SongOrCourse,StepsOrTrail)
			assert(scorelist)
			local scores = scorelist:GetHighScores()
			local topscore = scores[1]
			if topscore then
				best_score = topscore:GetPercentDP()*100.0
				best_grade = topscore:GetGrade()
			else
				best_score = 0
				best_grade = "Grade_Failed"
			end
		else
			best_score = 0
			best_grade = "Grade_Failed"
		end;
		c.CurrentBest:targetnumber(best_score)
		c.GradeDisplay:SetGrade(best_grade)
	end,
	CurrentSongChangedMessageCommand=cmd(playcommand,"Set"),
	CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Set"),
	CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"Set"),
	--
	Def.GradeDisplay {
		Name="GradeDisplay",
		InitCommand=cmd(Load,"GradeDisplay";y,-8),
		OnCommand=cmd(zoom,0.675)
	},
	Def.RollingNumbers {
		Name="CurrentBest",
		File=THEME:GetPathF("Common","Normal"),
		Text="-",
		InitCommand=cmd(y,24;Load,"RollingNumbersPaneDisplayPercent"),
		OnCommand=cmd(zoom,0.75)
	}
}

-- Radar Texts
local radar_text = Def.ActorFrame {}
local radar_x_start = -(448-24)/2 + 128
local radar_y_start = -28
local radar_x_spacing = 128
local radar_y_spacing = 17
local radar_rows = 4
local radar_start = 6

for i=radar_start,#RadarCategory do 
	local j = i - radar_start
	local x_pos = (math.floor((j)/4) % 4) * radar_x_spacing
	local y_pos = ((j) % 4) * radar_y_spacing
	local rc = RadarCategory[i]
	local str = THEME:GetString("RadarCategoryShort", ToEnumShortString(rc))
	local format = "%03i"

	radar_text[#radar_text+1] = Def.ActorFrame {
		InitCommand=cmd(x,radar_x_start + x_pos;y,radar_y_start + y_pos),
		SetCommand=function(self)
			local c = self:GetChildren()
			local song = GAMESTATE:GetCurrentSong()
			if song == nil then 
				c.Value:settext(0)
				return
			end

			local steps = GAMESTATE:GetCurrentSteps(pn)
			if steps == nil then
				c.Value:settext(0)
				return
			end
			
			local meter = steps:GetRadarValues(pn):GetValue(rc)
			c.Value:settextf(format, meter)
		end,
		CurrentSongChangedMessageCommand=cmd(playcommand,"Set"),
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Set"),
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"Set"),
		--
		Name="RadarFrame" .. i,
		LoadFont("Common Normal") .. {
			Name="Label",
			Text=str,
			--
			InitCommand=cmd(),
			OnCommand=cmd(horizalign,left;zoom,0.5;diffuse,ThemeColor.TextDark)
		},
		LoadFont("Common Normal") .. {
			Name="Value",
			Text="",
			--
			InitCommand=cmd(horizalign,right;x,128-8),
			OnCommand=cmd(diffuse,ThemeColor.Secondary;zoom,0.5),
		}
	}
end

-- Grade Bar
local grade_start_y = 52
local grade_meter_width = (448-16)
local grade_meter_height = 12

local grades = Def.ActorFrame {}
grades[#grades+1] = Def.ActorFrame {
	Name="GradeMeter",
	InitCommand=cmd(y,grade_start_y),
	SetCommand=function(self)
		local c = self:GetChildren()

		local SongOrCourse, StepsOrTrail
		if GAMESTATE:IsCourseMode() then
			SongOrCourse = GAMESTATE:GetCurrentCourse()
			StepsOrTrail = GAMESTATE:GetCurrentTrail(pn)
		else
			SongOrCourse = GAMESTATE:GetCurrentSong()
			StepsOrTrail = GAMESTATE:GetCurrentSteps(pn)
		end

		local profile, scorelist
		local best_score = 0

		if SongOrCourse and StepsOrTrail then
			local st = StepsOrTrail:GetStepsType()
			local diff = StepsOrTrail:GetDifficulty()
			local courseType = GAMESTATE:IsCourseMode() and SongOrCourse:GetCourseType() or nil
			local cd = GetCustomDifficulty(st, diff, courseType)
			--self:diffuse(CustomDifficultyToColor(cd))
			--self:shadowcolor(CustomDifficultyToDarkColor(cd))

			if PROFILEMAN:IsPersistentProfile(pn) then
				-- player profile
				profile = PROFILEMAN:GetProfile(pn);
			else
				-- machine profile
				profile = PROFILEMAN:GetMachineProfile();
			end;

			scorelist = profile:GetHighScoreList(SongOrCourse,StepsOrTrail)
			assert(scorelist)
			local scores = scorelist:GetHighScores()
			local topscore = scores[1]
			if topscore then
				best_score = topscore:GetPercentDP()
			else
				best_score = 0
			end
		else
			best_score = 0
		end;
		c.GradeMeterFill:zoomtowidth(best_score*(448-16))
	end,
	CurrentSongChangedMessageCommand=cmd(playcommand,"Set"),
	CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Set"),
	CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"Set"),
	-- Backing
	Def.Quad {
		Name="Background",
		InitCommand=cmd(zoomto,448-16,grade_meter_height),
		OnCommand=cmd(diffuse,Color.Black)
	},
	-- Fill
	Def.Quad {
		Name="GradeMeterFill",
		InitCommand=cmd(x,-grade_meter_width/2;zoomto,grade_meter_width * 0.5,grade_meter_height),
		OnCommand=cmd(horizalign,left;diffuse,PlayerColor(pn))
	}
}

local num_tiers = THEME:GetMetric("PlayerStageStats","NumGradeTiersUsed")
local function tier_position_function( percent )
	local v = percent ^ ( (percent+1) ^ ( (percent*math.log(1) ) ) )
	return v
end

for i = 2, num_tiers do
	local tier_position = THEME:GetMetric("PlayerStageStats",string.format("GradePercentTier%02i",i))

	local function position(i)
		return scale(i,0,1,-grade_meter_width/2,grade_meter_width/2)
	end

	grades[#grades+1] = Def.ActorFrame {
		InitCommand=cmd(x,position(tier_position);y,grade_start_y),
		--
		Def.Quad {
			InitCommand=cmd(zoomto,2,grade_meter_height;horizalign,right),
			OnCommand=cmd(diffuse,Color.White;diffusealpha,0.5)
		},
		LoadFont("Common Normal") .. {
			Text=THEME:GetString("Grade",string.format("Tier%02i",i)),
			InitCommand=cmd(horizalign,right;y,-14),
			OnCommand=cmd(zoom,0.5)
		}
	}
end

t[#t+1] = background
t[#t+1] = player_name
t[#t+1] = best_score
t[#t+1] = radar_text
t[#t+1] = grades

return t