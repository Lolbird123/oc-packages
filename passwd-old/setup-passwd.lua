local fs = require("filesystem");
if fs.exists("/etc/password") == false then
  local file = io.open("/etc/password", "w");
  file.stream:write("password");
  file.stream:close();
end
local file2 = io.open("/etc/profile.lua", "a");
file2.stream:write("\ndofile(\"/usr/bin/lock.lua\")");
file2.stream:close();
