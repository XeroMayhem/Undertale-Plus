local enemy = {}
local sprite_path = mod_loaded.. 'assets/sprites/enemies/'
local bullet_sprite_path = mod_loaded.. 'assets/sprites/bullets/'

function enemy:create(name, sprite, pos, hurt_sprite)
    local id = {}
    local esprite = sprite
    local exsprite = sprite
    if love.filesystem.getInfo(sprite_path.. sprite).type == 'file' then
        esprite = love.graphics.newImage(sprite_path.. sprite)
        exsprite = sprite_path.. sprite
    else
        if love.filesystem.getInfo(sprite_path.. sprite ..'/' ..sprite ..'_0.png') then
            esprite = love.graphics.newImage(sprite_path.. sprite  ..'/' ..sprite ..'_0.png')
            exsprite = sprite_path.. sprite  ..'/' ..sprite ..'_0.png'
        elseif love.filesystem.getInfo(sprite ..'_1.png') then
            esprite = love.graphics.newImage(sprite_path.. sprite  ..'/' ..sprite ..'_1.png')
            exsprite = sprite_path.. sprite  ..'/' ..sprite ..'_1.png'
        end
    end
    
    id = {
        name = name,
        pages = 1,
        sprite_id = sprite,
        sprite = esprite,
        hurt_sprite = hurt_sprite,
        sprite_data = love.image.newImageData(exsprite),
        pixel_data = {},
        stats = {
            hp = 30,
            maxhp = 30,
            at = 4,
            df = 4,
            xp = 3,
            gold = 2
        },
        rig_only = false,
        xscale = 1,
        yscale = 1,
        rot = 0,
        acts = {'Check'},
        spare = false,
        been_spared = false,
        wave = -1,
        waves = {},
        waves_random = true,
        bullets = {},
        rig = {}
    }
    id.x = pos -id.sprite:getWidth()/2
    id.y = 246 -id.sprite:getHeight()
    id.death_timer = 0
    
    id.fps = 4
    id.frame = 1
    id.frameTimer = 1

    for w = 0, id.sprite:getWidth() -1 do
        id.pixel_data[w] = {}
        for h = 0, id.sprite:getHeight() -1 do

            id.pixel_data[w][h] = {col = id.sprite_data:getPixel(w, h), x = w, y = h, a = 1}

        end
    end

    function id:attacks()
        local waves = id.waves
        if id.waves_random == true then
            waves = table.shuffle(id.waves)
        end
        local turn = bt.turn
        while turn > #waves do
            turn = turn -#waves
        end
        id.wave = require(mod_loaded ..'scripts/battle/waves/'..waves[turn])
        id.wave.monster = id

    end

    function id:hurt()
        
        sprite_file = mod_loaded.. 'assets/sprites/enemies/'.. id.hurt_sprite ..'.png'
        enemy_scripts:load_sprite(id, sprite_file)

    end

    function id:add_rig(x, y, sprite, fps)
        
        local esprite = sprite
        local exsprite = sprite
        if love.filesystem.getInfo(sprite_path.. sprite).type == 'file' then
            esprite = love.graphics.newImage(sprite_path.. sprite)
            exsprite = sprite_path.. sprite
        else
            if love.filesystem.getInfo(sprite_path.. sprite ..'/' ..sprite ..'_0.png') then
                esprite = love.graphics.newImage(sprite_path.. sprite  ..'/' ..sprite ..'_0.png')
                exsprite = sprite_path.. sprite  ..'/' ..sprite ..'_0.png'
            elseif love.filesystem.getInfo(sprite ..'_1.png') then
                esprite = love.graphics.newImage(sprite_path.. sprite  ..'/' ..sprite ..'_1.png')
                exsprite = sprite_path.. sprite  ..'/' ..sprite ..'_1.png'
            end
        end
        
        local rig = {
            sprite_id = sprite,
            sprite = esprite,
            sprite_data = love.image.newImageData(exsprite),
            pixel_data = {},
            x = x,
            y = y,
            been_spared = false,
            xscale = id.xscale,
            yscale = id.yscale,
            rot = 0,
            xoffset = 0,
            yoffset = 0,
            alpha = 1,
            fps = defaultValue(fps, 0),
            frame = 1,
            frameTimer = 1
        }

        for w = 0, id.sprite:getWidth() -1 do
            id.pixel_data[w] = {}
            for h = 0, id.sprite:getHeight() -1 do
    
                id.pixel_data[w][h] = {col = id.sprite_data:getPixel(w, h), x = w, y = h, a = 1}
    
            end
        end

        function rig:draw()

            if love.filesystem.getInfo(sprite_path.. rig.sprite_id).type == 'directory' and id.been_spared == false then
                rig.frameTimer = rig.frameTimer+1
                if rig.frameTimer > 60/rig.fps then
                    rig.frame = rig.frame+1
                    rig.frameTimer = 1
                end
                local sprite_file = sprite_path.. rig.sprite_id  ..'/' ..rig.sprite_id ..'_' ..rig.frame ..'.png'
                if not love.filesystem.getInfo(sprite_file) then
                    rig.frame = 1
                    if love.filesystem.getInfo(sprite_path.. rig.sprite_id  ..'/' ..rig.sprite_id ..'_0.png') then
                        rig.frame = 0
                    end
                    sprite_file = sprite_path.. rig.sprite_id  ..'/' ..rig.sprite_id ..'_' ..rig.frame ..'.png'
                end
                rig.sprite = love.graphics.newImage(sprite_file)
                rig.sprite_data = love.image.newImageData(sprite_file)
                if id.been_spared == false then
                    rig.alpha = 1
                else
                    rig.alpha = 0.2
                end
            end
        
            love.graphics.setColor(1, 1, 1, rig.alpha)
            love.graphics.draw(rig.sprite, id.x +rig.x, id.y +rig.y, math.rad(rig.rot), rig.xscale, rig.yscale, rig.xoffset, rig.yoffset)
            love.graphics.setColor(1, 1, 1, 1)

        end

        table.insert(id.rig, rig)
        return rig

    end

    function id:draw()

        for r, rig in pairs(id.rig) do
            rig:draw()
        end

        if id.rig_only == false then

            if love.filesystem.getInfo(sprite_path.. id.sprite_id).type == 'directory' and id.been_spared == false then
                id.frameTimer = id.frameTimer+1
                if id.frameTimer > 60/id.fps then
                    id.frame = id.frame+1
                    id.frameTimer = 1
                end
                local sprite_file = sprite_path.. id.sprite_id  ..'/' ..id.sprite_id ..'_' ..id.frame ..'.png'
                if not love.filesystem.getInfo(sprite_file) then
                    id.frame = 1
                    if love.filesystem.getInfo(sprite_path.. id.sprite_id  ..'/' ..id.sprite_id ..'_0.png') then
                        id.frame = 0
                    end
                    sprite_file = sprite_path.. id.sprite_id  ..'/' ..id.sprite_id ..'_' ..id.frame ..'.png'
                end
                enemy:load_sprite(id, sprite_file)
            end
        
            local pixel = love.graphics.newImage('assets/sprites/misc/spr_pixel.png')
            for w = 0, id.sprite:getWidth() -1 do
                for h = 0, id.sprite:getHeight() -1 do
                    
                    local data = id.pixel_data[w][h]
                    if data.col == 1 then
                        love.graphics.setColor(1, 1, 1, data.a)
                        love.graphics.draw(pixel, id.x +(data.x *id.xscale), id.y +(data.y *id.yscale), math.rad(id.rot), id.xscale, id.yscale)
                    end
                    
                end
            end
            love.graphics.setColor(1, 1, 1, 1)

        end

    end

    function id:update(dt)
        return nil
    end

    return id

