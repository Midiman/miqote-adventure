local item_width, item_height = 128+32, 28
return Def.ActorFrame {
	LoadActor(THEME:GetPathB("_frame","3x3"),"box",item_width-8,item_height-8) .. {},
	Def.Quad {
		InitCommand=cmd(zoomto,2,item_height-4;x,2+(116/2)-(160-116)/2),
	}
}