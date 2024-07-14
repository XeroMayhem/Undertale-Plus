local froggy = enemy_scripts:create('Froggy', 'spr_froggit.png', 640/3 *2)
froggy.waves = {'froggy_1'}

function froggy:act(name)

    if name == 'Check' then
        enemy_scripts:act_text(froggy, 'Froggy 3AT 3DF^* A small frog.')
    end
    
end

return froggy