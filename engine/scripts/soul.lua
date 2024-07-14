local player = {}

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

return player