local enemy = {}
local sprite_path = mod_loaded.. 'assets/sprites/enemies/'

function enemy:create(name, sprite, pos)
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
        sprite_id = sprite,
        sprite = esprite,
        sprite_data = love.image.newImageData(exsprite),
        pixel_data = {},
        stats = {
            hp = 30,
            maxhp = 30,
            at = 4,
            df = 4,
            xp = 3,
            gold = 2
        }
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
    
            id.pixel_data[w][h] = {col = id.sprite_data:getPixel(w, h), x = w, y = h, a = 1}
            
        end
    end
end

function enemy:draw(id)
    
    if love.filesystem.getInfo(sprite_path.. id.sprite_id).type == 'directory' then
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
                love.graphics.draw(pixel, id.x +data.x, id.y +data.y)
            end
            
        end
    end
    
end

return enemy