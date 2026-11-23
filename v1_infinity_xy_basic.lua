-- Version 1: Infinity symbol (lemniscate) in the XY plane, horizontal, looping forever
-- Dobot Nova 5, user coordinate 0, tool coordinate 0
-- Note: drawn as many short MovL segments, so motion can look step-like.

-- Current pose (start point = right-hand tip of the symbol). Replace with your own pose.
local X0, Y0, Z0 = -274.6211, -304.6503, 586.9308
local RX, RY, RZ = 177.4595, -4.6409, -94.6083

local a      = 50     -- half-width of the symbol in mm (change size here)
local points = 72     -- points per loop (more = smoother, slower)

-- Center is shifted so that t = 0 lands exactly on the current position
local cx = X0 - a
local cy = Y0

User(0)
Tool(0)
VelL(30)   -- linear speed in %
AccL(30)   -- linear acceleration in %

-- Go to the start point first
MovL({pose = {X0, Y0, Z0, RX, RY, RZ}})

-- Build the point list once (lemniscate of Bernoulli)
local path = {}
for i = 0, points do
    local t = 2 * math.pi * i / points
    local d = 1 + math.sin(t) ^ 2
    local x = cx + a * math.cos(t) / d
    local y = cy + a * math.sin(t) * math.cos(t) / d
    path[#path + 1] = {x, y, Z0, RX, RY, RZ}
end

-- Draw forever
while true do
    for i = 1, #path do
        MovL({pose = path[i]}, {cp = 20})   -- cp = smoothing between points
    end
end
