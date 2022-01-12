-- This is an example init file , its supposed to be placed in /lua/custom/

-- This is where your custom modules and plugins go.
-- Please check NvChad docs if you're totally new to nvchad + dont know lua!!

-- NOTE: the 4th argument in the map function can be a table i.e options but its most likely un-needed so dont worry about it

-- Install plugins
local customPlugins = require "core.customPlugins"

customPlugins.add(function(use)
  -- 平滑滚动
  use {
    "karb94/neoscroll.nvim",
    opt = true,
    config = function()
      require("neoscroll").setup()
    end,

    -- lazy loading
    setup = function()
      require("core.utils").packer_lazy_load "neoscroll.nvim"
    end,
  }

  -- 自动打开上次浏览位置
  use {
    "farmergreg/vim-lastplace"
  }

  -- 快速注释
  use {
    "tpope/vim-commentary",
    keys = "g",
  }

  -- 历史修改记录
  use {
    "mbbill/undotree",
    opt = true,
    cmd = "UndotreeToggle",
  }

  -- 多光标
  use {
    "mg979/vim-visual-multi",
    keys = "<C-n>",
  }

  -- 快速选中
  use {
    "gcmt/wildfire.vim",
    keys = "<CR>",
  }

  -- 快速分析启动时间
  use {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
  }

  -- 编辑只读文件
  use {
    "lambdalisue/suda.vim",
    cmd = "SudaWrite",
  }

  -- 现代任务系统
  use {
    "skywind3000/asynctasks.vim",
    requires = "skywind3000/asyncrun.vim",
    cmd = {"AsyncTask", "AsyncTaskEdit"},
  }

  -- 函数列表
  use {
    "liuchengxu/vista.vim",
    cmd = "Vista",
  }

  -- markdown预览
  use {
    "iamcco/markdown-preview.nvim",
    run = "cd app && yarn install",
    ft = "markdown",
  }

  -- 小地图
  use {
    "wfxr/minimap.vim",
    -- run = "cargo install --locked code-minimap",
    config = function()
      require("custom.configs.minimap")
    end,
  }

end)

-- 按键映射
require "custom.custom_mappings"
-- fcitx5自动切换输入法 
require "custom.configs.fcitx5"

