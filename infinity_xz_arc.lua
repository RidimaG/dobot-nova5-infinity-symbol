-- Smooth vertical infinity symbol in the XZ plane (two tangent circles), looping forever
-- Dobot Nova 5, user coordinate 0, tool coordinate 0

-- Current pose of the robot (top tip of the symbol). Replace with your own pose.
local X0, Y0, Z0 = -274.6211, -304.6503, 586.9308
local RX, RY, RZ = 177.4595, -4.6409, -94.6083

local R     = 75     -- circle radius in mm (total height = 4*R, width = 2*R)
local blend = 10     -- blend radius in mm between arcs (set to 0 if rejected)

-- Crossing point of the 8, directly below the current position
local Xc = X0
local Zc = Z0 - 2 * R

-- Helper: pose in the XZ plane (Y stays fixed)
local function P(x, z)
    return {pose = {x, Y0, z, RX, RY, RZ}}
end

User(0)
Tool(0)
VelL(20)
AccL(20)

-- Go to the crossing point first
MovL(P(Xc, Zc))

local opt = {r = blend}

while true do
    -- Upper circle, counterclockwise (centre at Zc + R)
    Arc(P(Xc + R, Zc + R), P(Xc, Zc + 2 * R), opt)   -- crossing -> right -> top
    Arc(P(Xc - R, Zc + R), P(Xc, Zc), opt)           -- top -> left -> crossing

    -- Lower circle, clockwise (centre at Zc - R)
    Arc(P(Xc + R, Zc - R), P(Xc, Zc - 2 * R), opt)   -- crossing -> right -> bottom
    Arc(P(Xc - R, Zc - R), P(Xc, Zc), opt)           -- bottom -> left -> crossing
end
