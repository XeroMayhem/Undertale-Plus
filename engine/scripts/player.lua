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
    player.width = (19) *gameScale
    player.height = (38)/2 *gameScale
    player.collider = world:newRectangleCollider(player.x, player.y, player.width, player.height)
    player.collider:setFixedRotation(true)
    player.collider:setCollisionClass('player')
    player.walkspeed = 2
    player.fastspeed = 4
    player.speed = player.walkspeed

    player.animations = {}
    player.animations.down = 'assets/sprites/player/walk/down'
    player.animations.left = 'assets/sprites/player/walk/left'
    player.animations.right = 'assets/sprites/player/walk/right'
    player.animations.up = 'assets/sprites/player/walk/up'

    player.encounter_start = 1000
    player.encounter_end = 20
    player.encounter_chance = player.encounter_start

    player.fps = 4
    player.frame = 1
    player.frameTimer = 1
    player.anim = player.animations.down
    if love.filesystem.getInfo(player.anim, 'file') then
        player.sprite = love.graphics.newImage(player.anim)
    else 
        if love.filesystem.getInfo(player.anim ..'_0.png') then
            player.frame = 0
        end
    end
    player.sprite = player.anim
    if type(player.anim) == 'string' then
        player.frameTimer = player.frameTimer+1
        if player.frameTimer > 60/player.fps then
            player.frame = player.frame+1
            player.frameTimer = 1
        end
        local sprite_file = player.anim ..'_'..player.frame ..'.png'
        if not love.filesystem.getInfo(sprite_file) then
            player.frame = 1
            if love.filesystem.getInfo(player.anim ..'_0.png') then
                player.frame = 0
            end
            sprite_file = player.anim ..'_'..player.frame ..'.png'
        end
        player.sprite = love.graphics.newImage(sprite_file)
    end

    player.name = charname
    player.hp = 20
    player.hpmax = 20
    player.at = 210
    player.df = 10
    player.weapon = nil
    inventory:setWeapon(mod_data.start_weapon)
    player.armor = nil
    inventory:setArmor(mod_data.start_armor)
    player.love = 1
    player.gold = 0
    player.exp = 0
    player.soul_cursour = {
        x = player.x,
        y = player.y
    }

    player.levels = {}
    local add_levels = function (hp, at, df, exp)
        table.insert(player.levels, {hp = hp, at = at, df = df, exp = exp})
    end
    add_levels(20, 0, 0, 0)
    add_levels(24, 2, 0, 10)
    add_levels(28, 4, 0, 30)
    add_levels(32, 6, 0, 70)
    add_levels(36, 8, 1, 120)

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
       player.frame = 1
        local sprite_file = player.anim ..'_'..player.frame ..'.png'
       sprite_file = player.anim ..'_'..player.frame ..'.png'
        player.sprite = love.graphics.newImage(sprite_file)
    else
        player.sprite = player.anim
        if type(player.anim) == 'string' then
            player.frameTimer = player.frameTimer+1
            if player.frameTimer > 60/player.fps then
                player.frame = player.frame+1
                player.frameTimer = 1
            end
            local sprite_file = player.anim ..'_'..player.frame ..'.png'
            if not love.filesystem.getInfo(sprite_file) then
                player.frame = 1
                if love.filesystem.getInfo(player.anim ..'_0.png') then
                    player.frame = 0
                end
                sprite_file = player.anim ..'_'..player.frame ..'.png'
            end
            player.sprite = love.graphics.newImage(sprite_file)
        end

        if can_encounter and Plus.state ~= 'battle' then
            
            if math.random(player.encounter_chance) == 1 then
                random_encounter()
                player.encounter_chance = player.encounter_start
			else
                if area_data.population - area_killed[area] > 0 then
                    local populationfactor = area_data.population/(area_data.population -area_killed[area])--(area_data.population -area_killed[area])/area_data.population
                    if populationfactor > 8 then
                        populationfactor = 8
                    end
                    player.encounter_chance = player.encounter_chance -populationfactor
                else
                    player.encounter_chance = player.encounter_chance -1
                end
				player.encounter_chance = math.clamp(player.encounter_chance, player.encounter_end, player.encounter_start)
            end
		end
    end

    player.x = player.collider:getX()
    player.y = player.collider:getY()
    player.depth = -player.collider:getY()

    
    player.soul_cursour = {
        x = player.x -(player.sprite:getWidth()/2),
        y = player.y -(player.sprite:getHeight() *0.75)
    }

end

function player:draw()

    love.graphics.draw(player.sprite, player.x, player.y, nil, gameScale, gameScale, player.sprite:getWidth()/2, player.sprite:getHeight() *0.75)
    --love.graphics.draw( drawable, x, y, r, sx, sy, ox, oy, kx, ky )
end

function player:setSprite(sprite)
    player.frame = 1
    player.frameTimer = 1
    player.anim = sprite
    if love.filesystem.getInfo(player.anim, 'file') then
        player.sprite = love.graphics.newImage(player.anim)
    else 
        if love.filesystem.getInfo(player.anim ..'_0.png') then
            player.frame = 0
        end
    end
end

function player:setPosition(x, y)
    player.collider:setX(x)
    player.collider:setY(y)
    player.x = player.collider:getX()
    player.y = player.collider:getY()
    player.depth = -player.collider:getY()
end

function player:checkLiteral(class)
    class = defaultValue(class, {})
    local colliders = world:queryRectangleArea(player.collider:getX() -player.width/2, player.collider:getY() -(player.height/2), player.width, player.height, class)

    return colliders
end

function player:checkDirect(class)
    class = defaultValue(class, {})
    
    local x = player.x -player.width/2
    local y = player.y -player.height/2
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