local font = {}

function font:setFont(font, size)
	love.graphics.setNewFont('assets/fonts/'..font, size* gameScale)
end

function font:draw(text, x, y)
	love.graphics.print(text, x, y)
end

function font:draw_centred(text, x, y)
	if type(text) == "string" then
		font:draw(text, x -(love.graphics.getFont():getWidth(text)/2), y)
	elseif type(text) == "table" then
		font:draw(text, x -(love.graphics.getFont():getWidth(text[2])/2), y)
	end
end

return font