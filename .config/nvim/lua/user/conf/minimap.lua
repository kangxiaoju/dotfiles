local status_ok, minimap = pcall(require, "nvim-minimap")
if not status_ok then
  vim.notify("minimap module not found!")
  return
end

minimap.setup({
  default_auto_cmds_enabled = 1,
  window = {
    width = 20,
    height = 20
  }
})
