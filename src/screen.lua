local Screen = {}

Screen.nativeWidth = 640
Screen.nativeHeight = 360
Screen.screenWidth, Screen.screenHeight = love.window.getMode()
Screen.xScaleFactor = Screen.screenWidth / Screen.nativeWidth
Screen.yScaleFactor = Screen.screenHeight / Screen.nativeHeight

function love.resize(w, h)
    Screen.xScaleFactor = w / Screen.nativeWidth
    Screen.yScaleFactor = h / Screen.nativeHeight
end

return Screen