
local inst = {}

function inst:create(x, y, sprite, depth, maskwidth, maskheight, xoffset, yoffset, name)

    local Object = {}
    
    if name == nil then
        Object.name = "nil"
    else
        Object.name = name
    end

    Object.depth = depth
    Object.sprite = love.graphics.newImage(sprite)
    
    Object.collider = world:newRectangleCollider(x +xoffset, y +yoffset, maskwidth *gameScale, maskheight *gameScale)
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
        map_sprite:draw(Object.x, Object.y, Object.sprite)
    end

    --function Object:destroy()
    --    Object.collider:destroy()
    --end
    
    return Object

end

return inst