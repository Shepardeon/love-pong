local GameObject = require("src/entities/gameObject")
local Paddle = {}

local paddleWidth = 10

function Paddle.new(x, y, length, controller, world)
    local paddle = GameObject.new()

    paddle.init = function(self)
        self.x = x or self.x
        self.y = y or self.y
        self.length = length or self.length
        self.width  = paddleWidth
        self.controller = controller or self.controller
    end

    paddle.update = function(self, dt)
        if self.controller and world then
            self.controller.update(self, world, dt)
        end
    end

    paddle.draw = function(self)
        love.graphics.rectangle("fill", self.x, self.y, self.width, self.length)
    end

    paddle:init()
    return paddle
end

return Paddle