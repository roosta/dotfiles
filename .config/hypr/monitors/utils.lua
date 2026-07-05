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

return {
  add_workspaces = add_workspaces,
  collect_workspaces = collect_workspaces
}
