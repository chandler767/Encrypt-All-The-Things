---------------------------------------------------------------------------------
--
-- main.lua
--
---------------------------------------------------------------------------------

-- hide the status bar
-- display.setStatusBar( display.HiddenStatusBar )
FullY = display.viewableContentHeight + -1* (display.screenOriginY*2)
FullX = display.viewableContentWidth + -1* (display.screenOriginX*2)
maxVisibleY = display.viewableContentHeight + -1* (display.screenOriginY)
maxVisibleX = display.viewableContentWidth + -1* (display.screenOriginX)
screenWidth = display.contentWidth - (display.screenOriginX*2)
screenHeight = display.contentHeight - (display.screenOriginY*2)
screenTop = display.screenOriginY
screenRight = display.contentWidth - display.screenOriginX
screenBottom = display.contentHeight - display.screenOriginY
screenLeft = display.screenOriginX
screenCenterX = display.contentWidth/2
screenCenterY = display.contentHeight/2

local function checkMem()
   collectgarbage("collect")
   local memUsage_str = string.format( "MEMORY= %.3f KB", collectgarbage( "count" ) )
   print( memUsage_str .. " | TEXTURE= "..(system.getInfo("textureMemoryUsed")/1048576) )
end
--timer.performWithDelay( 1000, checkMem, 0 )

-- require the composer library
local composer = require "composer"

-- load scene1
composer.gotoScene( "enc" )

-- Add any objects that should appear on all scenes below (e.g. tab bar, hud, etc)

