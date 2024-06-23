
local inst = {}

function inst:create(x, y, sprite, depth, maskwidth, maskheight, xoffset, yoffset, name)

    local Object = {}
    
    if name == nil then
        Object.name = "nil"
    else
        Object.name = name
    end

    Object.depth = depth
    Object.fps = 4
    Object.frame = 1
    Object.frameTimer = 1
    if love.filesystem.getInfo(sprite, 'file') then
        Object.sprite = love.graphics.newImage(sprite)
    else
        Object.sprite = sprite
    end
    Object.collider = world:newRectangleCollider(x, y, maskwidth *gameScale, maskheight *gameScale)
    Object.collider:setCollisionClass('instance')
    Object.collider:setType('static')
    
    Object.x = Object.collider:getX()/gameScale +(xoffset)
    Object.y = Object.collider:getY()/gameScale +(yoffset)
    
    if depth == nil then
        Object.depth = -Object.collider:getY()
    end
    
    function Object:init()
        table.insert(overworld.objects, Object)
    end
    
    function Object:draw()
        local tsprite = Object.sprite
        if type(Object.sprite) == 'string' then
            Object.frameTimer = Object.frameTimer+1
            if Object.frameTimer > 60/Object.fps then
                Object.frame = Object.frame+1
                Object.frameTimer = 1
            end
            local sprite_file = Object.sprite ..'_'..Object.frame ..'.png'
            if not love.filesystem.getInfo(sprite_file) then
                Object.frame = 1
                sprite_file = Object.sprite ..'_'..Object.frame ..'.png'
            end
            tsprite = love.graphics.newImage(sprite_file)
        end 
        map_sprite:draw(Object.x, Object.y, tsprite, Object.frame)
    end

    --function Object:destroy()
    --    Object.collider:destroy()
    --end
    
    return Object

end

return inst