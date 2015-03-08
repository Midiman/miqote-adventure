local item_width, item_height = 512, 64
return Def.ActorFrame {
	LoadActor(THEME:GetPathB("_frame","3x3"),"box",item_width-8,item_height-8) .. {
		AppealCommand=cmd(blend,Blend.Add;),
		OnCommand=function(self)
			self:playcommandonleaves("Appeal")
			local c = self:GetChildren()
			c.Middle:faderight(1)
		end
	}
}