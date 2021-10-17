local colors = require("colors");
local component = require("component");
local sides = require("sides");
local shell = require("shell");

local args = shell.parse(...);
local rs = component.redstone;

if args[1] == "on" then
  rs.setBundledOutput(sides.top, {[colors.white] = 255});
elseif args[1] == "off" then
  rs.setBundledOutput(sides.top, {[colors.white] = 0});
elseif args[1] == "check" then
  print(rs.getBundledOutput(sides.top, colors.white));
else
  print("Unknown action.");
end
