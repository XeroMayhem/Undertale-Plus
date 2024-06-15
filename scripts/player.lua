local player = {}

function player:load()
    player.x = 160
    player.y = 120
    if gameMap.layers["Markers"] then
        for i, obj in pairs(gameMap.layers["Markers"].objects) do
            if obj.name == "spawn" then
                player.x = obj.x *2
                player.y = obj.y *2
            end
        end
    end
    player.depth = -player.y
    player.collider = world:newRectangleCollider(player.x, player.y, 19 *gameScale, 29/2 *gameScale)
    player.collider:setFixedRotation(true)
    player.collider:setCollisionClass('player')
    player.speed = 150
    player.spriteSheet = love.graphics.newImage('assets/sprites/player/Walk-Sheet.png')
    player.grid = anim8.newGrid(20, 30, 80, 93)

    player.animations = {}
    player.animations.down = anim8.newAnimation(player.grid('1-4', 1), 0.25)
    player.animations.left = anim8.newAnimation(player.grid('1-2', 2), 0.25)
    player.animations.right = anim8.newAnimation(player.grid('3-4', 2), 0.25)
    player.animations.up = anim8.newAnimation(player.grid('1-4', 3), 0.25)

    player.anim = player.animations.down
    table.insert(overworld.objects, player)

end

function player:update(dt)
    local isMoving = false

    local vx = 0
    local vy = 0

    if love.keyboard.isDown("right") then
        vx = player.speed
        player.anim = player.animations.right
        isMoving = true
    end
    if love.keyboard.isDown("left") then
        vx = -player.speed
        player.anim = player.animations.left
        isMoving = true
    end
    if love.keyboard.isDown("up") then
        vy = -player.speed
        player.anim = player.animations.up
        isMoving = true
    end
    if love.keyboard.isDown("down") then
        vy = vy +player.speed
        player.anim = player.animations.down
        isMoving = true
    end

    player.collider:setLinearVelocity(vx, vy)

    if isMoving == false then
       player.anim:gotoFrame(2)
    end
    
    player.x = player.collider:getX() -(10 * gameScale)
    player.y = player.collider:getY() -(15 * gameScale) -(29/4 *gameScale)
    player.depth = -player.collider:getY()
    player.anim:update(dt)

end

function player:draw()
    player.anim:draw(player.spriteSheet, player.x, player.y, nil, gameScale)
end

return player