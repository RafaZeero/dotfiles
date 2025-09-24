return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- Whenever update plugin, call this cmd
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        modules = {},
        sync_install = false,
        ensure_installed = {
          "python",
          "javascript",
          "typescript",
          "regex",
          "dockerfile",
          "toml",
          "json",
          "go",
          "gitignore",
          "graphql",
          "yaml",
          "make",
          "tsx",
          "css",
          "html",
          "bash",
          "c",
          "diff",
          "html",
          "lua",
          "luadoc",
          "markdown",
          "markdown_inline",
          "query",
          "vim",
          "vimdoc",
          "c_sharp",
        },
        auto_install = false,
        ignore_install = { "javascript" },
        highlight = {
          enable = true,
          -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
          additional_vim_regex_highlighting = false,
        },
      })
    end,
  },
}
