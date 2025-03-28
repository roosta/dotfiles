function conky_vpn()
  local handle = io.popen("pgrep -a openvpn")
  local result = handle:read("*a")
  handle:close()
  local match = string.match(result, "Air.-%d%d%d")

  if match ~= nil then
    return string.format("${color 98BC37}%s", match)
  else
    return "${color FF3128}No VPN detected"
  end
end
