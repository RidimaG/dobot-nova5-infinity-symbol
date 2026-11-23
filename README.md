# dobot-nova5-infinity-symbol
Lua program for the Dobot Nova 5 that draws a smooth, infinity symbol in the plane using Arc commands, looping forever.
# Dobot Nova 5 – Infinity Symbol (Lua)

A small Lua program for the **Dobot Nova 5** that draws a vertical infinity symbol (∞ standing upright, like an 8) in the **XZ plane** and repeats it in an endless loop.

The symbol is built from two tangent circles and drawn with `Arc` commands, so the robot moves in one continuous, smooth motion instead of many tiny steps.

## Features

- Vertical infinity symbol in the XZ plane (Y stays fixed)
- Only 4 `Arc` commands per loop, so no step-like motion or vibration
- Size controlled by a single value (`R`)
- Orientation (RX, RY, RZ) stays constant during the motion
- Runs forever until you stop the program

## Requirements

- Dobot Nova 5 with the V4 controller
- DobotStudio Pro (Lua project)
- User coordinate system 0 and tool coordinate system 0

## Usage

1. Jog the robot to the position where the top tip of the symbol should be.
2. Open `infinity_xz_arc.lua` and copy your current pose into these lines:
   ```lua
   local X0, Y0, Z0 = -274.6211, -304.6503, 586.9308
   local RX, RY, RZ = 177.4595, -4.6409, -94.6083
   ```
3. Copy the script into a Lua project in DobotStudio Pro (for example `src0.lua`).
4. Make sure the area is clear. The symbol spans `4 * R` in Z (downwards from the start) and `2 * R` in X.
5. Run at low speed first, with a hand on the emergency stop.

## Parameters

| Name    | Default | Meaning                                                      |
|---------|---------|--------------------------------------------------------------|
| `R`     | 75      | Circle radius in mm. Height = 4·R, width = 2·R               |
| `blend` | 10      | Blend radius in mm between arcs. Set to 0 if the controller rejects it |
| `VelL`  | 20      | Linear speed in %                                            |
| `AccL`  | 20      | Linear acceleration in %                                     |

## How it works

The crossing point of the 8 is placed `2·R` below the start pose. The upper circle is drawn counterclockwise and the lower circle clockwise. At the crossing point both circles have the same direction of travel, so the robot passes through without stopping.

## Troubleshooting

- **`attempt to call a nil value (global 'SpeedL')`**: `SpeedL` does not exist. Use `VelL` for linear speed.
- **Out of reach or singularity error**: reduce `R` (for example to 60) or move the start pose closer to the robot.
- **Blend radius rejected**: set `blend = 0` or remove the `opt` argument.
- **Still vibrates**: lower `VelL` and `AccL` to 10.

## Safety

This program moves a real robot. Check that nothing is inside the path (table, fixtures, tools), run at low speed first, and keep the emergency stop within reach. Use at your own risk.

