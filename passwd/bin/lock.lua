local os = require("os")
local getpass = require("getpass")
local password

do
  local f = io.open("/etc/passwd", "r")
  password = f:read("*a")
  f:close()
end

while true do
  os.system("clear")
  local input = getpass()
  if input == password then
    os.system("clear")
    break
  else
    print("incorrect")
    os.sleep(3)
  end
end