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
  print("verify [options] <file>")
  print("-h --help : show this")
  print("-p --path <path> : set a custom path to load keys from instead of /home")
  print("-n --name <name> : set a custom name to save keys as instead of default")
  print("-s --sig <name> : specify a custom signature suffix instead of .sig") 
  return
end

local path = opts["path"] or opts["p"] or "/home"
local name = opts["name"] or opts["n"] or "default"
local sigsuf = opts["sig"] or opts["s"] or ".sig"
local file = shell.resolve(args[1])
local key_file = path.."/"..name..".pub"

if not filesystem.exists(file) then
  print("file not found")
  return
end
if not filesystem.exists(key_file) then
  print("private key not found")
  return
end
local f
f = filesystem.open(file, "r")
local content = f:read(math.huge)
f:close()
f = filesystem.open(key_file, "r")
local key = f:read(math.huge)
f:close()
key = data.deserializeKey(key, "ec-public")
f = filesystem.open(file..sigsuf, "r")
local sig = f:read(math.huge)
f:close()
print(data.ecdsa(content, key, sig))