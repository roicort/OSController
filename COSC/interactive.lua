-- Project: Business Sample App
--
-- File name: photogallery.lua
--
-- Author: Corona Labs
--
-- Abstract: Display a gallery of photo thumbnails.
--
--
-- Target devices: simulator, device
--
-- Sample code is MIT licensed, see http://www.coronalabs.com/links/code/license
-- Copyright (C) 2013 Corona Labs Inc. All Rights Reserved.
---------------------------------------------------------------------------------------
--[[

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in the
Software without restriction, including without limitation the rights to use, copy,
modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
and to permit persons to whom the Software is furnished to do so, subject to the
following conditions:

The above copyright notice and this permission notice shall be included in all copies
or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.

]]--
---------------------------------------------------------------------------------------
local composer = require( "composer" )
local scene = composer.newScene()

local widget = require("widget")
local myApp = require("myapp")

widget.setTheme(myApp.theme)


local socket = require( "socket" ) 

local function connectToServer( ip, port, message )
    local sock, err = socket.connect( ip, port )
    if sock == nil then
        return false
    end
    sock:settimeout( 0 )
    sock:setoption( "tcp-nodelay", true )  --disable Nagle's algorithm
    sock:setoption( "keepalive", true )
    sock:send("/filter", message)
    print("OK")
    return sock
end

--local slideView = require( "slideView" )

function scene:create( event )
    local sceneGroup = self.view

    local background = display.newRect(0,0,display.contentWidth, display.contentHeight)
    background:setFillColor( 0.95, 0.95, 0.95 )
    background.x = display.contentWidth / 2
    background.y = display.contentHeight / 2

    sceneGroup:insert(background)

    local navBar = widget.newNavigationBar({
        title = "OSC",
        backgroundColor = { 0.96, 0.62, 0.34 },
        titleColor = {1, 1, 1},
        font = myApp.fontBold
    })
	sceneGroup:insert(navBar)
	
	local widget = require( "widget" )
     
-- Slider listener
local function sliderListener( event )
    print( "Slider at " .. event.value .. "%" )
    connectToServer("localhost",8080,event.value)
end
 
-- Create the widget
local slider = widget.newSlider(
    {
        x = display.contentCenterX,
        y = display.contentCenterY,
        width = 400,
        value = 10,  -- Start slider at 10% (optional)
        listener = sliderListener
    }
)

sceneGroup:insert(slider)


 
end

function scene:show( event )
    local sceneGroup = self.view
    
end

function scene:hide( event )
    local sceneGroup = self.view

    --
    -- Clean up any native objects and Runtime listeners, timers, etc.
    --
    
end

function scene:destroy( event )
    local sceneGroup = self.view
    
end


---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene
