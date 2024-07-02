local menu = {}

function menu:init()
    menu.isActive = false
end

function menu:create()
    playerFree = false
    menu.isActive = true
    menu.hasSaved = false
    menu.option = 1
    menu.timer = 0
    player.hp = player.hpmax
    Textbox:create()
    Textbox:pageParams("* (The shadow of the Ruins looms above, filling you with determination.)")
    Textbox:pageParams("* (HP fully restored.)")
end

function menu:draw()

    playerFree = false

    if not Textbox.isActive then
        if menu.timer == 0 then
            Plus.keyPress = ''
            menu.timer = 1
        end

        if Plus.keyPress == 'right' then
            menu.option = menu.option +1
        end

        if Plus.keyPress == 'left' then
            menu.option = menu.option -1
        end

        if Plus.keyPress == 'z' then
            if menu.hasSaved then
                menu.isActive = false
                playerFree = true
            else
                if menu.option == 1 then
                    determination:save()
                    menu.hasSaved = true
                elseif menu.option == 2 then
                    menu.isActive = false
                    playerFree = true
                end
            end
        end

        love.graphics.setColor(255, 255, 255, 1)
        draw_box(camx +108, camy +118, 424, 174)

        font:setFont('main.ttf', 16)
        if menu.hasSaved then
            love.graphics.setColor(255, 255, 0, 1)
            font:draw("File Saved.", camx +170, camy +248)
        else
            if menu.option == 1 then
                sprite = love.graphics.newImage('assets/sprites/player/soul_menu.png')
                love.graphics.draw(sprite, camx +142, camy +254)
            end
            font:draw("Save", camx +170, camy +248)

            if menu.option == 2 then
                sprite = love.graphics.newImage('assets/sprites/player/soul_menu.png')
                love.graphics.draw(sprite, camx +322, camy +254)
            end
            font:draw("Return", camx +350, camy +248)
        end
        
        local json = require 'engine.libraries.json'
        local save_data = json.decode(love.filesystem.read("saves/" ..Plus.loaded_mod ..".json"))

        font:draw(save_data.name, camx +140, camy +146)
        font:draw_centred("LV " ..save_data.love, camx +320, camy +146)

        local minutes = math.floor(save_data.time / 1800)
        local seconds = math.floor(((save_data.time / 1800) - minutes) * 60)
        if seconds == 60 then
            seconds = 0
        end
        local time = minutes ..':'.. seconds
        if seconds < 10  then
            time = minutes ..':0'.. seconds
        end
        font:draw(time, camx +500-love.graphics.getFont():getWidth(time), camy +146)

        local room_name = require (mod_loaded ..'scripts/world/rooms')
        font:draw(room_name:getName(save_data.room), camx +140, camy +182)

        love.graphics.setColor(255, 255, 255, 1)
    end
end

return menu