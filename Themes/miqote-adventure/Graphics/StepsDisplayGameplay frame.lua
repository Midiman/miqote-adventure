local item_width, item_height = 256, 40
return Def.ActorFrame {
	LoadActor(THEME:GetPathB("_frame","3x3"),"box",item_width-8,item_height-8) .. {},
	Def.Quad {
		InitCommand=cmd(zoomto,2,item_height-4;x,64),
	}
}