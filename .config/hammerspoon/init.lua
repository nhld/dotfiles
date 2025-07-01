-- luacheck: globals hs
-- Enhanced Battery-Optimized Mouse Control
-- alt + hjkl for movement with diagonal support, alt + f for left click
local baseSpeed = 2
local acceleration = 1.15
local maxSpeed = 60
local frameRate = 60

-- Movement state
local movement = {
  active = false,
  dx = 0,
  dy = 0,
  currentSpeed = baseSpeed,
  timer = nil,
  frameCount = 0,
  keys = { h = false, j = false, k = false, l = false },
}

-- Calculate direction from pressed keys
local function getDirection()
  local dirX, dirY = 0, 0

  if movement.keys.h then
    dirX = dirX - 1
  end
  if movement.keys.l then
    dirX = dirX + 1
  end
  if movement.keys.k then
    dirY = dirY - 1
  end
  if movement.keys.j then
    dirY = dirY + 1
  end

  -- Normalize diagonal movement to maintain consistent speed
  if dirX ~= 0 and dirY ~= 0 then
    local magnitude = math.sqrt(dirX * dirX + dirY * dirY)
    dirX = dirX / magnitude
    dirY = dirY / magnitude
  end

  return dirX, dirY
end

-- Force cursor visibility when moving
-- local function ensureCursorVisible()
-- hs.mouse.absolutePosition(hs.mouse.absolutePosition())
-- Alternative method if the above doesn't work:
-- hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.mouseMoved, hs.mouse.absolutePosition()):post()
-- end

-- Move mouse
local function smoothMove()
  local pos = hs.mouse.absolutePosition()
  hs.mouse.absolutePosition {
    x = pos.x + movement.dx,
    y = pos.y + movement.dy,
  }

  -- ensureCursorVisible()

  -- Accelerate every few frames
  movement.frameCount = movement.frameCount + 1
  if movement.frameCount >= 3 and movement.currentSpeed < maxSpeed then
    movement.frameCount = 0
    movement.currentSpeed = movement.currentSpeed * acceleration
    local dirX, dirY = getDirection()
    movement.dx = dirX * movement.currentSpeed
    movement.dy = dirY * movement.currentSpeed
  end
end

-- Update movement based on current keys
local function updateMovement()
  local dirX, dirY = getDirection()

  if dirX == 0 and dirY == 0 then
    -- Stop movement
    movement.active = false
    if movement.timer then
      movement.timer:stop()
      movement.timer = nil
    end
    return
  end

  -- Start or continue movement
  if not movement.active then
    movement.currentSpeed = baseSpeed
    movement.frameCount = 0
    movement.active = true
    movement.timer = hs.timer.new(1 / frameRate, smoothMove)
    movement.timer:start()
  end

  movement.dx = dirX * movement.currentSpeed
  movement.dy = dirY * movement.currentSpeed
end

-- Key handlers
local function keyDown(key)
  movement.keys[key] = true
  updateMovement()
end

local function keyUp(key)
  movement.keys[key] = false
  updateMovement()
end

-- Enhanced bindings that handle simultaneous presses better
hs.hotkey.bind({ "alt" }, "h", function()
  keyDown "h"
end, function()
  keyUp "h"
end)

hs.hotkey.bind({ "alt" }, "j", function()
  keyDown "j"
end, function()
  keyUp "j"
end)

hs.hotkey.bind({ "alt" }, "k", function()
  keyDown "k"
end, function()
  keyUp "k"
end)

hs.hotkey.bind({ "alt" }, "l", function()
  keyDown "l"
end, function()
  keyUp "l"
end)

-- Left click
hs.hotkey.bind({ "alt" }, "f", function()
  hs.eventtap.leftClick(hs.mouse.absolutePosition())
end)

-- Optional: Add right click
hs.hotkey.bind({ "alt" }, "d", function()
  hs.eventtap.rightClick(hs.mouse.absolutePosition())
end)

hs.alert.show "Enhanced mouse control loaded!\nalt+hjkl to move (diagonals supported)\nalt+f for left click, alt+d for right click"
