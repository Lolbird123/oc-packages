local fs = require("filesystem");
local shell = require("shell");

local fileSize = fs.size("/etc/password");
local file = io.open("/etc/password", "r");
local password = file.stream:read(fileSize);
file.stream:close();

shell.execute("clear");
local correct = false;

while(correct == false)
do
  io.write("Password: ");
  local input = io.read();
  if input == password then
    correct = true;
  else
    print("Incorrect.");
  end
end
