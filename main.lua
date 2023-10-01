if arg[#arg] == "vsc_debug" then require("lldebugger").start() end

-- Global modules
Screen = require("src/screen")

local Ball = require("src/ball")
local Paddle = require("src/paddle")

-- Global tables
local gameObjects = {}

function love.load()
    local ballRadius = 10
    table.insert(gameObjects, Ball.new(
        Screen.nativeWidth/2 - ballRadius/2,
        Screen.nativeHeight/2 - ballRadius/2,
        ballRadius
    ))

    table.insert(gameObjects, Paddle.new(
        10,
        Screen.nativeHeight/2,
        60
    ))
end

local FPS = 0
local fpsCounter = 0
local fpsTimer = 0
function love.update(dt)
    for _, object in pairs(gameObjects) do
        object:update(dt)
    end

    fpsTimer = fpsTimer + dt
    fpsCounter = fpsCounter + 1

    if fpsTimer >= 1 then
        FPS = fpsCounter
        fpsTimer = 0
        fpsCounter = 0
    end
end

function love.draw()
    love.graphics.push()
    love.graphics.scale(Screen.xScaleFactor, Screen.yScaleFactor)

    for _, object in pairs(gameObjects) do
        object:draw()
    end

    love.graphics.pop()

    love.graphics.print("FPS: "..FPS)
end