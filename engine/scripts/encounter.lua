return function (x, y, soul)

    local encounter = {
        x = x,
        y = y,
        draw = false,
        timer = localTimer(),
        alpha = 1
    }

    local con = 0

    function encounter:update(dt)

        bgMusic:stop()
        --region Flicker Function
        local flicker = {}
        flicker[1] = function ()
            encounter.draw = not encounter.draw
            if con == 2 then
                encounter.draw = true
            end
        end
        for f = 2, 4 do
                
            flicker[f] = function ()
                encounter.draw = not encounter.draw
                if con == 2 then
                    encounter.draw = true
                else
                    encounter.timer.makeTimer(7, flicker[f -1])
                end
            end
        end
        --endregion

        if con == 0 then
            encounter.timer.makeTimer(7, flicker[#flicker])
            encounter.timer.makeTimer(20, function ()
                con = con +1
            end)
            con = con +1
        end

        if con == 2 then
            encounter.alpha = -0.125
            if encounter.x == camx +40 and encounter.y == camy +446 then
                encounter.timer.makeTimer(15, function ()
                    isEncounter = false
                    start_battle()
                end)
            else
                moveToPoint(encounter, 8, camx +40, camy +446)
            end
        end

        encounter.timer.updateTimers()

        if con < 5 then

            love.graphics.setColor(0, 0, 0, 1)
            love.graphics.rectangle("fill", camx, camy, 320 *gameScale, 240 *gameScale);

            love.graphics.setColor(1, 1, 1, encounter.alpha)
            player:draw()

            love.graphics.setColor(1, 1, 1, 1)

            if encounter.draw == true then
                love.graphics.draw(love.graphics.newImage(soul), encounter.x, encounter.y)
            end
        end

    end

    return encounter

end