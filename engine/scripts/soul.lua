local player = {}
local death_count = 1

function player:update(soul)

    local vx = 0
    local vy = 0
    soul.speed = 2

    if love.keyboard.isDown("right") then
        vx = soul.speed
    end
    if love.keyboard.isDown("left") then
        vx = -soul.speed
    end
    if love.keyboard.isDown("up") then
        vy = -soul.speed
    end
    if love.keyboard.isDown("down") then
        vy = soul.speed
    end

    soul.x = soul.x +vx
    soul.y = soul.y +vy
    local sprite = love.graphics.newImage(bt.soul.sprite)

    if soul.x < 320 -(bt.box.width/2) +bt.box.border then
        soul.x = 320 -(bt.box.width/2) +bt.box.border
    end

    if soul.x > 320 +(bt.box.width/2) -bt.box.border -sprite:getWidth() then
        soul.x = 320 +(bt.box.width/2) -bt.box.border -sprite:getWidth()
    end

    if soul.y < 320 -(bt.box.height/2) +bt.box.border then
        soul.y = 320 -(bt.box.height/2) +bt.box.border
    end

    if soul.y > 320 +(bt.box.height/2) -bt.box.border -sprite:getHeight() then
        soul.y = 320 +(bt.box.height/2) -bt.box.border -sprite:getHeight()
    end


end

function player:death(soul)

    death_count = death_count +1
    if death_count > 30 then
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("fill", 0, 0, 320 *gameScale, 240 *gameScale)
        love.graphics.setColor(255, 255, 255)
    end
    if death_count == 50 then
        soul.sprite = 'assets/sprites/ui/battle/spr_heartbreak.png'
        soul.x = soul.x -2
    end
    if death_count == 90 then
        
    end

end

return player