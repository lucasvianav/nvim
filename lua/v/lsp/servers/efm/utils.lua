local M = {}

---@overload fun(config: EfmExtensionConfig?): EfmExtensionConfig|table<nil, nil>
---@overload fun(extension_name: string, config: EfmExtensionConfig?): EfmExtensionConfig|table<nil, nil>
function M.if_enabled(...)
  local args, extension_name, config = { ... }, nil, nil

  assert(1 <= #args and #args <= 2)

  if type(args[1]) == "string" then
    extension_name = args[1]
    config = args[2]
  elseif type(args[1]) == "table" then
    config = args[1]
    extension_name = nil
  end

  local enabled = config and config.enabled ~= false

  if extension_name then
    local local_config = (v.local_config.efm or {})[extension_name] or {}
    local local_config_enabled = local_config.enabled ~= false
    enabled = enabled and local_config_enabled
  end

  return enabled and config or {}
end

return M
