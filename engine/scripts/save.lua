local save = {}

function save:create(x, y)

    local SAVE = instance:create(x, y, 'assets/sprites/misc/save.png', nil, 20, 10, 0, -5)

    return SAVE
end
return save