local player = Var "Player"

local bar_width = 256
local bar_height = 32

local life_meter, lives_max, lives_current;

local t = Def.ActorFrame {
		BeginCommand=function(self,param)
			local screen = SCREENMAN:GetTopScreen();
			local glifemeter = screen:GetLifeMeter(player);
				self:setstate(clamp(glifemeter:GetTotalLives()-1,0,9));
				
				if glifemeter:GetTotalLives() <= 4 then
					self:zoomx(barWidth/(4*64));
				else
					self:zoomx(barWidth/((glifemeter:GetTotalLives())*64));
				end
				self:cropright((640-(((glifemeter:GetTotalLives())*64)))/640);
		end,
		LifeChangedMessageCommand=function(self,param)
			if param.Player == player then
				if param.LivesLeft == 0 then
					self:visible(false)
				else
					self:setstate( clamp(param.LivesLeft-1,0,9) )
					self:visible(true)
				end
			end
		end,
		StartCommand=function(self,param)
			if param.Player == player then
				self:setstate( clamp(param.LivesLeft) )
			end			
		end,
		FinishCommand=cmd(playcommand,"Start");
	};
};

return t;