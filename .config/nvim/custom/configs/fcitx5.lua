local M = {}
M.Fcitx5en = function ()
  -- local status = vim.fn.system("fcitx5-remote")
  vim.fn.system("fcitx5-remote -c")
end

-- vim.cmd[[ au InsertEnter * lua require("custom.configs.fcitx5").Fcitx5zh() ]]
vim.cmd[[ au InsertLeave * lua require("custom.configs.fcitx5").Fcitx5en() ]]

return M