end

function enemy:stats(hp, at, df, xp, gold)
    local id = {}
    id = {
        hp = hp,
        maxhp = hp,
        at = at,
        df = df,
        xp = xp,
        gold = gold
    }
    return id
end

function enemy:load_sprite(id, filename)
    id.sprite = love.graphics.newImage(filename)
    id.sprite_data = love.image.newImageData(filename)
    id.pixel_data = {}

    for w = 0, id.sprite:getWidth() -1 do
        id.pixel_data[w] = {}
        for h = 0, id.sprite:getHeight() -1 do
            
            if id.been_spared == false then
                id.pixel_data[w][h] = {col = id.sprite_data:getPixel(w, h), x = w, y = h, a = 1}
            else
                id.pixel_data[w][h] = {col = id.sprite_data:getPixel(w, h), x = w, y = h, a = 0.2}
            end
            
        end
    end
end

function enemy:act_text(id, text)

    if type(text) == 'string' then
        text = {text}
    end
    for i = 1, #text +1 do
        if i == #text +1 then
            bt:start_waves()
        elseif bt.main.act.page == i then
            bt:displayMsg(text[i])
            return nil
        end
    end

    id.pages = id.pages +1

end

--Bullets
function enemy:create_bullet(x, y, sprite, colour, damage)

    colour = defaultValue(colour, 'white')
    damage = defaultValue(damage, 1)

    local id = {}
    local esprite = sprite
    local exsprite = sprite
    if love.filesystem.getInfo(bullet_sprite_path.. sprite).type == 'file' then
        esprite = love.graphics.newImage(bullet_sprite_path.. sprite)
        exsprite = bullet_sprite_path.. sprite
    else
        if love.filesystem.getInfo(bullet_sprite_path.. sprite ..'/' ..sprite ..'_0.png') then
            esprite = love.graphics.newImage(bullet_sprite_path.. sprite  ..'/' ..sprite ..'_0.png')
            exsprite = bullet_sprite_path.. sprite  ..'/' ..sprite ..'_0.png'
        elseif love.filesystem.getInfo(sprite ..'_1.png') then
            esprite = love.graphics.newImage(bullet_sprite_path.. sprite  ..'/' ..sprite ..'_1.png')
            exsprite = bullet_sprite_path.. sprite  ..'/' ..sprite ..'_1.png'
        end
    end
    
    id = {
        sprite_id = sprite,
        sprite = esprite,
        sprite_data = love.image.newImageData(exsprite),
        dmg = damage,
        colour = colour,
        hit = false
    }
    id.x = x
    id.y = y
    
    id.fps = 4
    id.frame = 1
    id.frameTimer = 1
    id.scale = gameScale

    function id:update(dt)
        --Called every frame
    end

    function id:draw()
        if love.filesystem.getInfo(bullet_sprite_path.. id.sprite_id).type == 'directory' and id.been_spared == false then
            id.frameTimer = id.frameTimer+1
            if id.frameTimer > 60/id.fps then
                id.frame = id.frame+1
                id.frameTimer = 1
            end
            local sprite_file = bullet_sprite_path.. id.sprite_id  ..'/' ..id.sprite_id ..'_' ..id.frame ..'.png'
            if not love.filesystem.getInfo(sprite_file) then
                id.frame = 1
                if love.filesystem.getInfo(bullet_sprite_path.. id.sprite_id  ..'/' ..id.sprite_id ..'_0.png') then
                    id.frame = 0
                end
                sprite_file = bullet_sprite_path.. id.sprite_id  ..'/' ..id.sprite_id ..'_' ..id.frame ..'.png'
            end
            id.sprite = love.graphics.newImage(sprite_file)
        end

        love.graphics.setColor(enemy:get_bullet_colour(id.colour))
        love.graphics.draw(id.sprite, id.x, id.y, 0, id.scale, id.scale)
        love.graphics.setColor(1, 1, 1, 1)
    end

    function id:check_hit()
        if id.hit == false then
            local soul_sprite = love.graphics.newImage(bt.soul.sprite)
            for w = 0, id.sprite:getWidth() -1 do
                for h = 0, id.sprite:getHeight() -1 do

                    local r, g, b, a = id.sprite_data:getPixel(w, h)
                    local x = id.x +w
                    local y = id.y +h
                    if a == 1 then
                        if x >= bt.soul.x and x <= bt.soul.x +soul_sprite:getWidth() and y >= bt.soul.y and y <= bt.soul.y +soul_sprite:getHeight() then
                            if id.colour == 'white' then
                                player.hp = player.hp -id.dmg
                            elseif id.colour == 'green' then
                                player.hp = player.hp +id.dmg
                            elseif id.colour == 'blue' then
                                player.hp = player.hp -id.dmg
                            end
                            id.hit = true
                            return nil
                        end
                    end
                    
                end
            end
        end
    end

    return id

end

function enemy:get_bullet_colour(colour)
    if colour == 'white' then
        return {1, 1, 1, 1}
    elseif colour == 'green' then
        return {0, 1, 0, 1}
    elseif colour == 'blue' then
        return {0, 0.5, 1, 1}
    end
end

return enemy