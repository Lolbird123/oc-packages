local component = require("component")
local filesystem = require("filesystem")
local shell = require("shell")
local args, opts = shell.parse(...)

if not component.data or not component.data.ecdsa then
  print("a data card of tier 3 is required")
  return
end
local data = component.data

if opts["help"] or opts["h"] or not args[1] then
  print("sign [options] <file>")
  print("-h --help : show this")
  print("-p --path <path> : set a custom path to load keys from instead of /home")
  print("-n --name <name> : set a custom name to save keys as instead of default")
  return
end

local path = opts["path"] or "/home"
local name = opts["name"] or "default"
local file = shell.resolve(args[1])

if not filesystem.exists(file) then
  print("file not found")
  return
end
