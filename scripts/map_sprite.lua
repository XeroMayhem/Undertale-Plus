local obj = {}
--[[
    x = -1
    y = -1
    spriteSheet = nil--love.graphics.newImage('assets/sprites/npcs/sign.png')
    anim = nil
    sprite = nil
]]
function obj:draw(x, y, sprite, anim, spriteSheet)

    if sprite ~= nil then
        love.graphics.draw(sprite, x *gameScale, y *gameScale, nil, gameScale, gameScale, sprite:getWidth()/2, sprite:getHeight()/2)
    elseif anim ~= nil then
        anim:draw(spriteSheet, x *gameScale, y *gameScale, nil, gameScale)
    end

end

return obj