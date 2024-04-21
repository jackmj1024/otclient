-- Reference to the main jump game window:
jumpWindow = nil

-- Reference the moving jump button:
jumpButton = nil

-- The time in milliseconds to wait before moving positions:
BUTTON_MOVE_DELAY = 100

-- The distance for the button to move per movement call:
BUTTON_MOVE_DISTANCE = 10

-- The X position for the button to start at after jumping:
BUTTON_X_START = 200

-- The range of potential Y values for the button to jump to:
BUTTON_Y_MIN = 10
BUTTON_Y_MAX = 200

function init()
	-- Import the .otoi file.
	g_ui.importStyle('jumpwindow')
	
	-- Connect window callbacks.
	connect(g_game, { onJumpWindow = onJumpWindow,
				onGameEnd = destroyWindow})

	-- Get the instance of this window if one already exists.
	local window = rootWidget:recursiveGetChildById('jumpWindow')
	if window then
		jumpWindow = window
	end
	
end

function terminate()
	-- Disconnect window callbacks.
	disconnect(g_game, { onJumpWindow = onJumpWindow,
				onGameEnd = destroyWindow})
end

function destroyWindow()
	-- Destroy this window and reset references.
	if jumpWindow then
		jumpWindow:destroy()
		jumpWindow = nil
		jumpButton = nil
	end
end

function onJumpWindow()
	-- Return if the window has already been drawn.
	if jumpWindow then
		return
	end

	-- Draw the window.
	jumpWindow = g_ui.createWidget('JumpWindow', rootWidget)
	
	-- Get a reference to the jump button.
	jumpButton = jumpWindow:recursiveGetChildById('jumpButton')

	-- Initialize the jump button movement behaviour.
	startButtonMovement()
end

function startButtonMovement()
	-- Start the recursive movement sequence.
       	scheduleEvent(function() buttonMove() end, BUTTON_MOVE_DELAY)
end

function buttonMove()
	-- Return if the jumpButton reference has not been set.
	if not jumpButton then
		return
	end
	
	-- Change X position by the defined amount.
	local newX = jumpButton:getMarginLeft() - BUTTON_MOVE_DISTANCE
	jumpButton:setMarginLeft(newX)
	
	if newX < 10 then
		buttonJump()
	end
	
	-- Recursively schedule this method to continue moving.
       	scheduleEvent(function() buttonMove() end, BUTTON_MOVE_DELAY)
end

function buttonJump()
	-- Jump to a random Y position.
	local newY = math.random(BUTTON_Y_MIN, BUTTON_Y_MAX)
	jumpButton:setMarginTop(newY)

	-- Reset the X position back to the start.
	jumpButton:setMarginLeft(BUTTON_X_START)
end

function execute(protocol, opcode, buffer)
	-- Draw a new instance of the window.
	onJumpWindow()
end

-- Sets "execute" function to run whenever opcode 99 is recieved.
ProtocolGame.registerExtendedOpcode(99, execute)
