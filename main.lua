if arg[#arg] == "vsc_debug" then require("lldebugger").start() end

-- Global modules
Screen = require("src/screen")

local Ball = require("src/entities/ball")
local Paddle = require("src/entities/paddle")

-- Global tables
local gameObjects = {}
local world = {}

function love.load()
    love.graphics.setDefaultFilter('nearest')

    local ballRadius = 5
    local ball = Ball.new(
        Screen.nativeWidth/2 - ballRadius/2,
        Screen.nativeHeight/2 - ballRadius/2,
        ballRadius,
        world
    )
    table.insert(gameObjects, ball)
    world.ball = ball

    local player = Paddle.new(
        10,
        Screen.nativeHeight/2,
        60,
        require("src/controllers/playerController"),
        world
    )
    table.insert(gameObjects, player)
    world.player = player

    local ia = Paddle.new(
        Screen.nativeWidth - 20,
        Screen.nativeHeight/2,
        60,
        require("src/controllers/playerController"),
        world
    )
    table.insert(gameObjects, ia)
    world.ia = ia

    world.scores = {
        p1 = 0,
        p2 = 0
    }
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

    love.graphics.print(world.scores.p1 .. "/" .. world.scores.p2, Screen.screenWidth/2 - 50, 10, 0, 5)
end