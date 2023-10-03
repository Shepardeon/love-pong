local IAController = {}

IAController.update = function(ent, world, dt)
    local targetY = world.ball.y
    local dir = targetY - (ent.y + ent.length/2)
    local speed = 6

    ent.y = ent.y + dir * dt * speed
end

return IAController