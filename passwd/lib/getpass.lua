local term = require("term")

function getpass(prompt)
  prompt = prompt or "password"
  term.write(prompt .. ": ")
  local password = term.read({["pwchar"]="*"})
  password = password:sub(1, -2)
  term.write("\n")
  return password
end

return getpass