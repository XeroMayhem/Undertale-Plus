return function(cutscene)
    cutscene:play_sound(mod_loaded ..'assets/sounds/snd_hero.wav')
    cutscene:wait(60)
    cutscene:play_sound(mod_loaded ..'assets/sounds/squeak.wav')
    cutscene:wait(20)
end