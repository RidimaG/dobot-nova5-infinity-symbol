-- Version 3: Vertical infinity symbol (lemniscate) in the XZ plane, looping forever
-- Dobot Nova 5, user coordinate 0, tool coordinate 0
-- Note: 240 short MovL segments with blend radius. Still showed baby steps / vibration
-- on the real robot. See ../infinity_xz_arc.lua for the smooth Arc version.

-- Current pose (start point = top tip of the symbol). Replace with your own pose.
local X0, Y0, Z0 = -274.6211, -304.6503, 586.9308
local RX, RY, RZ = 177.4595, -4.6409, -94.6083

local a      = 150    -- half-height along Z in mm (total height = 2*a)
local kx     = 2.0    -- width stretch factor along X
local points = 240    -- points per loop (more = smoother)
local blend  = 2      -- blend radius in mm (must stay below half the point spacing)

-- Center of the symbol: shifted so t = 0 lands on the current position
local cx = X0
local cz = Z0 - a

User(0)
Tool(0)
VelL(30)
AccL(30)

-- Go to the start point first (normal move, stops there)
MovL({pose = {X0, Y0, Z0, RX, RY, RZ}})

-- Build the point list once (the last point is not repeated, the loop wraps around)
local path = {}
for i = 0, points - 1 do
    local t = 2 * math.pi * i / points
    local d = 1 + math.sin(t) ^ 2
    local along = a * math.cos(t) / d                       -- long axis (Z)
    local cross = kx * a * math.sin(t) * math.cos(t) / d    -- short axis (X)
    path[#path + 1] = {cx + cross, Y0, cz + along, RX, RY, RZ}
end

-- Draw forever
while true do
    for i = 1, #path do
        MovL({pose = path[i]}, {r = blend})
    end
end
