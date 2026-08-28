return {
  'vyfor/cord.nvim',
  build = ':Cord update',
  opts = {
    timestamp = {
      enabled = true,
      reset_on_change = false,
      reset_on_idle = false,
      shared = true,
    },
    idle = {
      enabled = false,
    },
    display = {
      theme = "atom",
      flavor = "dark",
    },
    text = {
      editing = function(opts) return "Cooking " .. opts.filename end,
      workspace = function() return nil end,
      viewing = function(opts) return "Reading the recipe: " .. opts.filename end,
      workspace = function() return nil end,
      plugin_manager = function() return nil end,
    },
  }
}
