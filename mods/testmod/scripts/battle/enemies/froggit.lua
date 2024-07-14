local froggit = enemy_scripts:create("Froggit", 'spr_froggit.png', 640/3)
froggit.acts = {'Check', 'Bark', 'Croak', 'Insult'}
froggit.waves = {'basic_1', 'basic_2', 'basic_1', 'basic_2', 'basic_1', 'basic_2', 'basic_1', 'basic_2', 'basic_1', 'basic_2'}

function froggit:act(name)

    local act_text = function(text)
        enemy_scripts:act_text(froggit, text)
    end

    if name == 'Check' then
        act_text('* A Froggit dumbass')
    elseif name == 'Bark' then
        act_text({"* Froggit didn't understand what you were doing.", "* It was scared anyway."})
    elseif name == 'Croak' then
        act_text({"* You speak the native tounge of Froggit.", "* It seems insulted by whatever you said."})
    elseif name == 'Insult' then
        act_text({"* Froggit didn't understand what you said.", "* But felt happy despite this."})
        froggit.spare = true
    end
end

return froggit