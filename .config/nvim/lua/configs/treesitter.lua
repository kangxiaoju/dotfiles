require("nvim-treesitter.configs").setup(astronvim.user_plugin_opts("plugins.treesitter", {
  ensure_installed = { "cpp", "c", "python", "go", "rust", "json", "yaml", "html", "vue", "typescript", "sql", "java", "scss", "toml", "yaml" }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  rainbow = {
    enable = true,
    disable = { "html" },
    extended_mode = false,
    max_file_lines = nil,
  },
  autotag = { enable = true },
  incremental_selection = { enable = true },
  indent = { enable = false },
}))
