local colors = require("colors");
local component = require("component");
local shell = require("shell");
local sides = require("sides");

local args = shell.parse(...);
local rs = component.redstone;

local function setDoor(side, value)
  if side == "n" then
    rs.setBundledOutput(sides.top, {[colors.red] = value});
  elseif side == "e" then
    rs.setBundledOutput(sides.top, {[colors.orange] = value});
  elseif side == "s" then
    rs.setBundledOutput(sides.top, {[colors.yellow] = value});
  elseif side == "w" then
    rs.setBundledOutput(sides.top, {[colors.green] = value});
  else
    print("Unknown door.");
  end
end


local function getDoor(side)
  if side == "n" then
    if rs.getBundledOutput(sides.top, colors.red) > 0 then
      print("Open");
    else
      print("Closed");
    end
  elseif side == "e" then
    if rs.getBundledOutput(sides.top, colors.orange) > 0 then
      print("Open");
    else
      print("Closed");
    end
  elseif side == "s" then
    if rs.getBundledOutput(sides.top, colors.yellow) > 0 then
      print("Open");
    else
      print("Closed");
    end
  elseif side == "w" then
    if rs.getBundledOutput(sides.top, colors.green) > 0 then
      print("Open");
    else
      print("Closed");
    end
  else
    print("Unknown door.");
  end
end

if args[1] == "open" then
  setDoor(args[2], 255);
elseif args[1] == "close" then
  setDoor(args[2], 0);
elseif args[1] == "check" then
  getDoor(args[2]);
elseif args[1] == "lockdown" then
  setDoor("n",0);
  setDoor("e",0);
  setDoor("s",0);
  setDoor("w",0);
else
  print("Unknown action.");
end
