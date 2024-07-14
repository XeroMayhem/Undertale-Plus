return function()

    local list = 1
    local enemy_list = mod_loaded ..'scripts.battle.enemies.'
    if room == 'Ruins01' or room == 'Ruins02' or room == 'Ruins03' or room == 'RuinsTestMap' then
        list = 4--math.random(1, 4)
    end

    if list == 1 then
        bt.enemy[1] = require(enemy_list .. 'froggit')
        bt.enemy[1].x = 640/2
        bt.ftext = "* Froggit hopped close!"
    elseif list == 2 then
        bt.enemy[1] = require(enemy_list .. 'whimsun')
        bt.enemy[1].x = 640/2
        bt.ftext = "* Whimsun approached meekly!"
    elseif list == 3 then
        bt.enemy[1] = require(enemy_list .. 'froggit')
        bt.enemy[2] = require(enemy_list .. 'whimsun')
        bt.ftext = "* Froggit and Whimsun drew near!"
    elseif list == 4 then
        bt.enemy[1] = require(enemy_list ..'whimsalot')
        bt.enemy[2] = require(enemy_list ..'froggy')
        bt.ftext = '* Whimsalot ambushes you!^* Froggy came too.'
    end

end