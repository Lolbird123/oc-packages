local fs = require("filesystem")
local getpass = require("getpass")

if not fs.exists("/etc/passwd") then
  local f 
  f = io.open("/etc/profile.lua", "a")
  f:write("\ndofile(\"/usr/bin/lock.lua\")")
  f:close()
  local password, confirm
  while true do
    password = getpass()
    confirm = getpass("confirm password")
    if password == confirm then
      break
    else
      print("passwords do not match")
    end
  end
  f = io.open("/etc/passwd", "w")
  f:write(password)
  f:close()
else
  io.stderr:write("passwd has already been set up, use the passwd command to change the password")
end