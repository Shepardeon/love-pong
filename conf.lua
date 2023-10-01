local sVersion = "1.0a"

function love.conf(t)
    t.window.title = "Pöng v." .. sVersion
    t.window.width = 1280
    t.window.height = 720
    t.window.resizable = true
end