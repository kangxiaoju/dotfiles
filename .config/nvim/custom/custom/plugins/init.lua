return {
  -- 平滑滚动
  {
    "karb94/neoscroll.nvim",
    opt = true,
    config = function()
      require("neoscroll").setup()
    end,

    -- lazy loading
    setup = function()
      require("core.utils").packer_lazy_load "neoscroll.nvim"
    end,
  },

  -- 自动打开上次浏览位置
  {
    "farmergreg/vim-lastplace"
  },

  -- 快速注释
  {
    "tpope/vim-commentary",
    keys = "g",
  },

  -- 历史修改记录
  {
    "mbbill/undotree",
    opt = true,
    cmd = "UndotreeToggle",
  },

  -- 多光标
  {
    "mg979/vim-visual-multi",
    keys = "<C-n>",
  },

  -- 快速选中
  {
    "gcmt/wildfire.vim",
    keys = "<CR>",
  },

  -- 快速分析启动时间
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
  },

  -- 编辑只读文件
  {
    "lambdalisue/suda.vim",
    cmd = "SudaWrite",
  },

  -- 现代任务系统
  {
    "skywind3000/asynctasks.vim",
    requires = "skywind3000/asyncrun.vim",
    cmd = {"AsyncTask", "AsyncTaskEdit"},
  },

  -- 函数列表
  {
    "liuchengxu/vista.vim",
    cmd = "Vista",
  },

  -- markdown预览
  {
    "iamcco/markdown-preview.nvim",
    run = "cd app && yarn install",
    ft = "markdown",
  },

  -- 小地图
  {
    "wfxr/minimap.vim",
    -- run = "cargo install --locked code-minimap",
    config = function()
      require("custom.plugins.minimap")
    end,
  },

  {
     "windwp/nvim-ts-autotag",
     ft = { "html", "javascriptreact" },
     after = "nvim-treesitter",
     config = function()
        require("nvim-ts-autotag").setup()
     end,
  },

  {
     "jose-elias-alvarez/null-ls.nvim",
     after = "nvim-lspconfig",
     config = function()
        require("custom.plugins.null-ls").setup()
     end,
  },

  {
     "nvim-telescope/telescope-media-files.nvim",
     after = "telescope.nvim",
     config = function()
        require("telescope").setup {
           extensions = {
              media_files = {
                 filetypes = { "png", "webp", "jpg", "jpeg" },
              },
              -- fd is needed
           },
        }
        require("telescope").load_extension "media_files"
     end,
  },

  {
     "Pocco81/TrueZen.nvim",
     cmd = {
        "TZAtaraxis",
        "TZMinimalist",
        "TZFocus",
     },
     config = function()
        require "custom.plugins.truezen"
     end,
  },
}
