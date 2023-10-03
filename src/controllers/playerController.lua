local PlayerController = {}

PlayerController.update = function(ent, world, dt)
    local mousePos = love.mouse.getY() / Screen.yScaleFactor

    if mousePos + ent.length/2 < Screen.nativeHeight and mousePos - ent.length/2 > 0 then
        ent.y = mousePos - ent.length/2
    end
end

return PlayerController