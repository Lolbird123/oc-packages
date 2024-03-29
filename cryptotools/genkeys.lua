local component = require("component")
local filesystem = require("filesystem")
local shell = require("shell")
local term = require("term")
local args, opts = shell.parse(...)

if not component.data or not component.data.generateKeyPair then
  print("a data card of tier 3 is required")
  return
end
local data = component.data

if opts["help"] or opts["h"] then
  print("genkeys [options]")
  print("-h --help : show this")
  print("-p --path=<path> : set a custom path to save keys to instead of /home/default.<type>")
  print("-b --bits <bits> : set a custom bit length instead of 384")
  print("-q --quiet : dont ask questions")
  return
end

local path = opts["path"] or opts["p"] or "/home/default"
local bits = tonumber(opts["bits"]) or 384
local pub, priv = data.generateKeyPair(bits)
pub = pub.serialize()
priv = priv.serialize()

if (filesystem.exists(path..".pub") or filesystem.exists(path..".priv")) and not opts["q"] and not opts["quiet"] then
  print("keys already exist at this path, and will be overwritten")
  term.write("are you sure? [y/n]: ")
  local answer = term.read()
  answer = string.sub(answer, 1, 1)
  if answer ~= "y" and answer ~= "Y" then
    print("cancelled")
    return
  end
end

local f
f = filesystem.open(path..".pub", "w")
f:write(pub)
f:close()
f = filesystem.open(path..".priv", "w")
f:write(priv)
f:close()
