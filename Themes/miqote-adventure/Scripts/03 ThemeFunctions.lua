function SelectStylePositions(numItems)
	local positions = {}
	local padding_x = 32
	local spacing_x = 128
	for i = 1, numItems do
		local width = (padding_x + spacing_x) * ((i-1) - (numItems-1)/2 )
		--
		positions[#positions+1] = {
			MENU_CENTER_X + width,
			MENU_BOTTOM - 64
		}
	end
	return positions
end

function SelectPlayModePositions(numItems)
	local positions = {}
	local padding_x = 32
	local spacing_x = 128
	for i = 1, numItems do
		local width = (padding_x + spacing_x) * ((i-1) - (numItems-1)/2 )
		--
		positions[#positions+1] = {
			MENU_CENTER_X + width,
			MENU_BOTTOM - 64
		}
	end
	return positions
end