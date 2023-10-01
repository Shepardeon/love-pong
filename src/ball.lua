local GameObject = require("src/gameObject")
local Ball = {}

local r = 1
local g = 1
local b = 1

function Ball.new(x, y, radius)
    local ball = GameObject.new()
    ball.radius = radius or 0
    ball.dx = -150
    ball.dy = 200

    ball.init = function(self)
        self.x = x or self.x
        self.y = y or self.y
        self.radius = radius or self.radius
    end

    ball.update = function(self, dt)
        if dt > 0.1 then return end

        self.x = self.x + self.dx * dt
        self.y = self.y + self.dy * dt

        if self.x + 5 > Screen.nativeWidth or self.x - 5 < 0 then 
            self.dx = -self.dx
            r = math.random()
            g = math.random()
            b = math.random()
        end
        if self.y + 5 > Screen.nativeHeight or self.y - 5 < 0 then 
            self.dy = -self.dy
            r = math.random()
            g = math.random()
            b = math.random()
        end
    end

    ball.draw = function(self)
        love.graphics.setColor(r, g, b)
        love.graphics.circle("fill", self.x, self.y, self.radius)
        love.graphics.setColor(1, 1, 1)
    end

    ball:init()
    return ball
end

return Ball