local item_width, item_height = 512, 64
return Def.ActorFrame {
	LoadActor(THEME:GetPathB("_frame","3x3"),"box",item_width-8,item_height-8)
}