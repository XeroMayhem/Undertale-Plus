local menu = {}

function menu:init()
    menu.active = false
    menu.has_cell = true
    input:keypress('z', function()
        if menu.active == true then
            if menu.isMain == true then
                if menu.optionSel == 0 and #inventory.items > 0 then
                    menu.options[1].active = true
                    menu.isMain = false
                elseif menu.optionSel ~= 0 then
                    menu.options[menu.optionSel +1].active = true
                    menu.isMain = false
                end
            elseif menu.options[1].active == true then
                if menu.itemUseOptions == true then
                    if menu.itemUseSel == 0 then
                        menu.options[1].active = false
                        Textbox:create()
                        local pos = 1
                        if menu.boxPos == 1 then
                            pos = 0
                        end
                        Textbox:pageParams(inventory:useItem(menu.itemSel +1), nil, nil, pos)
                    elseif menu.itemUseSel == 1 then
                        menu.options[1].active = false
                        Textbox:create()
                        local pos = 1
                        if menu.boxPos == 1 then
                            pos = 0
                        end
                        if type(inventory.items[menu.itemSel +1].desc) == "string" then
                            Textbox:pageParams(inventory.items[menu.itemSel +1].desc, nil, nil, pos)
                        else
                            inventory.items[menu.itemSel +1].desc(pos)
                        end
                    elseif menu.itemUseSel == 2 then
                        menu.options[1].active = false
                        Textbox:create()
                        local pos = 1
                        if menu.boxPos == 1 then
                            pos = 0
                        end
                        local item = inventory.items[menu.itemSel +1].name
                        local text = ""
                        local chance = math.random(36)
                        if chance < 30 then
                            text = "The ".. item .." was thrown away."
                        elseif chance < 32 then
                            text = "You abandoned the ".. item .."."
                        elseif chance < 34 then
                            text = "You threw the ".. item .." on the ground like the piece of trash it is."
                        elseif chance < 36 then
                            text = "You put the ".. item .." on the ground and gave it a little pat."
                        elseif chance == 36 then
                            text = "You bid a quiet farewell to the ".. item .."."
                        end
                        Textbox:pageParams(text, nil, nil, pos)
                        table.remove(inventory.items, menu.itemSel +1)
                    end
                else
                    menu.itemUseOptions = true
                end
            elseif menu.options[3].active == true then
                menu.options[3].active = false
                love.audio.newSource('assets/sounds/phone_ring.wav', "static"):play()
                menu.cellOptions[menu.cellSel +1].call()
            end
        end
    end)

    input:keypress('x', function()
        if menu.active == true and Textbox.isActive == false then
            if menu.options[menu.optionSel +1].active == true then
                if menu.itemUseOptions == true then
                    menu.itemUseOptions = false
                else
                    menu.options[menu.optionSel +1].active = false
                    menu.isMain = true
                end
            else
                menu:destroy()
            end
        end
    end)

    input:keypress('down', function()
        if menu.active == true then
            if menu.isMain == true then
                menu.optionSel = menu.optionSel + 1
            elseif menu.options[1].active == true then
                menu.itemSel = menu.itemSel + 1
            elseif menu.options[3].active == true then
                menu.cellSel = menu.cellSel + 1
            end
        end
    end)
    input:keypress('up', function()
        if menu.active == true then
            if menu.isMain == true then
                menu.optionSel = menu.optionSel - 1
            elseif menu.options[1].active == true then
                menu.itemSel = menu.itemSel - 1
            elseif menu.options[3].active == true then
                menu.cellSel = menu.cellSel - 1
            end
        end
    end)
    input:keypress('right', function()
        if menu.active == true and menu.options[1].active == true and menu.itemUseOptions == true then
            menu.itemUseSel = menu.itemUseSel + 1
        end
    end)
    input:keypress('left', function()
        if menu.active == true and menu.options[1].active == true and menu.itemUseOptions == true then
            menu.itemUseSel = menu.itemUseSel - 1
        end
    end)
end

function menu:create()
    playerFree = false
    menu.active = true
    menu.boxPos = 0
    menu.options = {{name = "ITEM", active = false}, {name = "STAT", active = false}, {name = "CELL", active = false}}
    menu.optionSel = 0
    menu.canSel = true
    menu.isMain = true
    menu.itemSel = 0
    menu.itemUseOptions = false
    menu.itemUseSel = 0
    menu.cellSel = 0
    menu.cellOptions = cell:getCellList()
end

