local t = Def.ActorFrame {}

local arrows = Def.ActorFrame {
	LoadActor(THEME:GetPathG("_common", "arrow")) .. {
		InitCommand=cmd(x,MENU_LEFT_SAFE),
		OnCommand=cmd(rotationz,-90),
		MoveCommand=cmd(finishtweening;addx,32;decelerate,TIME_SHORT;addx,-32),
		MenuLeftP1MessageCommand=cmd(playcommand,"Move"),
		MenuLeftP2MessageCommand=cmd(playcommand,"Move")
	},
	LoadActor(THEME:GetPathG("_common", "arrow")) .. {
		InitCommand=cmd(x,MENU_RIGHT_SAFE),
		OnCommand=cmd(rotationz,90),
		MoveCommand=cmd(finishtweening;addx,32;decelerate,TIME_SHORT;addx,-32),
		MenuRightP1MessageCommand=cmd(playcommand,"Move"),
		MenuRightP2MessageCommand=cmd(playcommand,"Move")
	},	
}

t[#t+1] = arrows

return t