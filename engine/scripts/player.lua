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
    player.width = 19 *gameScale
    player.height = 29/2 *gameScale
    player.collider = world:newRectangleCollider(player.x, player.y, player.width, player.height)
    player.collider:setFixedRotation(true)
    player.collider:setCollisionClass('player')
    player.walkspeed = 2
    player.fastspeed = 4
    player.speed = player.walkspeed
    player.spriteSheet = love.graphics.newImage('assets/sprites/player/Walk-Sheet.png')
    player.grid = anim8.newGrid(20, 30, 80, 93)

    player.animations = {}
    player.animations.down = anim8.newAnimation(player.grid('1-4', 1), 0.25)
    player.animations.left = anim8.newAnimation(player.grid('1-2', 2), 0.25)
    player.animations.left = anim8.newAnimation(player.grid('1-2', 2), 0.25)
    player.animations.right = anim8.newAnimation(player.grid('3-4', 2), 0.25)
    player.animations.up = anim8.newAnimation(player.grid('1-4', 3), 0.25)

    player.anim = player.animations.down

    player.name = "Xero"
    player.hp = 1
    player.hpmax = 20--32
    player.weapon = ""
    player.armour = ""

    table.insert(overworld.objects, player)

end

function player:update(dt)
    local isMoving = false

    local vx = 0
    local vy = 0
    if love.keyboard.isDown("lshift") or love.keyboard.isDown("rshift") then
       player.speed = player.fastspeed
    else
        player.speed = player.walkspeed
    end

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
        vy = player.speed
        player.anim = player.animations.down
        isMoving = true
    end

    if #world:queryRectangleArea(player.collider:getX() +(player.width/2 *(vx/player.speed)), player.collider:getY() -(player.height/2), vx, player.height, {'wall', 'instance'}) == 0 then
        player.collider:setX(player.collider:getX() +vx)
    end

    if #world:queryRectangleArea(player.collider:getX() -(player.width/2), player.collider:getY() +(player.height/2 *(vy/player.speed)), player.width, vy, {'wall', 'instance'}) == 0 then
        player.collider:setY(player.collider:getY() +vy)
    end

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

function player:setPosition(x, y)
    player.collider:setX(x)
    player.collider:setY(y)
    player.x = player.collider:getX() -(10 * gameScale)
    player.y = player.collider:getY() -(15 * gameScale) -(29/4 *gameScale)
    player.depth = -player.collider:getY()
end

function player:checkDirect(class)
    if class == nil then
        class = {}
    end
    local x = player.x
    local y = player.y +player.height
    local width = player.width
    local height = player.height
    local colliders = {}

    if player.anim == player.animations.right then
        colliders = world:queryRectangleArea(x +player.width, y, width, height, class)

    elseif player.anim == player.animations.left then
        colliders = world:queryRectangleArea(x -player.width, y, width, height, class)

    elseif player.anim == player.animations.up then
        colliders = world:queryRectangleArea(x, y -player.height, width, height, class)

    elseif player.anim == player.animations.down then
        colliders =  world:queryRectangleArea(x, y +player.height, width, height, class)
    end

    return colliders
end

return player