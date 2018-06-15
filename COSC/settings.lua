-- Project: Business Sample App
--
-- File name: registration.lua
--
-- Author: Corona Labs
--
-- Abstract: show how to create a data input form and store it in a database table
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
local widget = require( "widget" )
local json = require( "json" )
local widgetExtras = require( "widget-extras" )
local myApp = require( "myapp" )

widget.setTheme(myApp.theme)

local titleText
local navBar
local IPLabel
local IPField
local portLabel
local portField

IP = "IP: Example 127.0.0.0"
Port = "Port: Example 8008"

local submitButton

local function ignoreTouch( event )
	return true
end

local function fieldHandler( textField )
	return function( event )
		if ( "began" == event.phase ) then
			-- This is the "keyboard has appeared" event
			-- In some cases you may want to adjust the interface when the keyboard appears.
		
		elseif ( "ended" == event.phase ) then
			-- This event is called when the user stops editing a field: for example, when they touch a different field
			
		elseif ( "editing" == event.phase ) then
		
		elseif ( "submitted" == event.phase ) then
			-- This event occurs when the user presses the "return" key (if available) on the onscreen keyboard
			
			-- Hide keyboard
			native.setKeyboardFocus( nil )
		end
	end
end


local function submitForm( event )
	local record = {}
	print(IPField.text)
	IP = IPField.text	
	print(portField.text)
	Port = portField.text	
	composer.hideOverlay()
end

function scene:create( event )
	local sceneGroup = self.view

    local background = display.newRect(0,0,display.contentWidth, display.contentHeight)
    background:setFillColor( 0.95, 0.95, 0.95 )
    background.x = display.contentWidth / 2
    background.y = display.contentHeight / 2

    sceneGroup:insert(background)

    navBar = widget.newNavigationBar({
        title = "Settings",
        backgroundColor = { 0.96, 0.62, 0.34 },
        titleColor = {1, 1, 1},
        font = myApp.fontBold, 
        leftButton = leftButton
    })
    sceneGroup:insert(navBar)

    IPLabel = display.newText( "IP", 10, navBar.y + navBar.height + 30, native.systemFont, 18 )
	IPLabel:setFillColor( 0.3, 0.3, 0.3 )
	IPLabel.anchorX = 0
	sceneGroup:insert( IPLabel )

	portLabel = display.newText( "Port", 10, IPLabel.y + 40, native.systemFont, 18 )
	portLabel:setFillColor( 0.3, 0.3, 0.3 )
	portLabel.anchorX = 0
	sceneGroup:insert( portLabel )
end

function scene:show( event )
	local sceneGroup = self.view

	if event.phase == "did" then
		-- The text field's native peice starts hidden, we show it after we are on screen.on

		-- lets make the fields fit our adaptive screen better
		-- Why 150? The labels are around 120px wide. We want at least a 10px margin on either side of the labels
		-- and fields and we need some space betwen the label and the field. Let's start with 10px each

		local fieldWidth = display.contentWidth - 150
		if fieldWidth > 250 then
			fieldWidth = 250
		end

		IPField = native.newTextField( 130, IPLabel.y, fieldWidth, 30 )
		IPField:addEventListener( "userInput", fieldHandler( function() return IPField end ) ) 
		sceneGroup:insert( IPField)
		IPField.anchorX = 0
		IPField.placeholder = IP

		portField = native.newTextField( 130, portLabel.y, fieldWidth, 30 )
		portField:addEventListener( "userInput", fieldHandler( function() return portField end ) ) 
		sceneGroup:insert( portField )
		portField.anchorX = 0
		portField.placeholder = Port

	    --
	    -- For sake of keeping this a reasonable sample app, we will not demonstate
	    -- password fields.
	    --
	    -- Passwords should be stored in your database using a one way encryption. This 
	    -- encryption should include the addition of a SALT string being added to make 
	    -- the password more complex than the user provided. 
	    --
	    -- Then when validating the login process (taking the login password and seeing if it
	    -- matches), you re-encrypt the entered password after applying the SALT string and then
	    -- you check if the two encrypted passwords match. This process, while not difficult takes
	    -- the scope of this project beyond what we are trying to demo for you.
	    --
	    -- Please make sure in real world applications of this, you take the time to properly secure
	    -- your apps data.
	    --

	    submitButton = widget.newButton({
	        width = 160,
	        height = 40,
	        label = "Submit",
	        labelColor = { 
	            default = { 0.90, 0.60, 0.34 }, 
	            over = { 0.79, 0.48, 0.30 } 
	        },
	        labelYOffset = -4, 
	        font = myApp.font,
	        fontSize = 18,
	        emboss = false,
	        onRelease = submitForm
	    })
		submitButton.x = display.contentCenterX
		submitButton.y = display.contentCenterY
	    sceneGroup:insert( submitButton )
	end
end

function scene:hide( event )
	local sceneGroup = self.view

	--
	-- Clean up native objects
	--

	if event.phase == "will" then
		-- remove the addressField since it contains a native object.
		IPField:removeSelf()
		IPField = nil
		portField:removeSelf()
		portField = nil
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene