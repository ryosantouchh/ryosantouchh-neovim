return {
  'vyfor/cord.nvim',
  build = ':Cord update',
  opts = {
    timestamp = {
      enabled = false,
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
