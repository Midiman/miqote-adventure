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
	--
	Def.Quad {
		InitCommand=cmd(zoomto,144,4),
		OnCommand=cmd(diffuse,ThemeColor.TextDark)
	},
	--
	LoadFont("Common Normal") .. {
		Name="CurrentBest",
		Text=string.format("%02.02f%%", math.random(0,10000)/100),
		--
		InitCommand=cmd(y,best_score_y_spacing*-1),
		OnCommand=cmd(shadowlength,1)
	},
	LoadFont("Common Normal") .. {
		Name="MachineBest",
		Text=string.format("%02.02f%%", 100.00),
		--
		InitCommand=cmd(y,best_score_y_spacing),
		OnCommand=cmd(shadowlength,1)
	}
}

-- Radar Texts
local radar_text = Def.ActorFrame {}
local radar_x_start = -(448-24)/2 + 192-16
local radar_x_spacing = 128
local radar_y_spacing = 16
local radar_rows = 4
-- kind of ugly
local radar_start = 6

for i=radar_start,#RadarCategory do 
	local j = i - radar_start
	local x_pos = (math.floor((j)/4) % 4) * radar_x_spacing
	local y_pos = ((j) % 4) * radar_y_spacing
	local str = RadarCategoryToLocalizedString(RadarCategory[i])
	radar_text[#radar_text+1] = Def.ActorFrame {
		InitCommand=cmd(x,radar_x_start + x_pos;y,-16 + y_pos),
		--
		Name="RadarFrame" .. i,
		LoadFont("Common Normal") .. {
			Name="Label",
			Text=str,
			--
			InitCommand=cmd(),
			OnCommand=cmd(horizalign,left;zoom,0.5;diffuse,ThemeColor.TextDark;shadowlength,1)
		},
		LoadFont("Common Normal") .. {
			Name="Value",
			Text=string.format("%03i",math.random(0,999)),
			--
			InitCommand=cmd(horizalign,right;x,128-8),
			OnCommand=cmd(diffuse,ThemeColor.Secondary;shadowlength,1;zoom,0.5),
		}
	}
end

-- Grades
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