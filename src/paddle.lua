local GameObject = require("src/gameObject")
local Paddle = {}

local paddleWidth = 10

function Paddle.new(x, y, length)
    local paddle = GameObject.new()
    paddle.length = 0 or length

    paddle.init = function(self)
        self.x = x or self.x
        self.y = y or self.y
        self.length = length or self.length
    end

    paddle.update = function(self, dt)
        local mousePos = love.mouse.getY() / Screen.yScaleFactor

        if mousePos + self.length/2 < Screen.nativeHeight and mousePos - self.length/2 > 0 then
            self.y = mousePos
        end
    end

    paddle.draw = function(self)
        love.graphics.rectangle("fill", self.x, self.y - self.length/2, paddleWidth, self.length)
    end

    paddle:init()
    return paddle
end

return Paddle