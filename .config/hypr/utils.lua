-- Creates workspace rules for a provided monitor
-- I.E utils.add_workspaces("DP-1", {1,2,3,4,5,6,7,8,9,10}, 1)
local function add_workspaces(monitor, ids, default_id)
  for _, id in ipairs(ids) do
    local rule = {
      workspace = tostring(id),
      monitor = monitor,
      persistent = true
    }
    if id == default_id then rule.default = true end
    hl.workspace_rule(rule)
    hl.dispatch(hl.dsp.workspace.move({ workspace = id, monitor = monitor }))
  end
end

-- Collects all workspaces to a single monitor
local function collect_workspaces(monitor)
  for _, w in ipairs(hl.get_workspaces() or {}) do
    hl.dispatch(hl.dsp.workspace.move({
      workspace = tostring(w.id),
      monitor = monitor,
    }))
  end
end

-- Waits until all monitors in `expected` (list of output names) are
-- connected, then runs `callback` once. Already-connected monitors count.
local function when_monitors_ready(expected, callback)
  local remaining = {}
  local count = 0
  for _, name in ipairs(expected) do
    remaining[name] = true
    count = count + 1
  end

  local function mark(name)
    if remaining[name] then
      remaining[name] = nil
      count = count - 1
      if count == 0 then callback() end
    end
  end

  -- Account for monitors already connected
  for _, m in ipairs(hl.get_monitors() or {}) do
    mark(m.name)
  end

  if count == 0 then return end

  -- Wait for the rest
  hl.on("monitor.added", function(m)
    mark(m.name)
  end)
end

local function log(val)
  hl.notification.create({
    text = val,
    timeout = 5000,
    icon = "ok",
  })
end

return {
  add_workspaces = add_workspaces,
  collect_workspaces = collect_workspaces,
  when_monitors_ready = when_monitors_ready,
  log = log,
}


