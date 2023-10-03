local GameObject = require("src/entities/gameObject")
local Ball = {}

local max = math.max
local min = math.min
local sqrt = math.sqrt
local atan2 = math.atan2
local cos = math.cos
local sin = math.sin
local pi = math.pi

local function len(x, y)
    return sqrt(x*x + y*y)
end

local function dist(x1, y1, x2, y2)
    return sqrt((x2-x1)*(x2-x1) + (y2-y1)*(y2-y1))
end

local function getBallPlayerOverlap(ball, player)
    local nearX = max(player.x, min(ball.x, (player.x + player.width)))
    local nearY = max(player.y, min(ball.y, (player.y + player.length)))

    local rayX = nearX - ball.x
    local rayY = nearY - ball.y

    local overlap = ball.radius - len(rayX, rayY)
    if overlap < 0 then overlap = 0 end

    return overlap
end

local function solveCollision(ball, player, overlap)
    local d = dist(player.x, player.y, ball.x, ball.y)

    ball.x = ball.x - overlap * (player.x - ball.x) / d
    ball.y = ball.y - overlap * (player.y - ball.y) / d
end

local function getAngleBetween(ball, player)
    return atan2(ball.y - (player.y + player.length/2), ball.x - player.x) * 180 / pi
end

function Ball.new(x, y, radius, world)
    local ball = GameObject.new()
    ball.speed = 150
    ball.dx = -1
    ball.dy = 1

    ball.init = function(self)
        self.x = x or self.x
        self.y = y or self.y
        self.radius = radius or self.radius
    end

    ball.update = function(self, dt)
        if dt > 0.1 then return end

        self.x = self.x + self.dx * self.speed * dt
        self.y = self.y + self.dy * self.speed * dt

        if self.x + 5 > Screen.nativeWidth or self.x - 5 < 0 then 
            self.x = Screen.nativeWidth/2
            self.y = Screen.nativeHeight/2
            self.speed = 150
        end

        if self.y + 5 > Screen.nativeHeight then
            self.y = Screen.nativeHeight - 5
            self.dy = -self.dy
        elseif self.y - 5 < 0 then
            self.y = 5
            self.dy = -self.dy
        end

        local playerOverlap = getBallPlayerOverlap(self, world.player)
        local iaOverlap = getBallPlayerOverlap(self, world.ia)

        if playerOverlap > 0 then
            solveCollision(self, world.player, playerOverlap)
            self.dx = -self.dx
            self.speed = self.speed + 25

            local ang = getAngleBetween(self, world.player)
            local c = cos(ang)
            local s = sin(ang)
            local l = len(c, s)

            self.dy = -s / l
        end

        if iaOverlap > 0 then
            solveCollision(self, world.ia, iaOverlap)
            self.dx = -self.dx

            local ang = getAngleBetween(self, world.player)
            local c = cos(ang)
            local s = sin(ang)
            local l = len(c, s)

            self.dy = -s / l
        end
    end

    ball.draw = function(self)
        love.graphics.circle("fill", self.x, self.y, self.radius)
    end

    ball:init()
    return ball
end

return Ball