function menu:draw()

    if menu.isMain == true then
        if menu.has_cell then
            menu.optionSel = math.min(menu.optionSel, 2)
        else
            menu.optionSel = math.min(menu.optionSel, 1)
        end
        menu.optionSel = math.max(menu.optionSel, 0)
    end
    draw_box(camx +(16 *gameScale), camy +((26 +(135 * menu.boxPos)) *gameScale), 71 *gameScale, 55 *gameScale)

    font:setFont("main.ttf", 16)
    draw_box(camx +(16 *gameScale), camy +(84 *gameScale), 71 *gameScale, 74 *gameScale)
    for i = 0, #menu.options -1 do
        local col = {255, 255, 255, 1}
        if menu.isMain == true and i == menu.optionSel then
            sprite = love.graphics.newImage('assets/sprites/player/soul_menu.png')
            love.graphics.draw(sprite, camx +(28 *gameScale), camy +((98 +(18 *i)) *gameScale), nil, 1, 1)
        end
        if i == 0 and #inventory.items == 0 then
            col = {255, 255, 255, 0.5}
        end
        if i ~= 2 or (menu.has_cell == true) then
            font:draw({col, menu.options[i +1].name}, camx +(42 *gameScale), camy +((94 +(i *18))*gameScale))
        end
    end

    if menu.options[1].active == true then

        menu.itemSel = math.min(menu.itemSel, #inventory.items -1)
        menu.itemSel = math.max(menu.itemSel, 0)
        draw_box(camx +(94 *gameScale), camy +(26 *gameScale), 173 *gameScale, 181 *gameScale)

        for i = 0, #inventory.items -1 do
            if i == menu.itemSel and menu.itemUseOptions == false then
                sprite = love.graphics.newImage('assets/sprites/player/soul_menu.png')
                love.graphics.draw(sprite, camx +(104 *gameScale), camy +((44 +(16 *i)) *gameScale), nil, 1, 1)
            end
            font:draw(inventory.items[i +1].name, camx +(116 *gameScale), camy +((40 +(i *16))*gameScale))
        end
        
        menu.itemUseSel = math.min(menu.itemUseSel, 2)
        menu.itemUseSel = math.max(menu.itemUseSel, 0)

        font:draw("USE", camx +(116 *gameScale), camy +(182 *gameScale))
        font:draw("INFO", camx +(164 *gameScale), camy +(182 *gameScale))
        font:draw("DROP", camx +(221 *gameScale), camy +(182 *gameScale))
        for i = 0, 2 do
            local xoffset = 0
            if i == 1 then
                xoffset = 48
            elseif i == 2 then
                xoffset = 105
            end
            if i == menu.itemUseSel and menu.itemUseOptions == true then
                sprite = love.graphics.newImage('assets/sprites/player/soul_menu.png')
                love.graphics.draw(sprite, camx +((104 +xoffset) *gameScale), camy +(186 *gameScale), nil, 1, 1)
            end
        end
    elseif menu.options[2].active == true then
        draw_box(camx +(94 *gameScale), camy +(26 *gameScale), 173 *gameScale, 209 *gameScale)

        font:draw("\"" .. player.name.."\"", camx +(108 *gameScale), camy +(45 *gameScale))

        font:draw("LV " ..player.love, camx +(108 *gameScale), camy +((45 +(16*2)) *gameScale))
        font:draw("HP " ..player.hp .. '/' ..player.hpmax, camx +(108 *gameScale), camy +((45 +(16*3)) *gameScale))

        font:draw("AT " ..(player.at -10) .."("..player.weapon.power..")", camx +(108 *gameScale), camy +((45 +(16*5)) *gameScale))
        font:draw("DF " ..(player.df -10) .."("..player.armor.power..")", camx +(108 *gameScale), camy +((45 +(16*6)) *gameScale))
        font:draw("EXP:"..player.exp, camx +(192 *gameScale), camy +((45 +(16*5)) *gameScale))
        font:draw("NEXT:"..(player.levels[player.love +1].exp - player.exp), camx +(192 *gameScale), camy +((45 +(16*6)) *gameScale))
        
        font:draw("WEAPON:"..player.weapon.name, camx +(108 *gameScale), camy +((45 +(16*8)) *gameScale))
        font:draw("ARMOR:"..player.armor.name, camx +(108 *gameScale), camy +((45 +(16*9)) *gameScale))

        font:draw("GOLD:"..player.gold, camx +(108 *gameScale), camy +((48 +(16*10)) *gameScale))
    elseif menu.options[3].active == true then

        menu.cellSel = math.min(menu.cellSel, #menu.cellOptions -1)
        menu.cellSel = math.max(menu.cellSel, 0)

        draw_box(camx +(94 *gameScale), camy +(26 *gameScale), 173 *gameScale, 135 *gameScale)

        for i = 0, #menu.cellOptions -1 do
            if i == menu.cellSel then
                sprite = love.graphics.newImage('assets/sprites/player/soul_menu.png')
                love.graphics.draw(sprite, camx +(104 *gameScale), camy +((44 +(16 *i)) *gameScale), nil, 1, 1)
            end
            font:draw(menu.cellOptions[i +1].name, camx +(116 *gameScale), camy +((40 +(i *16))*gameScale))
        end
    end

end

function menu:destroy()
    menu.active = false
    playerFree = true
end

return menu