local player = {}

function player:update(soul)

    local isMoving = false

    local vx = 0
    local vy = 0
    soul.speed = 2

    if love.keyboard.isDown("right") then
        vx = soul.speed
        isMoving = true
    end
    if love.keyboard.isDown("left") then
        vx = -soul.speed
        isMoving = true
    end
    if love.keyboard.isDown("up") then
        vy = -soul.speed
        isMoving = true
    end
    if love.keyboard.isDown("down") then
        vy = soul.speed
        isMoving = true
    end

    soul.x = soul.x +vx
    soul.y = soul.y +vy

end

return player