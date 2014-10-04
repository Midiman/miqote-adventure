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
		InitCommand=cmd(zoomto,448-16,2;y,-28),
		OnCommand=cmd(diffuse,ThemeColor.BackgroundDark)
	},
}

-- Name
local player_name = Def.ActorFrame {}
player_name[#player_name+1] = Def.ActorFrame {
	Name="PlayerName",
	InitCommand=cmd(x,-(448-48)/2;y,-44),
	--
	LoadFont("Common Normal") .. {
		Text=ToEnumShortString(pn),
		OnCommand=cmd(diffuse,PlayerColor(pn))
	}
}

-- PlayerBest
local best_score = Def.ActorFrame {}
local best_score_x_start = -(448/24)/2 - 114
local best_score_y_start = 8
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
		InitCommand=cmd(Load,"GradeDisplay";y,-12),
		OnCommand=cmd(zoom,0.75)
	},
	Def.RollingNumbers {
		Name="CurrentBest",
		File=THEME:GetPathF("Common","Normal"),
		Text="-",
		InitCommand=cmd(y,24;Load,"RollingNumbersPaneDisplayPercent"),
	}
}

-- Radar Texts
local radar_text = Def.ActorFrame {}
local radar_x_start = -(448-24)/2 + 192-16
local radar_x_spacing = 128
local radar_y_spacing = 16
local radar_rows = 4
local radar_start = 6

for i=radar_start,#RadarCategory do 
	local j = i - radar_start
	local x_pos = (math.floor((j)/4) % 4) * radar_x_spacing
	local y_pos = ((j) % 4) * radar_y_spacing
	local rc = RadarCategory[i]
	local str = RadarCategoryToLocalizedString(rc)
	local format = "%03i"

	radar_text[#radar_text+1] = Def.ActorFrame {
		InitCommand=cmd(x,radar_x_start + x_pos;y,-16 + y_pos),
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
local grades = Def.ActorFrame {}
grades[#grades+1] = Def.ActorFrame {
	Name="GradeMeter",
	InitCommand=cmd(y,52),
	-- Backing
	Def.Quad {
		Name="Background",
		InitCommand=cmd(zoomto,448-16,8),
		OnCommand=cmd(diffuse,Color.Black)
	},
	-- Fill
	Def.Quad {
		Name="GradeMeterFill",
		InitCommand=cmd(x,-(448-16)/2;zoomto,(448-16) * 0.5,8),
		OnCommand=cmd(horizalign,left;diffuse,PlayerColor(pn))
	}
}

t[#t+1] = background
t[#t+1] = player_name
t[#t+1] = best_score
t[#t+1] = radar_text
t[#t+1] = grades

return t