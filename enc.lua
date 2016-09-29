local composer = require( "composer" )
local widget = require( "widget" )
local scene = composer.newScene()
local json = require( "json" )

function scene:create( event )
 
   local sceneGroup = self.view
        display.setDefault( "background", 0.95, 0.95, 0.95, 1 )

        side_top = display.newRect(display.screenOriginX,display.screenOriginY,screenWidth+10,70)
        side_top.anchorX = 0
        side_top.anchorY = 0
        side_top:setFillColor(0,0,0,1)
        sceneGroup:insert( side_top )

        logo_light = display.newImageRect( "logo_light.png", 140, 50)
        logo_light.x, logo_light.y = display.viewableContentWidth/2, display.screenOriginY+42
        sceneGroup:insert( logo_light ) 

        if ((system.getInfo( "platformName" ) == "Mac OS X") or (system.getInfo( "platformName" ) == "Win")) then
            login_background = display.newRect( display.viewableContentWidth/2, display.viewableContentHeight/2, 280, 220 )
            login_background:setFillColor(0,0,0,0.6)
            sceneGroup:insert( login_background ) 
        else
            login_background = display.newRect( display.viewableContentWidth/2, display.viewableContentHeight/2 -70, 280, 220 )
            login_background:setFillColor(0,0,0,0.6)
            sceneGroup:insert( login_background ) 
        end

        local label_login = display.newText("Encrypt:", login_background.x, login_background.y - 80, native.systemFont, 30)
        sceneGroup:insert(label_login)

        local label_text = display.newText("Your Text:", login_background.x - 130, login_background.y - 50, native.systemFont, 18)
        label_text.anchorX = 0
        label_text.anchorY = 0.5
        sceneGroup:insert(label_text)

        local label_pass = display.newText("Method (Tap to change):", login_background.x - 130, login_background.y + 15, native.systemFont, 18)
        label_pass.anchorX = 0
        label_pass.anchorY = 0.5
        sceneGroup:insert(label_pass)
    
        label_method = display.newText("1337", login_background.x, login_background.y + 40, native.systemFont, 23)
        label_method:setTextColor(1, 0, 0)
        sceneGroup:insert(label_method)

        text_input = native.newTextField(login_background.x, label_text.y + 30, 230, 25)
        text_input.inputType = "default"
        text_input.font = native.newFont(native.systemFont, 20)
        text_input.hasBackground = true
        text_input.isEditable = true
        text_input.align = "left"
        text_input.text = ''
        sceneGroup:insert(text_input)

        function label_method:touch( event )
            if event.phase == "ended" then
                if (label_method.text == "1337") then
                    label_method.text = "Caesar"
                elseif (label_method.text == "Caesar") then
                    label_method.text = "Base64"
                elseif (label_method.text == "Base64") then
                    label_method.text = "MD5"
                elseif (label_method.text == "MD5") then
                    label_method.text = "Salsa_20"
                elseif (label_method.text == "Salsa_20") then
                    label_method.text = "SHA1"
                elseif (label_method.text == "ROT13") then
                    label_method.text = "ROT1"    
                else
                    label_method.text = "1337"
                end
            end
        end
        label_method:addEventListener( "touch", label_method )

        local function DoENC( event )
            local function networkListener( event )
                if ( event.isError ) then
                    print( "Network error: ", event.response )
                    native.showAlert("Error", "Failed to connect to API", {"OK"})
                else
                    print ( "RESPONSE: " .. event.response )
                    -- pasteboard.copy( "string", event.response )
                    native.showAlert("Copied", "Encrypted texted copied to clipboard.", {"OK"})
                    --native.showAlert("Copied", "text=" .. text_input.text .. "&method=" .. label_method.text, {"OK"})
                end
            end
            local headers = {}
            headers["Content-Type"] = "application/x-www-form-urlencoded"
            headers["Accept-Language"] = "en-US"
            local body = "text=" .. text_input.text .. "&e_type=" .. label_method.text
            local params = {
                timeout = 2
            }
            params.headers = headers
            params.body = body
            network.request( "http://encryptallthethings.org/new.php", "POST", networkListener, params )
        end

        local btn_ecy = widget.newButton(
            {
                label = "Encrypt",
                onEvent = DoENC,
                emboss = true,
                font = native.systemFontBold,
                fontsize = 25,
                labelColor = {
                    default = {255,255,255},
                    over = {55,55,55}
                },
                shape = "Rect",
                width = 150,
                height = 35,
                fillColor = { default={0.2,0.2,0.2,1}, over={0.4,0.4,0.4,0.4} },
                strokeColor = { default={1,1,1,1}, over={1,1,1,0.8} },
                strokeWidth = 2
            }
        )

        btn_ecy.x = login_background.x
        btn_ecy.y = label_pass.y + 60
        sceneGroup:insert(btn_ecy)

        -- Called when the app's view has been resized
        local function onResize( event )
        -- re-layout the app's contents here 
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

        logo_light.x = display.viewableContentWidth/2
        logo_light.y = display.screenOriginY+42

        side_top.x = display.screenOriginX
        side_top.y = display.screenOriginY
        side_top.width = screenWidth+10
        side_top.height = 70

        end
        -- Add the "resize" event listener
        Runtime:addEventListener( "resize", onResize )
   -- Initialize the scene here.
   -- Example: add display objects to "sceneGroup", add touch listeners, etc.
end
 
-- "scene:show()"
function scene:show( event )
 
   
end
 
-- "scene:hide()"
function scene:hide( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then
      -- Called when the scene is on screen (but is about to go off screen).
      -- Insert code here to "pause" the scene.
      -- Example: stop timers, stop animation, stop audio, etc.
   elseif ( phase == "did" ) then
      -- Called immediately after scene goes off screen.
   end
end
 
-- "scene:destroy()"
function scene:destroy( event )
 
   local sceneGroup = self.view
   
 
   -- Called prior to the removal of scene's view ("sceneGroup").
   -- Insert code here to clean up the scene.
   -- Example: remove display objects, save state, etc.
end
 
---------------------------------------------------------------------------------
 
-- Listener setup

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
 
---------------------------------------------------------------------------------
 
return scene