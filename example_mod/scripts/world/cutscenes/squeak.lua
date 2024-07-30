return function(cutscene)
    cutscene:play_sound(mod_loaded ..'assets/sounds/snd_hero.wav')
    cutscene:wait(60)
    cutscene:text("* Hi there!", nil, nil, 1)
    cutscene:text("* How's your day.")
    cutscene:wait(120)
    cutscene:text("* Cool.")
end