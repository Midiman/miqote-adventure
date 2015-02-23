local t = Def.ActorFrame {
	InitCommand=cmd(visible,false),
	ShowCommand=cmd(visible,true),
	HideCommand=cmd(visible,false),
	ToggleConsoleDisplayMessageCommand=function(self)   
	bOpen = not bOpen
	if bOpen then self:playcommand("Show") else self:playcommand("Hide") end
	end
	--
}

local grid_size_large = 32
local grid_size_small = 16
local screen_grid = Def.ActorFrame {
	InitCommand=cmd(Center),
	-- Small
	LoadActor(THEME:GetPathG("_texture","grid")) .. {
		InitCommand=cmd(zoomto,SCREEN_WIDTH,SCREEN_HEIGHT),
		OnCommand=cmd(diffusealpha,0.25;customtexturerect,0,0,SCREEN_WIDTH/grid_size_small,SCREEN_HEIGHT/grid_size_small)
	},
	-- Large
	LoadActor(THEME:GetPathG("_texture","grid")) .. {
		InitCommand=cmd(zoomto,SCREEN_WIDTH,SCREEN_HEIGHT),
		OnCommand=cmd(diffusealpha,0.5;customtexturerect,0,0,SCREEN_WIDTH/grid_size_large,SCREEN_HEIGHT/grid_size_large)
	}
}

local menu_region = Def.ActorFrame {
	-- Usable Region
	Def.Quad {
		InitCommand=cmd(xy,MENU_LEFT,MENU_CENTER_Y),
		OnCommand=cmd(horizalign,left;diffuse,Color.Orange;diffusealpha,0.5;zoomto,MENU_CENTER_X * 1.25,MENU_HEIGHT)
	},
	-- Test
	Def.Quad {
		InitCommand=cmd(xy,MENU_LEFT,MENU_CENTER_Y),
		OnCommand=cmd(horizalign,left;diffuse,Color.Purple;diffusealpha,0.5;zoomto,MENU_CENTER_X * 1.125 + 16,MENU_HEIGHT)
	},
	-- Center Left
	Def.Quad {
		InitCommand=cmd(xy,MENU_CENTER_X/2,MENU_CENTER_Y),
		OnCommand=cmd(diffuse,Color.Green;diffusealpha,0.25;zoomto,MENU_CENTER_X,MENU_HEIGHT)
	},
		Def.Quad {
		InitCommand=cmd(xy,MENU_CENTER_X/2,MENU_CENTER_Y),
		OnCommand=cmd(diffuse,Color.Green;diffusealpha,0.25;zoomto,MENU_CENTER_X *0.925,MENU_HEIGHT *0.925)
	}
}

local title_safe_grid = Def.ActorFrame {

	-- Vert Left
	Def.Quad {
		InitCommand=cmd(xy,SCREEN_WIDTH * 0.075,SCREEN_CENTER_Y;zoomto,2,SCREEN_HEIGHT),
		OnCommand=cmd(diffuse,Color.Blue)
	},
	-- Vert Right
	Def.Quad {
		InitCommand=cmd(xy,SCREEN_WIDTH * 0.925,SCREEN_CENTER_Y;zoomto,2,SCREEN_HEIGHT),
		OnCommand=cmd(diffuse,Color.Blue)
	},
	-- Horiz Top
	Def.Quad {
		InitCommand=cmd(xy,SCREEN_CENTER_X,SCREEN_HEIGHT * 0.075;zoomto,SCREEN_WIDTH,2),
		OnCommand=cmd(diffuse,Color.Blue)
	},
	-- Horiz Bottom
	Def.Quad {
		InitCommand=cmd(xy,SCREEN_CENTER_X,SCREEN_HEIGHT * 0.925;zoomto,SCREEN_WIDTH,2),
		OnCommand=cmd(diffuse,Color.Blue)
	},
}

local menu_center = Def.ActorFrame {
	-- Menu Horizontal
	Def.Quad {
		InitCommand=cmd(xy,MENU_CENTER_X,MENU_CENTER_Y;zoomto,SCREEN_WIDTH,2),
		OnCommand=cmd(diffuse,Color.Yellow;diffusealpha,0.25)
	},
	-- Menu Vertical
	Def.Quad {
		InitCommand=cmd(xy,MENU_CENTER_X,MENU_CENTER_Y;zoomto,2,SCREEN_HEIGHT),
		OnCommand=cmd(diffuse,Color.Yellow;diffusealpha,0.25)
	},
}

t[#t+1] = screen_grid
t[#t+1] = title_safe_grid
t[#t+1] = menu_center


return t
