local fs = require("filesystem");

local fileSize = fs.size("/etc/password");
local file1 = io.open("/etc/password", "r");
local password = file1.stream:read(fileSize);
file1.stream:close();

io.write("Current password: ");
local input1 = io.read();
if input1 == password then
  io.write("New password: ");
  local input2 = io.read();
  io.write("Confirm password: ");
  local input3 = io.read();
  if input2 == input3 then
    fs.remove("/etc/password");
    local file2 = io.open("/etc/password", "w");
    file2.stream:write(input2);
    file2.stream:close();
    print("Password updated.");
  else
    print("Passwords do not match.");
  end
else
  print("Incorrect.");
end
