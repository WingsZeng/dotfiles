return {
  "okuuva/auto-save.nvim",
  event = { "InsertLeave", "TextChanged" },
  opts = {
    execution_message = {
      enabled = false,
    },
    debounce_delay = 100,
  }
}
