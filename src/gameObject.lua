local GameObject = {}

function GameObject.new()
    local go = {
        x = 0,
        y = 0,

        init = function(self)end,
        update = function(self, dt)end,
        draw = function(self)end
    }
    return go
end

return GameObject