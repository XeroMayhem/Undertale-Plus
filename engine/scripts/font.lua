local font = {}

function font:setFont(font, size)
	love.graphics.setNewFont('assets/fonts/'..font, size* gameScale)
end

function font:draw(text, x, y)
	love.graphics.print(text, x, y)
end

return font