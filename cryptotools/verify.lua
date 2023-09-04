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
  print("-p --path <path> : set a custom path to load public key from instead of /home/default.pub")
  print("-s --sig <name> : specify a custom signature suffix instead of .sig") 
  return
end

local key_path = opts["path"] or opts["p"] or "/home/default.pub"
local sigsuf = opts["sig"] or opts["s"] or ".sig"
local file = shell.resolve(args[1])

if not filesystem.exists(file) then
  print("file not found")
  return
end
if not filesystem.exists(key_path) then
  print("public key not found")
  return
end
local f
f = filesystem.open(file, "r")
local content = f:read(math.huge)
f:close()
f = filesystem.open(key_path, "r")
local key = f:read(math.huge)
f:close()
key = data.deserializeKey(key, "ec-public")
f = filesystem.open(file..sigsuf, "r")
local sig = f:read(math.huge)
f:close()
print(data.ecdsa(content, key, sig))
