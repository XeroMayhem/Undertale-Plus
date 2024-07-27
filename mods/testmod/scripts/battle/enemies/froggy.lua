local froggy = enemy_scripts:create('Froggy', 'spr_froggit.png', 640/3 *2)
froggy.waves = {'froggy_1'}

function froggy:act(name)

    if name == 'Check' then
        enemy_scripts:act_text(froggy, 'Froggy 3AT 3DF^* A small frog.')
    elseif name == 'Insult' then
        enemy_scripts:act_text(froggy, {"* Froggy didn't understand what you said.", "* But felt happy despite this."})
        froggy.spare = true
    end
    
end

return froggy