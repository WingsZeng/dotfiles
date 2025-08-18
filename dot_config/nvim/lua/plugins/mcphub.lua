return {
  "ravitemer/mcphub.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  event = "User AstroFile",
  cmd = "MCPHub",
  build = "bundled_build.lua",
  opts = {
    auto_approve = true,
    use_bundled_binary = true,
  },
}
