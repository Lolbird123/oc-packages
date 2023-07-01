local getpass = require("getpass")

local password = getpass()
local confirm = getpass("confirm password")
if password == confirm then
  local f = io.open("/etc/passwd", "w")
  f:write(password)
  f:close()
else
  print("passwords do not match, nothing changed")
end