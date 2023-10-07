local IAController = {}

IAController.update = function(ent, world, dt)
    local targetY = world.ball.y
    local dir = targetY - (ent.y + ent.length/2)
    local speed = 250

    if dir < 0 then dir = -1
    elseif dir > 0 then dir = 1
    else dir = 0 end

    if math.abs(ent.x - world.ball.x) < 250 then
        ent.y = ent.y + dir * dt * speed
    end
end

return IAController