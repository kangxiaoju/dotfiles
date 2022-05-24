local M = {}

M.Fcitx5en = function ()
  vim.fn.system("fcitx5-remote -c")
end

vim.cmd[[ au InsertLeave * lua require("user.conf.fcitx5").Fcitx5en() ]]

return M
