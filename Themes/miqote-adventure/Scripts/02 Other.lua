function JudgmentTransformCommand( self, params )
	local y = 0
	if params.bReverse then y = y * -1 end

	self:y( y )
end

function JudgmentTransformSharedCommand( self, params )
	local y = 0
	if params.bReverse then y = y * -1 end

	self:y( y )
end

function ComboTransformCommand( self, params )
	local y = 0
	if params.bReverse then y = y * -1 end

	self:y( y )
end